//
//  HomeSearchBar.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct HomeSearchBar: View {
    @State private var name = ""

    var body: some View {
        HStack {
            Spacer().frame(width: 16)
            Image("ic_search")
                .resizable()
                .frame(width: 24, height: 24)
            TextField("Search song, playslist, artist...",text:$name).font(OpenSans.regular(size: 14))
                .foregroundColor(Color(rgb: 0xA5A5A5))
            Spacer().frame(width: 16)
        }
        .frame(height: 48)
        .background(Color(rgb: 0x433E48))
        .cornerRadius(8)
    }
}

struct HomeSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchBar()
            .previewLayout(.sizeThatFits)
    }
}
