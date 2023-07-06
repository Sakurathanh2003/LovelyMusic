//
//  PermissionHelperImpl.swift
//  PermissionHelper
//
//  Created by Thanh Vu on 18/10/2021.
//

import UIKit
import Photos
import MediaPlayer
import Combine
import AVFoundation

final class PermissionHelperImpl: PermissionHelper {
    func needRequestMicroPermission() -> Bool {
        return AVAudioSession.sharedInstance().recordPermission == .granted
    }
    
    func needRequestMusicPermission() -> Bool {
        return MPMediaLibrary.authorizationStatus() != .authorized
    }

    func needRequestPhotoPermission() -> Bool {
        if #available(iOS 14, *) {
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            return status != .authorized && status != .limited
        } else {
            return PHPhotoLibrary.authorizationStatus() != .authorized
        }
    }

    func requestPhotoPermission(completion: @escaping SolarRequestPermissionResponse) {
        let previousStatus: PHAuthorizationStatus
        if #available(iOS 14, *) {
            previousStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            previousStatus = PHPhotoLibrary.authorizationStatus()
        }

        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(SolarRequestPermissionResult(granted: status == .authorized, needOpenAppSetting: previousStatus == .denied))
            }
        }
    }

    func requestMusicPermission(completion: @escaping SolarRequestPermissionResponse) {
        let previousStatus = MPMediaLibrary.authorizationStatus()
        MPMediaLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(SolarRequestPermissionResult(granted: status == .authorized, needOpenAppSetting: previousStatus == .denied))
            }
        }
    }
    
    func requestMicroPermission(completion: @escaping SolarRequestPermissionResponse) {
        let previousStatus = AVAudioSession.sharedInstance().recordPermission
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                completion(SolarRequestPermissionResult(granted: granted, needOpenAppSetting: previousStatus == .denied))
            }
        }
    }
    
    func requestPhotoPermission() -> AnyPublisher<SolarRequestPermissionResult, Never> {
        return Future { promise in
            self.requestPhotoPermission { result in
                promise(Result.success(result))
            }
        }.eraseToAnyPublisher()
    }
    
    func requestMusicPermission() -> AnyPublisher<SolarRequestPermissionResult, Never> {
        return Future { promise in
            self.requestMusicPermission { result in
                promise(Result.success(result))
            }
        }.eraseToAnyPublisher()
    }
    
    func requestMicroPermission() -> AnyPublisher<SolarRequestPermissionResult, Never> {
        return Future { promise in
            self.requestMicroPermission { result in
                promise(Result.success(result))
            }
        }.eraseToAnyPublisher()
    }
    
    func requestMusicPermission() async -> SolarRequestPermissionResult {
        return await withUnsafeContinuation { continuation in
            self.requestMusicPermission { result in
                continuation.resume(with: .success(result))
            }
        }
    }
    
    func requestPhotoPermission() async -> SolarRequestPermissionResult {
        return await withUnsafeContinuation { continuation in
            self.requestPhotoPermission { result in
                continuation.resume(with: .success(result))
            }
        }
    }
    
    func requestMicroPermission() async -> SolarRequestPermissionResult {
        return await withUnsafeContinuation { continuation in
            self.requestMicroPermission { result in
                continuation.resume(with: .success(result))
            }
        }
    }
}
