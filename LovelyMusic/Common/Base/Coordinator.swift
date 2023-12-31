//
//  Coordinator.swift
//  Wallpaper
//
//  Created by Thanh Vu on 24/02/2022.
//

import Foundation

open class CoordinatorEvent {

}

open class Coordinator: NSObject {
    private(set) var started: Bool = false
    private(set) var children: [Coordinator] = []
    private(set) weak var parent: Coordinator?

    open func start() {
        if self.started {
            return
        }

        self.started = true
    }

    open func stop(completion: (() -> Void)? = nil) {
        if !self.started {
            return
        }

        self.started = false
        self.parent?.removeChild(self)
    }

    open func handle(event: CoordinatorEvent) -> Bool {
        return false
    }

    public func send(event: CoordinatorEvent) {
        if !self.handle(event: event) {
            self.parent?.send(event: event)
        }
    }

    public func addChild(_ coordinator: Coordinator) {
        coordinator.parent = self
        self.children.append(coordinator)
    }

    public func removeChild(_ coordinator: Coordinator) {
        coordinator.parent = nil
        let index = self.children.firstIndex { obj in
            return obj == coordinator
        }

        if index != nil {
            self.children.remove(at: index!)
        }
    }

    open override var debugDescription: String {
        return "Coordinator \(String(describing: self.self))\n\tchildren \(self.children)"
    }
}
