//
//  ListPlaylist.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct ListPlaylist: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer().frame(width: 24)
                ForEach(0..<10) { _ in
                    Playlist()
                    Spacer().frame(width: 24)
                }
            }
        }
    }
}

struct ListPlaylist_Previews: PreviewProvider {
    static var previews: some View {
        ListPlaylist()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
