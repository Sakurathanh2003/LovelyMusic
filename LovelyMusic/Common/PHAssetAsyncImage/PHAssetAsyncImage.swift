//
//  PHAssetAsyncImage.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 14/07/2022.
//

import Foundation
import SwiftUI
import Photos

struct PHAssetAsyncImage: View {
    @StateObject private var loader: PHAssetAsyncImageLoader

    init(asset: PHAsset) {
        _loader = StateObject(wrappedValue: PHAssetAsyncImageLoader(asset: asset))
    }

    var body: some View {
        content
            .onAppear {
                loader.load()
            }
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                Spacer()
            }
        }
    }
}
