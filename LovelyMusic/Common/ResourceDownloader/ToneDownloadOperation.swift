//
//  ToneDownloader.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 21/07/2022.
//

import Foundation
import RxSwift
import UIKit

enum ToneDownloaderError: Error {
    case urlError
}


class ToneDownloadOperationQueue {
  lazy var downloadsInProgress: [Int: Operation] = [:]
    
  lazy var downloadQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "Tone Download OperationQueue"
    queue.maxConcurrentOperationCount = 1
    return queue
  }()
}

class ToneDownloadOperation: AsynchronousOperation {
    let item: ToneDownloadableItem
    var downloadState: DownloadState = .non
    
    init(item: ToneDownloadableItem) {
        self.item = item
    }
    
    override func main() {
        super.main()
        
        self.download(item: item)
            .subscribe { myRingtoneItem in
                let obj = myRingtoneItem.rlmObject()
                let toneDao = ToneDao()
                toneDao.addObject(tone: obj)
                self.downloadState = .success
                self.state = .finished
            } onError: { _ in
                self.downloadState = .fail
                self.state = .finished
            }.disposed(by: disposeBag)
    }
    
    private func download(item: ToneDownloadableItem) -> Observable<MyRingToneItem> {
        guard let imageURL = item.imageURL(),
              let soundURL = item.soundURL() else {
            return Observable.error(ToneDownloaderError.urlError)
        }

        let imageObservable = ResourceDownloader.downloadResource(from: imageURL).retry(3)
        let soundObservable = ResourceDownloader.downloadResource(from: soundURL).retry(3)

        return Observable.zip([imageObservable, soundObservable])
            .flatMap { urls -> Observable<MyRingToneItem> in
                let urlsInDocument = urls.map { url -> URL in
                    let urlInDocument = FileManager.documentURL().appendingPathComponent(url.lastPathComponent)
                    try? FileManager.default.moveItem(at: url, to: urlInDocument)
                    return urlInDocument
                }

                let imageLocalURL = urlsInDocument[0]
                let soundLocalURL = urlsInDocument[1]
                let createdDate = Date()
                let id = String(createdDate.timeIntervalSince1970)

                let myRingtoneItem = MyRingToneItem(source: soundLocalURL,
                                                    isPremium: item.isPremium(),
                                                    thumbnail: imageLocalURL,
                                                    name: item.getToneName(),
                                                    duration: item.duration(),
                                                    type: .online,
                                                    id: id,
                                                    createdDate: createdDate)
                return Observable.just(myRingtoneItem)
            }
    }
}
