//
//  PhotoGalleryManager.swift
//  PhotoConverter
//
//  Created by Manh Nguyen Ngoc on 15/04/2022.
//
// swiftlint:disable all

import UIKit
import Photos

class LibraryAlbum: ObservableObject {
    var assetCollection: PHAssetCollection
    var albumName: String?
    var numberOfPhoto: Int
    var phAssets: [PHAsset]
    
    init() {
        self.assetCollection = PHAssetCollection()
        self.albumName = ""
        self.numberOfPhoto = 0
        self.phAssets = [PHAsset]()
    }
    
    internal init(assetCollection: PHAssetCollection, albumName: String? = nil, numberOfPhoto: Int, phAssets: [PHAsset]) {
        self.assetCollection = assetCollection
        self.albumName = albumName
        self.numberOfPhoto = numberOfPhoto
        self.phAssets = phAssets
    }
    
    func nameAlbum() -> String {
        guard let albumName = albumName else {
            return "No Name"
        }
        
        return albumName
    }
}

class PhotoGalleryManager {
    static func getVideoInAlbum(_ album: PHAssetCollection? = nil) -> [PHAsset] {
        var listVideo = [PHAsset]()
        let fetchOptions = PHFetchOptions()
        
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let album = album {
            PHAsset.fetchAssets(in: album, options: fetchOptions).enumerateObjects { (asset, _, _) in
                listVideo.append(asset)
            }
        } else {
            let albums = self.getAlbumGallery(hasSmartAlbum: true)
            var photoExists = [String: Bool]()
            for album in albums {
                PHAsset.fetchAssets(in: album.assetCollection, options: fetchOptions).enumerateObjects { (asset, _, _) in
                    if photoExists[asset.localIdentifier] == nil {
                        listVideo.append(asset)
                        photoExists[asset.localIdentifier] = true
                    }
                }
            }
        }
        
        return listVideo
    }
    
    static func fetchAssets(collection: PHAssetCollection, fetchOptions: PHFetchOptions) -> [LibraryAlbum] {
        var data = [LibraryAlbum]()
        
        if PHAsset.fetchAssets(in: collection, options: fetchOptions).count > 0 {
            let videos = self.getVideoInAlbum(collection)
            data.append(LibraryAlbum(assetCollection: collection, albumName: collection.localizedTitle, numberOfPhoto: videos.count, phAssets: videos))
        }
        
        return data
    }
    
    static func getAlbumGallery(hasSmartAlbum: Bool = true) -> [LibraryAlbum] {
        var data = [LibraryAlbum]()
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
                
        if hasSmartAlbum {
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            smartAlbums.enumerateObjects { (collection, _, _) in
                if PHAsset.fetchAssets(in: collection, options: fetchOptions).count > 0 {
                    data += self.fetchAssets(collection: collection, fetchOptions: fetchOptions)
                }
            }
        }
        
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        albums.enumerateObjects { (collection, _, _) in
            if PHAsset.fetchAssets(in: collection, options: fetchOptions).count > 0 {
                data += self.fetchAssets(collection: collection, fetchOptions: fetchOptions)
            }
        }
        
        if let albumIndex = data.firstIndex(where: {$0.albumName == "Videos"}) {
            data.remove(at: albumIndex)
        }
        
        return data
    }
}
