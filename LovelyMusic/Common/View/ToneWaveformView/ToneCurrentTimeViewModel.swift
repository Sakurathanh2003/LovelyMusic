//
//  ToneCurrentTimeViewModel.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 08/08/2022.
//

import Foundation
import AVFoundation

class ToneCurrentTimeViewModel: ObservableObject {
    @Published var currentTime: Double
    
    init(currentTime: Double) {
        self.currentTime = currentTime
    }
    
    func currentPower(asset: AVAsset?, powers: [CGFloat]) -> Int {
        guard let asset = asset else {
            return 0
        }

        let powerPerSec = Double(powers.count) / asset.duration.seconds
        
        return Int(currentTime * powerPerSec)
    }
}
