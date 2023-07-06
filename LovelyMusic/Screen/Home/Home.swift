//
//  Home.swift
//  LovelyMusic
//
//  Created by Mei Mei on 06/07/2023.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer().frame(width: 20)

                    Image("ic_avatar").resizable()
                        .frame(width: 49, height: 49)

                    Spacer()

                    Button {
                        print("helo")
                    } label: {
                        Image("ic_search").resizable()
                            .frame(width: 43, height: 43)
                    }

                    Spacer().frame(width: 20)
                }

                ScrollView(.vertical) {
                    HomeContent()
                }
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct HomeContent: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 29)

            HStack {
                Spacer().frame(width: 20)

                VStack {
                    Text("Find the best")
                        .font(Metropolis.extraBold(size: 28))
                    Spacer()
                    Text("music for you")
                        .font(Metropolis.extraBold(size: 28))
                }.frame(height: 74)

                Spacer()
            }

            Spacer().frame(height: 24)

            ListRecentMusic()

            Spacer().frame(height: 40)

            HStack {
                Spacer().frame(width: 20)
                Text("Discover").font(Metropolis.extraBold(size: 23))
                Spacer()
            }

            Spacer().frame(height: 19)

            ListMusic()

            Spacer().frame(height: 33)

            HStack {
                Spacer().frame(width: 20)
                Text("New Release").font(Metropolis.extraBold(size: 23))
                Spacer()
            }
        }
    }
}

private struct ListRecentMusic: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 13) {
                Spacer().frame(height: 20)
                RecentMusic()
                RecentMusic()
                RecentMusic()
                RecentMusic()
                RecentMusic()
                RecentMusic()
            }
        }
    }
}

private struct ListMusic: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                Spacer().frame(height: 20)
                MusicView()
                MusicView()
                MusicView()
                MusicView()
                MusicView()
                MusicView()
            }.frame(height: 145)
        }
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
