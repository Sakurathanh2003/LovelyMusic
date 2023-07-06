//
//  URLAsyncImageLoader.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 18/07/2022.
//

import SwiftUI
import UIKit
import Foundation
import Photos
import SDWebImage

class URLAsyncImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    @MainActor func load() {
        Task {
            let thumbnail = await downloadImage()
            self.image = thumbnail
        }
    }
    
    func downloadImage() async -> UIImage? {
        return await withUnsafeContinuation { continuation in
            SDWebImageManager.shared.loadImage(with: URL(string: url.encodeURLString()), progress: nil) { image, _, _, _, _, _ in
                continuation.resume(with: .success(image))
            }
        }
    }
}
