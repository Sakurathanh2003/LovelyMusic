//
//  RenameDialogViewModel.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 25/07/2022.
//

import Foundation
import SwiftUI

class RenameDialogViewModel: ObservableObject {
    @Published var item: MyRingToneItem
    @Published var newName: String
    
    init(item: MyRingToneItem) {
        self.item = item
        self.newName = item.name
    }
    
    func didTapSave() {
        if newName == item.name {
            return
        }
        
        let toneDao = ToneDao()
        item.name = toneDao.getNewToneName(name: newName.trim())
        toneDao.updateObject(tone: item)
    }
    
    func buttonSaveColor() -> Color {
        return enableSaveButton() ? Color(rgb: 0xFFAC2C) : Color(rgb: 0x262735)
    }
    
    func saveTextColor() -> Color {
        return enableSaveButton() ? Color(rgb: 0xFFFFFF) : Color(rgb: 0xFFFFFF).opacity(0.25)
    }
    
    func enableSaveButton() -> Bool {
        return !newName.trim().isEmpty
    }
}
