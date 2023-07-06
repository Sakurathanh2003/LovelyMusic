//
//  RecentMusic.swift
//  LovelyMusic
//
//  Created by Mei Mei on 06/07/2023.
//

import SwiftUI

struct RecentMusic: View {
    var body: some View {
        ZStack {
            HStack {
                RecentMusicContent()
                Spacer()
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {

                    } label: {
                        Image("ic_play").resizable()
                            .frame(width: 20, height: 20)
                    }
                }

            }
        }.frame(width: 189, height: 65)
    }
}

private struct RecentMusicContent: View {
    var body: some View {
        ZStack {
            Color(rgb: 0x9570FF).opacity(0.1)

            HStack {
                Spacer().frame(width: 10)
                Image("ic_recentMusic").resizable()
                    .frame(width: 37, height: 37)
                    .cornerRadius(18.5)

                Spacer()
                VStack {
                    Text("Ayashe Ruhin").font(Metropolis.bold(size: 14))
                    HStack {
                        Image("ic_music_purple").resizable()
                            .frame(width: 13, height: 13)

                        Text("Some Feeling").font(Metropolis.medium(size: 12))
                            .foregroundColor(Color(rgb: 0x828282))
                    }
                }

                Spacer().frame(width: 20)
            }
        }
        .frame(width: 179, height: 65)
        .cornerRadius(15)
    }
}

struct RecentMusic_Previews: PreviewProvider {
    static var previews: some View {
        RecentMusic()
            .previewLayout(.sizeThatFits)
    }
}
