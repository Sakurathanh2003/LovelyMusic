//
//  ListFavoriteMusic.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct ListFavoriteMusic: View {
    var body: some View {
        VStack {
            HStack {
                Text("Your favourites")
                    .font(OpenSans.semibold(size: 18))
                    .foregroundColor(.white)
                    .frame(height: 24)
                Spacer()
            }
            
            ForEach(0..<10) {_ in
                Spacer().frame(height: 24)
                
                NavigationLink(destination: PlayMusicScreen().navigationBarHidden(true)) {
                    MusicItem()
                }
            }
            
            
            Spacer().frame(height: 24)
        }
        
    }
}

struct ListFavoriteMusic_Previews: PreviewProvider {
    static var previews: some View {
        ListFavoriteMusic()
            .background(Color.black)
    }
}
