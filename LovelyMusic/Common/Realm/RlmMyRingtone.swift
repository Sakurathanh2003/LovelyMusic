//
//  RlmMyRingtone.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 21/07/2022.
//

import Foundation
import RealmSwift

final class RlmMyRingtone: Object {
    @objc dynamic var id: String!
    @objc dynamic var source: String!
    @objc dynamic var thumbnail: String!
    @objc dynamic var name: String!
    @objc dynamic var type: String!
    
    @objc dynamic var isPremium: Bool = false
    @objc dynamic var createdDate: Int64 = 0
    @objc dynamic var duration: Float = 0
    
    override init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
