//
//  ReachabilityCenter.swift
//  Reachability
//
//  Created by Thanh Vu on 25/02/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Reachability

public class ReachabilityCenter {
    public static let shared = ReachabilityCenter()
    private let reachability: Reachability!
    private var isConnectedToInternet = false
    private var connectSubject = ReplaySubject<Bool>.create(bufferSize: 1)

    public func isConnected() -> Bool {
        return isConnectedToInternet
    }

    init() {
        guard let reachability = try? Reachability(hostname: "8.8.8.8") else {
            fatalError()
        }

        self.reachability = reachability
        self.connectSubject.onNext(self.isConnectedToInternet)

        reachability.whenReachable = {[unowned self] _ in
            if !self.isConnectedToInternet {
                self.isConnectedToInternet = true
                self.connectSubject.onNext(true)
            }

            Logging.log("Application change reachability: \(self.isConnected())")
        }

        reachability.whenUnreachable = {[unowned self] _ in
            if self.isConnectedToInternet {
                self.isConnectedToInternet = false
                self.connectSubject.onNext(false)
            }

            Logging.log("Application change reachability: \(self.isConnected())")
        }
    }

    public func startRechability() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    public func subscribe() -> Driver<Bool> {
        return self.connectSubject.share().asDriver(onErrorJustReturn: false)
    }
}
