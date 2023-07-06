//
//  SampleSegment.swift
//  ios-extractToMp3
//
//  Created by linzsc on 04/08/2021.
//

import UIKit
import Foundation

class SampleSegment {
    internal init(index: Int = 0, sampleCount: Int = 0, powerMaxValue: CGFloat = 0) {
        self.index = index
        self.numberPowers = sampleCount
        self.powerMaxValue = powerMaxValue
    }
    
    var index: Int = 0
    var numberPowers: Int = 0
    var powerMaxValue: CGFloat = 0
    
    var path: String {
        return "\(NSTemporaryDirectory())\(index).json"
    }
    
    var powers: [CGFloat] {
        guard let data = FileManager.default.contents(atPath: path) else {
            return []
        }
        
        do {
            guard let listSample = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String: Any]] else {
                return []
            }
            
            let powers = listSample.map { element in
                return element["power"] as! CGFloat
            }
            
            powerMaxValue = powers.max() ?? 0
            return powers
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
