//
//  ActivityIndicatorView.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 18/07/2022.
//

import SwiftUI

struct ActivityIndicatorView: View {
    var body: some View {
        ZStack {
            BlurView(style: .dark)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(3.0)
        }
        .ignoresSafeArea()
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
