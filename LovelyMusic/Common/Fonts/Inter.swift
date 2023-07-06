//
//  Inter.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 18/07/2022.
//

import Foundation

import UIKit
import SwiftUI

public final class Inter {
    private static let name = "Inter"
    
    public static func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(name)-Bold", size: size)!
    }

    public static func italicFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(name)-Italic", size: size)!
    }

    public static func lightFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(name)-Light", size: size)!
    }

    public static func mediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(name)-Medium", size: size)!
    }

    public static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(name)-Regular", size: size)!
    }

    public static func semiboldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(name)-SemiBold", size: size)!
    }

    public static func thinFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(name)-Thin", size: size)!
    }
    
    public static func bold(size: CGFloat) -> Font {
        return Font.custom("\(name)-Bold", size: size)
    }
    
    public static func italic(size: CGFloat) -> Font {
        return Font.custom("\(name)-Italic", size: size)
    }
    
    public static func light(size: CGFloat) -> Font {
        return Font.custom("\(name)-Light", size: size)
    }
    
    public static func medium(size: CGFloat) -> Font {
        return Font.custom("\(name)-Medium", size: size)
    }
    
    public static func regular(size: CGFloat) -> Font {
        return Font.custom("\(name)-Regular", size: size)
    }
    
    public static func semibold(size: CGFloat) -> Font {
        return Font.custom("\(name)-SemiBold", size: size)
    }
    
    public static func thin(size: CGFloat) -> Font {
        return Font.custom("\(name)-Thin", size: size)
    }
}
