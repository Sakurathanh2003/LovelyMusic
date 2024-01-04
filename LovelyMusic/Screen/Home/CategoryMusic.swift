//
//  CategoryMusic.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct CategoryMusic: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer().frame(width: 24)
                ForEach(0..<10) { _ in
                    CategoryMusicItem()
                    Spacer().frame(width: 32)
                }
            }
        }
    }
}

struct CategoryMusicItem: View {
    var body: some View {
        Text("Recent")
            .font(OpenSans.semibold(size: 16))
            .foregroundColor(.white)
            .frame(height: 24)
    }
}



struct CategoryMusic_Previews: PreviewProvider {
    static var previews: some View {
        CategoryMusic()
            .previewLayout(.sizeThatFits)
            .background(Color.black)
    }
}
