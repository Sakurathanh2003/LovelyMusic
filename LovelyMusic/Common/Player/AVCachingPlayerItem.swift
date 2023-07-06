//
//  AVCachingPlayerItem.swift
//  Core
//
//  Created by Thanh Vu on 09/03/2022.
//

import Foundation
import AVFoundation
import Cache

private struct CacheShare {
    private static var storage: Storage<String, Data>!

    static func getStorage() -> Storage<String, Data> {
        if storage == nil {
            let diskCacheDir = "\(NSTemporaryDirectory())playerItem"
            let diskConfig = DiskConfig(name: "player item cache", expiry: .seconds(86400 * 3), maxSize: 100, directory: URL.init(fileURLWithPath: diskCacheDir))
            let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)

            storage = try? Storage<String, Data>.init(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forData())
        }

        return storage
    }
}

public class AVCachingPlayerItem: AVPlayerItem {
    private var resourceLoaderHandler: CachingResourceLoaderDelegate!
    private var cachedResourceLoaderHandler: CachedResourceLoaderDelegate!

    public init(url: URL) {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError()
        }

        components.scheme = "fuckingCache"
        guard let urlWithCustomScheme = components.url else {
            fatalError()
        }

        let asset = AVURLAsset(url: urlWithCustomScheme)

        do {
            let data = try CacheShare.getStorage().entry(forKey: url.absoluteString)
            self.cachedResourceLoaderHandler = CachedResourceLoaderDelegate(data: data.object, mineType: "video/mp4")
            asset.resourceLoader.setDelegate(self.cachedResourceLoaderHandler, queue: DispatchQueue.main)
            Logging.log("[AVCachingPlayerItem] reuse cache for url \(url.absoluteURL)")
        } catch {
            self.resourceLoaderHandler = CachingResourceLoaderDelegate(url: url)
            self.resourceLoaderHandler.onDownloadDone = { data in
                Logging.log("[AVCachingPlayerItem] cached url \(url.absoluteURL)")
                try? CacheShare.getStorage().setObject(data, forKey: url.absoluteString)
            }

            asset.resourceLoader.setDelegate(self.resourceLoaderHandler, queue: DispatchQueue.main)
        }

        super.init(asset: asset, automaticallyLoadedAssetKeys: nil)
    }
}
