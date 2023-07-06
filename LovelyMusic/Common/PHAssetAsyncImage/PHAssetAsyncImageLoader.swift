//
//  PHAssetAsyncImageLoader.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 14/07/2022.
//

import SwiftUI
import Combine
import Foundation
import Photos

class PHAssetAsyncImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let asset: PHAsset
    
    init(asset: PHAsset) {
        self.asset = asset
    }
    
    @MainActor func load() {
        Task {
            self.image = await asset.thumbnail()
        }
    }
}
