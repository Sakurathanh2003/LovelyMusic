//
//  CategoryMusic.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct CategoryMusic: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer().frame(width: 24)
                ForEach(0..<viewModel.numberOfCategories()) { index in
                    VStack {
                        CategoryMusicItem(
                            text: viewModel.category(index: index),
                            textColor: index == viewModel.recentCategoryIndex ? .white :
                        Color(rgb: 0xA5A5A5))
                        .onTapGesture {
                            viewModel.replaceRecentCategoryIndex(index: index)
                        }
                        
                        LinearGradient(
                            colors: index == viewModel.recentCategoryIndex ? [Color(rgb: 0xC22BB7), Color(rgb: 0x922FF5)] : [.clear],
                            startPoint: .leading, endPoint: .trailing)
                        .frame(height: 4)
                    }
                    
                    Spacer().frame(width: 32)
                }
            }
        }
        .animation(.easeInOut)
    }
}

struct CategoryMusicItem: View {
    var text: String
    var textColor: Color
    var body: some View {
        Text(text)
            .font(OpenSans.semibold(size: 16))
            .foregroundColor(textColor)
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
