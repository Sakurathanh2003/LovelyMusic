//
//  ToneWaveformView.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 04/08/2022.
//

import SwiftUI
import UIKit
import Foundation
import AVFoundation

struct ToneWaveformView: View {
    @StateObject var viewModel: ToneWaveformViewModel
    @ObservedObject var timeViewModel: ToneCurrentTimeViewModel
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<viewModel.powers.count, id: \.self) { index in
            Rectangle()
                .stroke(Color.clear)
                .frame(width: 0.5, height: viewModel.getHeight(index: index))
                .cornerRadius(0.5)
                .background(
                    GeometryReader { reader -> Color in
                        return index <= timeViewModel.currentPower(asset: viewModel.asset, powers: viewModel.powers) ? Color.red : Color(rgb: 0xFFFFFF).opacity(0.25)
                    }
                )
            }.animation(Animation.easeOut)
        }
        .frame(height: 17)
        .onAppear {
            Task {
                await viewModel.onViewAppear()
            }
        }
    }
}


struct ToneWaveformView_Previews: PreviewProvider {
    static var previews: some View {
        ToneWaveformView(viewModel: ToneWaveformViewModel(asset: AVAsset(), width: 100), timeViewModel: ToneCurrentTimeViewModel(currentTime: 0))
        .previewLayout(.sizeThatFits)
    }
}
