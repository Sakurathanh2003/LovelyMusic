//
//  TapableModifier.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 30/06/2022.
//

import Foundation
import SwiftUI

internal extension View {
    func onTapable(_ action: @escaping () -> Void) -> some View {
        modifier(TapableModifier(touchUpInside: action))
    }
}

struct TapableModifier: ViewModifier {
    @State private var isHighlighted = false
    let touchUpInside: (() -> Void)?

    init(touchUpInside: @escaping (() -> Void)) {
        self.touchUpInside = touchUpInside
    }

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(TapGesture().onEnded({ _ in
                self.touchUpInside?()

                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    self.isHighlighted = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        self.isHighlighted = false
                    }
                }
            }))
            .scaleEffect(isHighlighted ? 0.9 : 1)
    }
}
