//
//  CachedResourceLoader.swift
//  Core
//
//  Created by Thanh Vu on 09/03/2022.
//

import Foundation
import AVFoundation

class CachedResourceLoaderDelegate: NSObject {
    var loadedData = Data()
    private var mineType: String

    init(data: Data, mineType: String) {
        self.loadedData = data
        self.mineType = mineType
    }
}

extension CachedResourceLoaderDelegate {
    private func fillContentFor(request: AVAssetResourceLoadingRequest) {
        if let infoRequest = request.contentInformationRequest {
            infoRequest.contentType = self.mineType
            infoRequest.contentLength = Int64(self.loadedData.count)
            infoRequest.isByteRangeAccessSupported = true
        }
    }

    private func responseDataFor(request: AVAssetResourceLoadingRequest) {
        guard let dataRequest = request.dataRequest else {
            return
        }

        let requestedLength = dataRequest.requestedLength
        let currentOffset = Int(dataRequest.currentOffset)

        if self.loadedData.count < currentOffset {
            return
        }

        let bytesToRespond = min(self.loadedData.count - currentOffset, requestedLength)
        let dataToRespond = self.loadedData.subdata(in: Range(uncheckedBounds: (currentOffset, currentOffset + bytesToRespond)))
        dataRequest.respond(with: dataToRespond)
    }
}

// MARK: - AVAssetResourceLoaderDelegate
extension CachedResourceLoaderDelegate: AVAssetResourceLoaderDelegate {
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        self.fillContentFor(request: loadingRequest)
        self.responseDataFor(request: loadingRequest)
        loadingRequest.finishLoading()
        return true
    }
}
