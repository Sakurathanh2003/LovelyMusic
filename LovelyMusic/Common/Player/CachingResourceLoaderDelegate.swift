//
//  CustomResourceLoader.swift
//  Core
//
//  Created by Thanh Vu on 09/03/2022.
//

import Foundation
import AVFoundation

class CachingResourceLoaderDelegate: NSObject {
    private var pendingRequests = Set<AVAssetResourceLoadingRequest>()
    private var loadedData = Data()
    private var urlSessionResponse: URLResponse?
    private var url: URL
    public var onDownloadDone: ((Data) -> Void)?

    private var session: URLSession?
    private var dataTask: URLSessionDataTask?

    init(url: URL) {
        self.url = url
        super.init()
    }

    func startLoading() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 30
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
        dataTask = session.dataTask(with: self.url)
        dataTask?.resume()

        self.session = session
    }
}

extension CachingResourceLoaderDelegate {
    private func handlePendingRequests() {
        self.fillContentForAllRequest()
        let responsedReqs = self.pendingRequests.filter { request in
            return self.responseDataFor(request: request)
        }

        responsedReqs.forEach { request in
            request.finishLoading()
            self.pendingRequests.remove(request)
        }
    }

    private func fillContentForAllRequest() {
        guard let response = self.urlSessionResponse else {
            return
        }

        self.pendingRequests.forEach { request in
            if let infoRequest = request.contentInformationRequest {
                infoRequest.contentType = response.mimeType
                infoRequest.contentLength = response.expectedContentLength
                infoRequest.isByteRangeAccessSupported = true
            }
        }
    }

    private func responseDataFor(request: AVAssetResourceLoadingRequest) -> Bool {
        guard let dataRequest = request.dataRequest else {
            return false
        }

        let requestedOffset = Int(dataRequest.requestedOffset)
        let requestedLength = dataRequest.requestedLength
        let currentOffset = Int(dataRequest.currentOffset)

        if self.loadedData.count < currentOffset {
            return false
        }

        let bytesToRespond = min(self.loadedData.count - currentOffset, requestedLength)
        let dataToRespond = self.loadedData.subdata(in: Range(uncheckedBounds: (currentOffset, currentOffset + bytesToRespond)))
        dataRequest.respond(with: dataToRespond)

        return self.loadedData.count >= requestedLength + requestedOffset
    }
}

// MARK: - AVAssetResourceLoaderDelegate
extension CachingResourceLoaderDelegate: AVAssetResourceLoaderDelegate {
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, didCancel loadingRequest: AVAssetResourceLoadingRequest) {
        self.pendingRequests.remove(loadingRequest)
    }

    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        self.pendingRequests.insert(loadingRequest)
        self.handlePendingRequests()

        if self.session == nil {
            self.startLoading()
        }

        return true
    }
}

extension CachingResourceLoaderDelegate: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.loadedData.append(data)
        self.handlePendingRequests()
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // TODO: Handle try
        if error != nil {
            self.pendingRequests.forEach { req in
                req.finishLoading(with: error)
            }

            self.pendingRequests.removeAll()
            return
        }

        self.handlePendingRequests()
        self.onDownloadDone?(self.loadedData)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(Foundation.URLSession.ResponseDisposition.allow)

        self.urlSessionResponse = response
        self.handlePendingRequests()
    }
}
