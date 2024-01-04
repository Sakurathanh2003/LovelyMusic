//
//  PlayMusicScreen.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import SwiftUI

private struct Const {
    static let backgroundColors = [Color(rgb: 0x0F0817),
                                   Color(rgb: 0x781ECF),
                                   Color(rgb: 0x0F0817),
                                   Color(rgb: 0x781ECF)]
    static let padding: CGFloat = 24
}

struct PlayMusicScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: Const.backgroundColors, startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 65)
                    NavigationBar(
                    didTapBack: {
                        presentationMode.wrappedValue.dismiss()
                    }, didTapMore: {
                        // Action for more Button
                    })
                    
                    Spacer().frame(height: 40)
                    
                    HStack {
                        Spacer().frame(width: Const.padding)
                        Image("ic_recentMusic")
                            .resizable()
                            .frame(height: UIScreen.main.bounds.width - 2 * Const.padding)
                            .cornerRadius(10)
                            
                        Spacer().frame(width: Const.padding)
                    }
                    
                    Spacer().frame(height: 40)
                    
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
                            Spacer().frame(width: Const.padding)
                        }
                    }
                    
                    Group {
                        Spacer().frame(height: 40)
                        HStack {
                            Spacer().frame(width: Const.padding)
                            SeekBar()
                            Spacer().frame(width: Const.padding)
                        }
                        
                        Spacer().frame(height: 8)
                        HStack {
                            Spacer().frame(width: Const.padding)
                            Text("1:24")
                                .font(OpenSans.regular(size: 14))
                                .foregroundColor(.white)
                            Spacer()
                            Text("3:58")
                                .font(OpenSans.regular(size: 14))
                                .foregroundColor(.white)
                            Spacer().frame(width: Const.padding)
                        }
                    }
                    
                    Spacer().frame(height: 60)
                    Group {
                        HStack {
                            Spacer().frame(width: Const.padding)
                            Image("ic_shuffle")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Spacer()
                            Group {
                                Image("ic_previousSong")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Spacer().frame(width: 20)
                                PlayButton(isPlay: false)
                                    .frame(width: 64, height: 64)
                                    .cornerRadius(32)
                                Spacer().frame(width: 20)
                                Image("ic_nextSong")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Spacer()
                            }
                           
                            Image("ic_repeat")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Spacer().frame(width: Const.padding)
                        }
                    }
                   
                    
                   Spacer()
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct PlayMusicScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayMusicScreen()
    }
}
