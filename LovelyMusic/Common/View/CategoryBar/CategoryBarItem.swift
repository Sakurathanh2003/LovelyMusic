//
//  CategoryBarItem.swift
//  Wallpaper
//
//  Created by Thanh Vu on 25/02/2022.
//

import Foundation

struct CategoryBarItem {
    var id: String
    var name: String
    var imageURL: URL?
}

extension CategoryBarItem: Equatable {
    static func == (lhs: CategoryBarItem, rhs: CategoryBarItem) -> Bool {
        return lhs.id == rhs.id
    }
}
