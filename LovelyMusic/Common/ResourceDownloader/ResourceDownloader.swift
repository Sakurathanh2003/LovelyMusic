//
//  ResourceDownloader.swift
//  Wallpaper
//
//  Created by Thanh Vu on 21/03/2022.
//

import Foundation
import RxSwift

enum DownloadState {
    case success, fail, non
}

final class ResourceDownloader {
    static func downloadResource(from url: URL) -> Observable<URL> {
        return Observable<URL>.create { observer in
            let urlSessionConfig = URLSessionConfiguration.default
            urlSessionConfig.timeoutIntervalForRequest = 10

            let session = URLSession(configuration: urlSessionConfig)
            let urlDataTask = session.dataTask(with: url) { data, _, error in
                if let err = error {
                    observer.onError(err)
                    return
                }

                let date = Date().string(format: "dd-MM-YY_'at'_HH:mm:ss")
                let pathExtension = url.pathExtension
                let fileName = "\(date).\(pathExtension)"
                let destinationURL = URL(fileURLWithPath: "\(NSTemporaryDirectory())\(fileName)")
                
                try? FileManager.default.removeItem(at: destinationURL)
                try! data?.write(to: destinationURL)

                observer.onNext(destinationURL)
                observer.onCompleted()
                session.finishTasksAndInvalidate()
            }

            urlDataTask.resume()

            return Disposables.create {
                urlDataTask.cancel()
            }
        }
    }
}
