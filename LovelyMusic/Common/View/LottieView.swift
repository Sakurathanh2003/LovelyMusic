//
//  LottieView.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 01/08/2022.
//

import Foundation
import SwiftUI
import Lottie
import UIKit

struct LottieView: UIViewRepresentable {
    var animationView: AnimationView
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.fitSuperviewConstraint()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}
