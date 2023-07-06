//
//  CMTimeExtension.swift
//  Teleprompter
//
//  Created by Manh Nguyen Ngoc on 02/11/2021.
//

import UIKit
import AVFoundation

extension CMTime {
    var toString: String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let hours:Int = Int(totalSeconds / 3600)
        let minutes:Int = Int(totalSeconds % 3600 / 60)
        let seconds:Int = Int((totalSeconds % 3600) % 60)

        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}
