//
//  MusicItem.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct MusicItem: View {
    var body: some View {
        HStack {
            Image("ic_recentMusic")
                .resizable()
                .aspectRatio(1/1, contentMode: .fit)
                .cornerRadius(8)
            Spacer().frame(width: 16)
            VStack {
                HStack {
                    Text("Bye Bye")
                        .font(OpenSans.semibold(size: 18))
                        .foregroundColor(.white)
                        .frame(height: 24)
                    Spacer()
                }
                Spacer().frame(height: 4)
                HStack {
                    Text("Marshmello, Juice WRLD")
                        .font(OpenSans.regular(size: 14))
                        .foregroundColor(Color(rgb: 0xA5A5A5))
                        .frame(height: 16)
                    Spacer()
                }
            }
            
            Text("2:09")
                .font(OpenSans.regular(size: 14))
                .foregroundColor(.white)
                .frame(height: 16)
        }.frame(height: 56)
    }
}

struct MusicItem_Previews: PreviewProvider {
    static var previews: some View {
        MusicItem()
            .background(Color.black)
    }
}
