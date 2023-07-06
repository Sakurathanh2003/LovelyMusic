//
//  ToneWaveformViewModel.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 04/08/2022.
//

import Foundation
import AVFoundation

class ToneWaveformViewModel: ObservableObject {
    @Published var asset: AVAsset?
    @Published var url: URL?
    @Published var powers: [CGFloat] = []
    @Published var maxPower: CGFloat = 0
    @Published var width: CGFloat
    
    init(asset: AVAsset? = nil,
         width: CGFloat,
         url: URL? = nil) {
        self.asset = asset
        self.width = width
        self.url = url
        
        if let soundURL = url {
            AssetCacheManager.shared.getFileWith(stringUrl: soundURL.absoluteString) { result in
                switch result {
                case .value(let url):
                    self.asset = AVAsset(url: url)
                case .error(let error):
                    print(error)
                }
            }
        }
    }
    
    @MainActor func onViewAppear() async {
        guard let asset = asset,
              let listPowers = await WaveformAnalyzer(asset: asset)?.samles(count: Int(width / 2.5)) else {
            return
        }

       
        self.maxPower = listPowers.max() ?? 0
        updatePowers(powers: listPowers)
    }
    
    @MainActor func updatePowers(powers: [CGFloat]) {
        self.powers = powers
    }
    
    func getHeight(index: Int) -> CGFloat {
        let ratio = powers[index] / maxPower
        let height = updateRatio(ratio) * 17
        return height
    }
    
    private func updateRatio(_ ratio: CGFloat) -> CGFloat {
        if ratio < 0.5 {
            return max(ratio/5, 0.1)
        }
        
        return min(1.8 * ratio - 0.8 , 1)
    }
}
