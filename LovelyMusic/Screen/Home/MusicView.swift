//
//  MusicView.swift
//  LovelyMusic
//
//  Created by Mei Mei on 06/07/2023.
//

import SwiftUI
import UIKit

struct MusicView: View {
    var body: some View {
        ZStack {
            Image("ic_recentMusic").resizable()
                .frame(width: 149, height: 145)

            VStack {
                Spacer()

                HStack {
                    Spacer().frame(width: 8)

                    ZStack {
                        VisualEffectView(style: .light)
                            .frame(height: 52)
                            .cornerRadius(8)

                        VStack {
                            Spacer().frame(height: 10)

                            HStack {
                                Spacer().frame(width: 11)
                                Text("Out of My Mine").font(Metropolis.semibold(size: 13))
                                    .foregroundColor(.white)
                                    .lineLimit(1)

                                Spacer()
                            }

                            Spacer().frame(height: 4)

                            HStack {
                                Spacer().frame(width: 11)
                                Text("Dance").font(Metropolis.medium(size: 10))
                                    .foregroundColor(.white.opacity(0.62))
                                    .lineLimit(1)

                                Spacer()
                            }

                            Spacer().frame(height: 10)
                        }
                    }


                    Spacer().frame(width: 8)
                }
            }
        }
        .frame(width: 149, height: 145)
        .cornerRadius(30)
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
        .previewLayout(.sizeThatFits)
    }
}
