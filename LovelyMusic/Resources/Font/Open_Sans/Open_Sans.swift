//
//  Open_Sans.swift
//  LovelyMusic
//
//  Created by MeiMei on 04/01/2024.
//

import UIKit
import SwiftUI

public final class OpenSans {
    private static let name = "OpenSans"

    public static func bold(size: CGFloat) -> Font {
        return Font.custom("\(name)-Bold", size: size)
    }
    
    public static func regular(size: CGFloat) -> Font {
        return Font.custom("\(name)-Regular", size: size)
    }

    public static func medium(size: CGFloat) -> Font {
        return Font.custom("\(name)-Medium", size: size)
    }

    public static func semibold(size: CGFloat) -> Font {
        return Font.custom("\(name)-SemiBold", size: size)
    }

    public static func extraBold(size: CGFloat) -> Font {
        return Font.custom("\(name)-ExtraBold", size: size)
    }
}
