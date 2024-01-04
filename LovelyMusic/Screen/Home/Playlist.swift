//
//  Playlist.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct Playlist: View {
    var body: some View {
        VStack {
            Image("ic_recentMusic")
                .resizable()
                .aspectRatio(1/1, contentMode: .fit)
                .cornerRadius(16)
            Spacer().frame(height: 16)
            HStack {
                Spacer().frame(width: 7)
                Text("R&B Playlist")
                    .font(OpenSans.semibold(size: 18))
                    .foregroundColor(.white)
                    .frame(height: 24)
                Spacer()
                Spacer().frame(width: 7)
            }
            Spacer().frame(height: 4)
            HStack {
                Spacer().frame(width: 7)
                Text("Chill your mind")
                    .font(OpenSans.regular(size: 14))
                    .foregroundColor(Color(rgb: 0xA5A5A5))
                    .frame(height: 16)
                Spacer()
                Spacer().frame(width: 7)
            }
        }.frame(width: 208)
       
    }
}

struct Playlist_Previews: PreviewProvider {
    static var previews: some View {
        Playlist()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
