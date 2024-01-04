//
//  HomeViewModel.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import UIKit
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var listCategory: [String] = [
        "Recent",
        "Top 50",
        "Chill",
        "R&B",
        "Festival",
        "Idontknw",
        "Beautiful",
        "Wedding"
    ]
    @Published var recentCategoryIndex: Int = 0
    
    func numberOfCategories() -> Int {
        return listCategory.count
    }
    
    func category(index: Int) -> String {
        return listCategory[index]
    }
    
    func replaceRecentCategoryIndex(index: Int) {
        self.recentCategoryIndex = index
    }
}
