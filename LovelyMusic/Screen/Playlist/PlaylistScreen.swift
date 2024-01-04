//
//  PlaylistScreen.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

private struct Const {
    static let backgroundColors = [Color(rgb: 0x0F0817),
                                   Color(rgb: 0x781ECF),
                                   Color(rgb: 0x0F0817)]
    static let padding: CGFloat = 24
}

struct PlaylistScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: Const.backgroundColors, startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack {
                        Image("ic_recentMusic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 343)
                            .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                        
                        VStack {
                            Spacer().frame(height: 65)
                            NavigationBar(
                            didTapBack: {
                                presentationMode.wrappedValue.dismiss()
                            }, didTapMore: {
                                // Action for more Button
                            })
                            
                            Spacer()
                            ZStack {
                                VStack {
                                    HStack {
                                        Spacer().frame(width: Const.padding)
                                        Text("R&B Playlist")
                                            .font(OpenSans.semibold(size: 24))
                                            .foregroundColor(.white)
                                            .frame(height: 32)
                                        Spacer()
                                        Spacer().frame(width: Const.padding)
                                    }
                                    Spacer().frame(height: 4)
                                    HStack {
                                        Spacer().frame(width: Const.padding)
                                        Text("Chill your mind")
                                            .font(OpenSans.regular(size: 14))
                                            .foregroundColor(Color(rgb: 0xA5A5A5))
                                            .frame(height: 16)
                                        Spacer()
                                        Spacer().frame(width: Const.padding)
                                    }
                                }
                                
                                HStack {
                                    Spacer()
                                    Image("ic_heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 24, height: 24)
                                    Spacer().frame(width: 16)
                                    PlayButton(isPlay: false)
                                        .frame(width: 56, height: 56)
                                        .cornerRadius(28)
                                    Spacer().frame(width: Const.padding)
                                }
                            }
                            Spacer().frame(height: 74)
                        }
                    }
                    
                    Spacer().frame(height: 20)
                    ForEach(0..<10) {_ in
                        Spacer().frame(height: Const.padding)
                        HStack {
                            Spacer().frame(width: Const.padding)
                            MusicItem()
                            Spacer().frame(width: Const.padding)
                        }
                    }
                    
                    Spacer().frame(height: Const.padding)
                   
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct PlaylistScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistScreen()
    }
}
