//
//  ToneDownloadableItem.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 22/07/2022.
//

import Foundation

struct ToneDownloadableItem {
    let tone: OnlineRingtoneItem
    
    func getToneName() -> String {
        return tone.name
    }
    
    func isPremium() -> Bool {
        return tone.isPremium
    }
    
    func imageURL() -> URL? {
        return tone.imageURL()
    }
    
    func soundURL() -> URL? {
        return tone.soundURL()
    }
    
    func id() -> String {
        return tone.id
    }
    
    func duration() -> Float {
        return max(tone.duration, 1)
    }
}
