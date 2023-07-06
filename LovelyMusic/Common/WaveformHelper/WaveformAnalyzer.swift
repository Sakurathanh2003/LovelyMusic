//
//  WaveformAnalyzer.swift
//  ios-extractToMp3
//
//  Created by linzsc on 06/07/2021.
//

import UIKit
import Foundation
import Accelerate
import AVFoundation

struct WaveformAnalysis {
    let amplitudes: [Float]
    let fft: [TempiFFT]?
}

public class WaveformAnalyzer {
    private let assetReader: AVAssetReader
    private let audioAssetTrack: AVAssetTrack

    public init?(asset: AVAsset) {
        guard let assetReader = try? AVAssetReader(asset: asset) else {
            print("ERROR loading asset")
            return nil
        }
        
        guard let assetTrack = asset.tracks(withMediaType: .audio).first else {
            print("ERROR loading audio track")
            return nil
        }

        self.assetReader = assetReader
        self.audioAssetTrack = assetTrack
    }
    
    /// Returns the calculated waveform of the initialized asset URL.
    public func samles(count: Int, qos: DispatchQoS.QoSClass = .userInitiated, maxPower: CGFloat = 100) async -> [CGFloat]? {
        guard let waveformAnalysis = await waveformSamples(count: count, qos: qos, fftBands: nil) else {
            return nil
        }

        return await withUnsafeContinuation { continuation in
            continuation.resume(returning: self.amplitudeToCGFloat(maxPower: maxPower, amplitudes: waveformAnalysis.amplitudes))
        }
    }
    
    private func amplitudeToCGFloat(maxPower: CGFloat = 700, amplitudes: [Float]) -> [CGFloat] {
        var powers = [CGFloat]()
        let verticalPaddingDivisor: CGFloat = 1
        let drawMappingFactor = maxPower / verticalPaddingDivisor
        let minimumGraphAmplitude: CGFloat = 1 // we want to see at least a 1pt line for silence
        for amplitude in amplitudes {
            let invertedDbSample = 1 - CGFloat(amplitude) // sample is in dB, linearly normalized to [0, 1] (1 -> -50 dB)
            let drawingAmplitude = max(minimumGraphAmplitude, invertedDbSample * drawMappingFactor)
            powers.append(drawingAmplitude)
        }
    
        return powers
    }
}

