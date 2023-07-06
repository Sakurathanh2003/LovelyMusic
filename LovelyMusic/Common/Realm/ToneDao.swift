//
//  ToneDao.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 21/07/2022.
//

import Foundation
import RealmSwift

final class ToneDao: RealmDao {
    func addObject(tone: RlmMyRingtone) {
        tone.name = getNewToneName(name: tone.name)
        try? self.addObject(tone)
    }
    
    func getAllTone() -> [RlmMyRingtone] {
        guard let rlmObjs = try? self.objects(type: RlmMyRingtone.self) else {
            return []
        }

        return rlmObjs.reversed()
    }
    
    func numberOfTones() -> Int {
        let tones = getAllTone()
        return tones.count
    }
    
    func getAllMyRingtone() -> [MyRingToneItem] {
        let listTones = getAllTone()
        
        return listTones.map { item in
            MyRingToneItem(rlmObj: item)
        }
    }
    
    func getTones(type: MyRingToneType) -> [RlmMyRingtone] {
        let listTones = getAllTone() 
        
        return listTones.filter { item in
            return item.type == type.rawValue
        }
    }
    
    func getMyRingTones(type: MyRingToneType) -> [MyRingToneItem] {
        let item = getTones(type: type)
        
        return item.map { item in
            MyRingToneItem(rlmObj: item)
        }
    }
    
    func getMyRingtoneItem(amount: Int) -> [MyRingToneItem] {
        let listTones = getAllTone()
        
        if listTones.count <= amount {
            return listTones.map { item in
                MyRingToneItem(rlmObj: item)
            }
        }
        
        let result = listTones.prefix(amount)
        
        return result.map { item in
            MyRingToneItem(rlmObj: item)
        }
    }
    
    func removeObject(tone: MyRingToneItem) {
        guard let rlmObject = try? super.objectWithPrimaryKey(type: RlmMyRingtone.self, key: tone.id) else {
            print("No object \(tone.id) in Realm")
            return
        }
        
        deleteAudio(url: tone.source)
        try? super.deleteObjects([rlmObject])
    }
    
    func updateObject(tone: MyRingToneItem) {
        let rlmObject = tone.rlmObject()
        try? addObjectAndUpdate(rlmObject)
    }
    
    func deleteAudio(url: URL) {
        do {
           try FileManager.default.removeItem(at: url)
        } catch {
            print("File could not be deleted!")
        }
    }
    
    func getNewToneName(name: String) -> String {
        let listTone = getAllTone()
        
        var index = 0
        var newName = name
        
        while listTone.contains(where: {$0.name == newName}) {
            index += 1
            newName = name + "_\(index)"
        }
        
        return newName
    }
    
    func isEmptyList(type: MyRingToneType) -> Bool {
        return getMyRingTones(type: type).isEmpty
    }
}
