//
//  PermissionHelper.swift
//  PermissionHelper
//
//  Created by Thanh Vu on 18/10/2021.
//

import Foundation
import Combine

public protocol PermissionHelper {
    func needRequestMusicPermission() -> Bool
    func needRequestPhotoPermission() -> Bool
    func needRequestMicroPermission() -> Bool

    func requestPhotoPermission(completion: @escaping SolarRequestPermissionResponse)
    func requestMusicPermission(completion: @escaping SolarRequestPermissionResponse)
    func requestMicroPermission(completion: @escaping SolarRequestPermissionResponse)

    func requestPhotoPermission() -> AnyPublisher<SolarRequestPermissionResult, Never>
    func requestMusicPermission() -> AnyPublisher<SolarRequestPermissionResult, Never>
    func requestMicroPermission() -> AnyPublisher<SolarRequestPermissionResult, Never>

    func requestMusicPermission() async -> SolarRequestPermissionResult
    func requestPhotoPermission() async -> SolarRequestPermissionResult
    func requestMicroPermission() async -> SolarRequestPermissionResult
}