// MARK: - Private
fileprivate extension WaveformAnalyzer {
    private var silenceDbThreshold: Float { return -50.0 } // everything below -50 dB will be clipped
    
    func waveformSamples(count requiredNumberOfSamples: Int, qos: DispatchQoS.QoSClass, fftBands: Int?) async -> WaveformAnalysis? {
        return await withUnsafeContinuation{ continuation in
            let trackOutput = AVAssetReaderTrackOutput(track: audioAssetTrack, outputSettings: outputSettings())
            assetReader.add(trackOutput)
            assetReader.asset.loadValuesAsynchronously(forKeys: ["duration"]) {
                var error: NSError?
                let status = self.assetReader.asset.statusOfValue(forKey: "duration", error: &error)
                switch status {
                case .loaded:
                    let totalSamples = self.totalSamplesOfTrack()
                    DispatchQueue.global(qos: qos).async {
                        let analysis = self.extract(totalSamples: totalSamples, downsampledTo: requiredNumberOfSamples, fftBands: fftBands)

                        switch self.assetReader.status {
                        case .completed:
                            continuation.resume(returning: analysis)
                        default:
                            print("ERROR: reading waveform audio data has failed \(self.assetReader.status)")
                            continuation.resume(returning: nil)
                        }
                    }

                case .failed, .cancelled, .loading, .unknown:
                    print("failed to load due to: \(error?.localizedDescription ?? "unknown error")")
                    continuation.resume(returning: nil)
                @unknown default:
                    print("failed to load due to: \(error?.localizedDescription ?? "unknown error")")
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    

    func extract(totalSamples: Int,
                 downsampledTo targetSampleCount: Int,
                 fftBands: Int?) -> WaveformAnalysis {
        var outputSamples = [Float]()
        var outputFFT = fftBands == nil ? nil : [TempiFFT]()
        var sampleBuffer = Data()
        var sampleBufferFFT = Data()

        // read upfront to avoid frequent re-calculation (and memory bloat from C-bridging)
        let samplesPerPixel = max(1, totalSamples / targetSampleCount)
        let samplesPerFFT = 4096 // ~100ms at 44.1kHz, rounded to closest pow(2) for FFT
        self.assetReader.startReading()
        while self.assetReader.status == .reading {
            let trackOutput = assetReader.outputs.first!

            guard let nextSampleBuffer = trackOutput.copyNextSampleBuffer(),
                let blockBuffer = CMSampleBufferGetDataBuffer(nextSampleBuffer) else {
                    break
            }

            var readBufferLength = 0
            var readBufferPointer: UnsafeMutablePointer<Int8>? = nil
            CMBlockBufferGetDataPointer(blockBuffer, atOffset: 0, lengthAtOffsetOut: &readBufferLength, totalLengthOut: nil, dataPointerOut: &readBufferPointer)
            sampleBuffer.append(UnsafeBufferPointer(start: readBufferPointer, count: readBufferLength))
            sampleBufferFFT.append(UnsafeBufferPointer(start: readBufferPointer, count: readBufferLength))
            CMSampleBufferInvalidate(nextSampleBuffer)

            let processedSamples = process(sampleBuffer, from: assetReader, downsampleTo: samplesPerPixel)
            outputSamples += processedSamples

            if processedSamples.count > 0 {
                // vDSP_desamp uses strides of samplesPerPixel; remove only the processed ones
                sampleBuffer.removeFirst(processedSamples.count * samplesPerPixel * MemoryLayout<Int16>.size)
            }

            if let fftBands = fftBands, sampleBufferFFT.count / MemoryLayout<Int16>.size >= samplesPerFFT {
                let processedFFTs = process(sampleBufferFFT, samplesPerFFT: samplesPerFFT, fftBands: fftBands)
                sampleBufferFFT.removeFirst(processedFFTs.count * samplesPerFFT * MemoryLayout<Int16>.size)
                outputFFT? += processedFFTs
            }
        }

        // if we don't have enough pixels yet,
        // process leftover samples with padding (to reach multiple of samplesPerPixel for vDSP_desamp)
        if outputSamples.count < targetSampleCount {
            let missingSampleCount = (targetSampleCount - outputSamples.count) * samplesPerPixel
            let backfillPaddingSampleCount = missingSampleCount - (sampleBuffer.count / MemoryLayout<Int16>.size)
            let backfillPaddingSampleCount16 = backfillPaddingSampleCount * MemoryLayout<Int16>.size
            let backfillPaddingSamples = [UInt8](repeating: 0, count: backfillPaddingSampleCount16)
            sampleBuffer.append(backfillPaddingSamples, count: backfillPaddingSampleCount16)
            let processedSamples = process(sampleBuffer, from: assetReader, downsampleTo: samplesPerPixel)
            outputSamples += processedSamples
        }

        return WaveformAnalysis(amplitudes: normalize(outputSamples), fft: outputFFT)
    }

    private func process(_ sampleBuffer: Data,
                         from assetReader: AVAssetReader,
                         downsampleTo samplesPerPixel: Int) -> [Float] {
        var downSampledData = [Float]()
        let sampleLength = sampleBuffer.count / MemoryLayout<Int16>.size
        sampleBuffer.withUnsafeBytes { (samplesRawPointer: UnsafeRawBufferPointer) in
            let unsafeSamplesBufferPointer = samplesRawPointer.bindMemory(to: Int16.self)
            let unsafeSamplesPointer = unsafeSamplesBufferPointer.baseAddress!
            var loudestClipValue: Float = 0.0
            var quietestClipValue = silenceDbThreshold
            var zeroDbEquivalent: Float = Float(Int16.max) // maximum amplitude storable in Int16 = 0 Db (loudest)
            let samplesToProcess = vDSP_Length(sampleLength)

            var processingBuffer = [Float](repeating: 0.0, count: Int(samplesToProcess))
            vDSP_vflt16(unsafeSamplesPointer, 1, &processingBuffer, 1, samplesToProcess) // convert 16bit int to float (
            vDSP_vabs(processingBuffer, 1, &processingBuffer, 1, samplesToProcess) // absolute amplitude value
            vDSP_vdbcon(processingBuffer, 1, &zeroDbEquivalent, &processingBuffer, 1, samplesToProcess, 1) // convert to DB
            vDSP_vclip(processingBuffer, 1, &quietestClipValue, &loudestClipValue, &processingBuffer, 1, samplesToProcess)

            let filter = [Float](repeating: 1.0 / Float(samplesPerPixel), count: samplesPerPixel)
            let downSampledLength = sampleLength / samplesPerPixel
            downSampledData = [Float](repeating: 0.0, count: downSampledLength)

            vDSP_desamp(processingBuffer,
                        vDSP_Stride(samplesPerPixel),
                        filter,
                        &downSampledData,
                        vDSP_Length(downSampledLength),
                        vDSP_Length(samplesPerPixel))
        }

        return downSampledData
    }

    private func process(_ sampleBuffer: Data,
                         samplesPerFFT: Int,
                         fftBands: Int) -> [TempiFFT] {
        var ffts = [TempiFFT]()
        let sampleLength = sampleBuffer.count / MemoryLayout<Int16>.size
        sampleBuffer.withUnsafeBytes { (samplesRawPointer: UnsafeRawBufferPointer) in
            let unsafeSamplesBufferPointer = samplesRawPointer.bindMemory(to: Int16.self)
            let unsafeSamplesPointer = unsafeSamplesBufferPointer.baseAddress!
            let samplesToProcess = vDSP_Length(sampleLength)

            var processingBuffer = [Float](repeating: 0.0, count: Int(samplesToProcess))
            vDSP_vflt16(unsafeSamplesPointer, 1, &processingBuffer, 1, samplesToProcess) // convert 16bit int to float
            repeat {
                let fftBuffer = processingBuffer[0..<samplesPerFFT]
                let fft = TempiFFT(withSize: samplesPerFFT, sampleRate: 44100.0)
                fft.windowType = TempiFFTWindowType.hanning
                fft.fftForward(Array(fftBuffer))
                fft.calculateLinearBands(minFrequency: 0, maxFrequency: fft.nyquistFrequency, numberOfBands: fftBands)
                ffts.append(fft)

                processingBuffer.removeFirst(samplesPerFFT)
            } while processingBuffer.count >= samplesPerFFT
        }
        return ffts
    }

    func normalize(_ samples: [Float]) -> [Float] {
        return samples.map { $0 / silenceDbThreshold }
    }

    private func totalSamplesOfTrack() -> Int {
        var totalSamples = 0

        autoreleasepool {
            let descriptions = audioAssetTrack.formatDescriptions as! [CMFormatDescription]
            descriptions.forEach { formatDescription in
                guard let basicDescription = CMAudioFormatDescriptionGetStreamBasicDescription(formatDescription) else { return }
                let channelCount = Int(basicDescription.pointee.mChannelsPerFrame)
                let sampleRate = basicDescription.pointee.mSampleRate
                let duration = Double(assetReader.asset.duration.value)
                let timescale = Double(assetReader.asset.duration.timescale)
                let totalDuration = duration / timescale
                totalSamples = Int(sampleRate * totalDuration) * channelCount
            }
        }

        return totalSamples
    }
}

// MARK: - Configuration
private extension WaveformAnalyzer {
    func outputSettings() -> [String: Any] {
        return [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMIsNonInterleaved: false
        ]
    }
}
