//
//  SeekBar.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct SeekBar: View {
    var progress: CGFloat = 0.1
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Color(rgb: 0xA5A5A5)
                HStack {
                    Color.white
                    Spacer().frame(width: proxy.size.width * (1.0 - progress))
                }
            }
        }
        .frame(height: 4)
        .cornerRadius(2)
    }
}

struct SeekBar_Previews: PreviewProvider {
    static var previews: some View {
        SeekBar()
            .previewLayout(.sizeThatFits)
    }
}
