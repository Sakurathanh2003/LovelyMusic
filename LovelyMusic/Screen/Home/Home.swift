//
//  Home.swift
//  LovelyMusic
//
//  Created by Mei Mei on 06/07/2023.
//

import SwiftUI

private struct Const {
    static let backgroundColors = [Color(rgb: 0x0F0817), Color(rgb: 0x781ECF)]
    static let padding: CGFloat = 24
}

struct Home: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: Const.backgroundColors, startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    Spacer().frame(height: Const.padding)
                    HomeTitle()
                    Spacer().frame(height: 24)
                    HStack {
                        Spacer().frame(width: Const.padding)
                        HomeSearchBar()
                        Spacer().frame(width: Const.padding)
                    }
                    Spacer().frame(height: 40)
                    CategoryMusic()
                    Spacer().frame(height: 28)
                    ListPlaylist()
                    Spacer().frame(height: 40)
                    HStack {
                        Spacer().frame(width: Const.padding)
                        ListFavoriteMusic()
                        Spacer().frame(width: Const.padding)
                    }
                }
            }
        }
        .environmentObject(viewModel)
        .navigationBarHidden(true)
    }
}

struct HomeTitle: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer().frame(width: Const.padding)
                Text("Welcome back!")
                    .font(OpenSans.bold(size: 24))
                    .foregroundColor(.white)
                    .frame(height: 32)
                Spacer()
            }
            
            HStack {
                Spacer().frame(width: Const.padding)
                Text("What do you feel like today?")
                    .font(OpenSans.semibold(size: 14))
                    .foregroundColor(Color(rgb: 0xA5A5A5))
                    .frame(height: 16)
                Spacer()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
