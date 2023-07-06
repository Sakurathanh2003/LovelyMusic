//
//  SoundPlayer.swift
//  Wallpaper
//
//  Created by Thanh Vu on 28/03/2022.
//

import Foundation
import UIKit
import AVFoundation

open class SoundPlayer: NSObject {
    private var player: AVPlayer!

    public var loopEnable: Bool = false
    public var pauseWhenEnterBackground: Bool = true

    public var isMuted: Bool {
        get {
            return player.isMuted
        }

        set {
            player.isMuted = newValue
        }
    }

    public var isFailed: Bool = false
    public var isReadyToPlay: Bool = false
    
    override init() {
        super.init()
        initPlayer()
        registerNotifications()
    }

    private func initPlayer() {
        self.player = AVPlayer()
        self.player.addObserver(self, forKeyPath: "rate", options: [.initial, .new], context: nil)
    }

    deinit {
        self.player.removeObserver(self, forKeyPath: "rate")

        if let playerItem = self.player.currentItem {
            playerItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        }
    }

    // MARK: - Observer
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status = self.player.currentItem?.status
            if status == .readyToPlay {
                Logging.log("Player item ready to play \(self.player.currentItem?.description ?? "")")
                self.isReadyToPlay = true
            }

            if status == .failed {
                Logging.log("Player item failed \(self.player.currentItem?.description ?? "")")
                self.isReadyToPlay = false
                self.player.replaceCurrentItem(with: nil)
            }
        }
    }

    // MARK: - Notifications
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionIterruptionNotification(_:)), name: AVAudioSession.interruptionNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(applicationEnterbackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    @objc func playerItemDidPlayToEnd(_ notification: Notification) {
        if self.loopEnable {
            self.player.seek(to: .zero)
            self.play()
        }
    }

    @objc func applicationEnterbackground(_ notification: Notification) {
        if self.pauseWhenEnterBackground {
            self.pause()
        }
    }
    
    @objc private func audioSessionIterruptionNotification(_ notification: Notification) {
        guard let typeValue = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt,
           let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
               return
        }

        if type == .began {
            self.pause()
        }
    }

    // MARK: - Audio session
    private func activeAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    }

    // MARK: - Public
    public func play() {
        activeAudioSession()
        self.player.play()
    }

    public func pause() {
        self.player.pause()
    }

    @discardableResult
    public func replacePlayerItem(_ item: AVPlayerItem?) -> Bool {
        if let oldItem = self.player.currentItem {
            if let newItem = item, comparePlayerItem(lhs: oldItem, rhs: newItem) {
                return false
            }

            oldItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: oldItem)
        }

        self.player.replaceCurrentItem(with: item)
        
        if item != nil {
            item?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new], context: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: item!)
        }

        return true
    }

    public func seekTo(_ time: TimeInterval) {
        let cmtime = CMTime.init(seconds: time, preferredTimescale: 3600)
        self.player.seek(to: cmtime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    public func seekTo(_ time: CMTime) {
        self.player.seek(to: time)
    }
    
    public func addTimeObserver(forInterval interval: CMTime, queue: DispatchQueue = .main, using: @escaping (CMTime) -> Void) -> Any {
        return self.player.addPeriodicTimeObserver(forInterval: interval, queue: queue, using: using)
    }

    public func removeTimeObserver(_ obj: Any) {
        self.player.removeTimeObserver(obj)
    }

    private func comparePlayerItem(lhs: AVPlayerItem, rhs: AVPlayerItem) -> Bool {
        guard let lhsAsset = lhs.asset as? AVURLAsset,
              let rhsAsset = rhs.asset as? AVURLAsset else {
            return false
        }

        return lhsAsset.url == rhsAsset.url
    }

    public func rate() -> Float {
        return player.rate
    }

    public func duration() -> CMTime? {
        return player.currentItem?.duration
    }

    public func isPlaying() -> Bool {
        return player.rate != 0
    }
    
    public func asset() -> AVAsset? {
        return player.currentItem?.asset
    }
}
