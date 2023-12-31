//
//  TimeIntervalExtensions.swift
//  BabyPhoto
//
//  Created by VietLV on 7/13/20.
//  Copyright © 2020 Solar. All rights reserved.
//

import Foundation
import AVFoundation

extension TimeInterval {
    func toDurationString() -> String {
        let seconds: Int = Int(self) % 60
        let minutes = Int(self / 60)
        let hours = Int(self / 3600)
        
        if hours == 0 {
            return String.init(format: "%02d:%02d", minutes, seconds)
        }
        
        return String.init(format: "%02d:%02d:%02d", hours, minutes % 60, seconds)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
}

extension CMTime {
    func toDouble() -> Float64 {
        return CMTimeGetSeconds(self)
    }
}
