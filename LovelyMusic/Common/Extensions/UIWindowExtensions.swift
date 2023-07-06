//
//  UIWindowExtensions.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 06/07/2022.
//

import UIKit

extension UIWindow {
    static var topPresentViewController: UIViewController? {
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else {
            return nil
        }
        
        var topViewController = keyWindow.rootViewController
        while let presentedVC = topViewController?.presentedViewController {
            topViewController = presentedVC
        }
        
        return topViewController
    }
}
