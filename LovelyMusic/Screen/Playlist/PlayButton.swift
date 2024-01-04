//
//  PlayButton.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

struct PlayButton: View {
    var isPlay: Bool
    var body: some View {
        ZStack {
            AngularGradient(colors: [Color(rgb: 0x842ED8),
                                     Color(rgb: 0xDB28A9),
                                     Color(rgb: 0x842ED8)],
                            center: .center,
                            startAngle: .zero,
                            endAngle: .degrees(360))
            
            Image("ic_\(!isPlay ? "play" : "pause")")
        }
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(isPlay: false)
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
