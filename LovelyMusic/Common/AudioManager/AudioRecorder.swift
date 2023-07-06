//
//  AudioRecorder.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 28/07/2022.
//

import Foundation
import SwiftUI
import AVFoundation
import Combine

class AudioRecorder: NSObject, ObservableObject {
    
    override init() {
        super.init()
        
    }
    
    private var recorder: AVAudioRecorder!

    var recordDate: String = "Record"
    var url: URL?
        
    var recording = false
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        recordDate = Date().string(format: "dd-MM-YY_'at'_HH:mm:ss")
        
        let fileName = "\(recordDate).m4r"
        let audioFilename = URL(fileURLWithPath: "\(NSTemporaryDirectory())\(fileName)")
        self.url = audioFilename
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            recorder.record()

            recording = true
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        recorder.stop()
        recording = false
    }
    
    func deleteRecording() {
        guard let url = url else {
            return
        }
        
        do {
           try FileManager.default.removeItem(at: url)
        } catch {
            print("File could not be deleted!")
        }
    }
    
    func currentTime() -> Double {
        return recorder.currentTime
    }
}
