//
//  DeleteDialogViewModel.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 25/07/2022.
//

import Foundation

class DeleteDialogViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var item: MyRingToneItem
    
    // MARK: - Init
    init(item: MyRingToneItem) {
        self.item = item
    }
    
    // MARK: - Get
    func name() -> String {
        return item.name + "." + pathExtention()
    }
    
    func pathExtention() -> String {
        let path: NSString = item.source.path as NSString
        return path.pathExtension
    }
    
    func deleteItem() {
        let toneDao = ToneDao()
        toneDao.removeObject(tone: item)
    }
}
