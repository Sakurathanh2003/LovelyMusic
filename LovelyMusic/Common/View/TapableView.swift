//
//  TapableView.swift
//  VavoVideo
//
//  Created by Thanh Vu on 16/02/2021.
//

import Foundation
import UIKit

open class TapableView: UIControl {
    @IBInspectable var dimAlpha: CGFloat = 0.6
    var touchInset: UIEdgeInsets = .zero
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.animate(alpha: dimAlpha)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.animate(alpha: 1)
        
        let location = touches.first!.location(in: self)
        if self.bounds.inset(by: touchInset).contains(location) {
            self.sendActions(for: .touchUpInside)
        }
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.animate(alpha: 1)
    }

    private func animate(alpha: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.alpha = alpha
        }
    }
}
