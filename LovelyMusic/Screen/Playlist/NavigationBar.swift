//
//  NavigationBar.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct NavigationBar: View {
    var didTapBack: (() -> Void)?
    var didTapMore: (() -> Void)?
    var body: some View {
        HStack {
            Spacer().frame(width: 24)
            Image("ic_back")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 24)
                .onTapGesture {
                    didTapBack?()
                }
            
            Spacer()
            Image("ic_more")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 24)
                .onTapGesture {
                    didTapMore?()
                }
            Spacer().frame(width: 24)
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
