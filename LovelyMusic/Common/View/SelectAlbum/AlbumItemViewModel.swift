//
//  AlbumItemViewModel.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 15/07/2022.
//

import Foundation
import SwiftUI

class AlbumItemViewModel: ObservableObject {
    @Published var album: LibraryAlbum
    @Published var isSelected: Bool
    
    init(album: LibraryAlbum, isSelected: Bool) {
        self.isSelected = isSelected
        self.album = album
    }
    
    func nameAlbum() -> String {
        guard let albumName = album.albumName else {
            return "No Name"
        }
        
        return albumName
    }

    func fullNameAlbum() -> String {
        let name = nameAlbum()
        return "\(name)"
    }
    
    func numberOfVideo() -> String {
        let numberOfVideos = album.phAssets.count
        return "(\(numberOfVideos))"
    }
    
    func fontText() -> Font {
        return isSelected ? Poppins.medium(size: 13) : Poppins.regular(size: 13)
    }
    
    func opacity() -> Double {
        return isSelected ? 1 : 0.5
    }
}

