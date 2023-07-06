//
//  AssetCacheManager.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 22/08/2022.
//

import Foundation
import AVFoundation
import UIKit
import Cache

enum AssetCacheError: Error {
    case cannotDownload
}

class AssetCacheManager {
    static let shared = AssetCacheManager()
    private let fileManager = FileManager.default

    private lazy var mainDirectoryUrl: URL = {
        let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsUrl
    }()

    func getFileWith(stringUrl: String, completionHandler: @escaping (Result<URL>) -> Void ) {
        let file = directoryFor(stringUrl: stringUrl)

        guard !fileManager.fileExists(atPath: file.path)  else {
            completionHandler(Result.value(file))
            return
        }

        DispatchQueue.global().async {
            if let videoData = NSData(contentsOf: URL(string: stringUrl)!) {
                videoData.write(to: file, atomically: true)

                DispatchQueue.main.async {
                    completionHandler(Result.value(file))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(Result.error(AssetCacheError.cannotDownload))
                }
            }
        }
    }

    private func directoryFor(stringUrl: String) -> URL {
        let fileURL = URL(string: stringUrl)!.lastPathComponent
        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)
        return file
    }
}
