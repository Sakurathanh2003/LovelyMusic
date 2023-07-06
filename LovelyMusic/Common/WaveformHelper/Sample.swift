//
//  Sample.swift
//  ios-extractToMp3
//
//  Created by linzsc on 04/08/2021.
//

import UIKit

class Sample {
    internal init(sampleIndex: Int = 0, power: CGFloat = 0) {
        self.sampleIndex = sampleIndex
        self.power = power
    }
    
    init(json: [String: Any]) {
        sampleIndex = json["sampleIndex"] as? Int ?? 0
        power = json["power"] as? CGFloat ?? 0
    }
    
    var sampleIndex: Int = 0
    var power: CGFloat = 0
    
    func toJson() -> [String: Any] {
        return [
            "sampleIndex": sampleIndex,
            "power": power,
        ]
    }
}
