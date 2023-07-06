//
//  SolarRequestPermissionResponse.swift
//  GifMaker
//
//  Created by Thanh Vu on 18/10/2021.
//

import Foundation

public struct SolarRequestPermissionResult {
    var granted: Bool
    var needOpenAppSetting: Bool
}

public typealias SolarRequestPermissionResponse = (_ result: SolarRequestPermissionResult) -> Void
