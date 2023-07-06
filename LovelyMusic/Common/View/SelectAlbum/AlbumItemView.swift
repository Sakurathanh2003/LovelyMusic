//
//  AlbumItemView.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 11/07/2022.
//

import SwiftUI

struct AlbumItemView: View {
    @EnvironmentObject var viewModel: ExtractVideoViewModel
    @ObservedObject var albumItem: AlbumItemViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Text(albumItem.fullNameAlbum())
                    .font(albumItem.fontText())
                    .foregroundColor(
                        Color(rgb: 0xFFFFFF)
                            .opacity(albumItem.opacity())
                    )
                    .lineLimit(1)
                Text(albumItem.numberOfVideo())
                    .font(albumItem.fontText())
                    .foregroundColor(
                        Color(rgb: 0xFFFFFF)
                            .opacity(albumItem.opacity())
                    )
                    .lineLimit(1)
                
                Spacer()
            }
            .frame(height: 44)
            .background(Color(rgb: 0x1F222A))
            
            HStack {
                Spacer().frame(width: 15)
                Color(rgb: 0x12121220).opacity(0.125)
                Spacer().frame(width: 15)
            }.frame(height: 1)
        }
        .background(Color(rgb: 0x1F222A))
    }
}

struct AlbumItemView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumItemView(albumItem: AlbumItemViewModel(album: LibraryAlbum(), isSelected: false)).previewLayout(.sizeThatFits)
    }
}
