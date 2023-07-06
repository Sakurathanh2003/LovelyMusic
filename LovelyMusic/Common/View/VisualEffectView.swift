//
//  VisualEffectView.swift
//  LovelyMusic
//
//  Created by Mei Mei on 06/07/2023.
//

import UIKit
import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .dark
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = UIBlurEffect(style: style) }
}
