//
//  FloatExtensions.swift
//  BabyPhoto
//
//  Created by Thanh Vu on 6/24/20.
//  Copyright © 2020 Solar. All rights reserved.
//

import Foundation

extension Float {
    func ceil() -> Float {
        return ceilf(self)
    }

    func prettyString() -> String {
        if self == Float(Int(self)) {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }

    func prettyString(numberDigit: Int) -> String {
        if self == Float(Int(self)) {
            return "\(Int(self))"
        } else {
            let format = "%.0\(numberDigit)f"
            return String.init(format: format, self)
        }
    }

    func round(digit: Int) -> Float {
        let multipler = powf(10, Float(digit))

        return (self * multipler).rounded() / multipler
    }
    
    func toDurationString() -> String {
        let seconds: Int = Int(self) % 60
        let minutes = Int(self / 60)
        return String.init(format: "%02d:%02d", minutes, seconds)
    }
    
    func toFullDurationString() -> String {
        let miliseconds = Int(self * 100) % 100
        let seconds: Int = Int(self) % 60
        let minutes = Int(self / 60) % 60
        return String.init(format: "%02d:%02d:%02d", minutes, seconds, miliseconds)
    }
}
