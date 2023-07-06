//
//  URLAsyncImage.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 18/07/2022.
//

import Foundation
import SwiftUI
import Photos

struct URLAsyncImage: View {
    @StateObject private var loader: URLAsyncImageLoader
    private var placeholder: String?

    init(url: String, placeholder: String? = nil) {
        _loader = StateObject(wrappedValue: URLAsyncImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else if placeholder != nil {
                Image(placeholder!)
                    .resizable()
                    .frame(width: 44, height: 48)
            } else {
                Spacer()
            }
        }
    }
}

