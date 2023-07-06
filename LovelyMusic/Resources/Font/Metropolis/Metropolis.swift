//
//  Metropolis.swift
//  LovelyMusic
//
//  Created by Mei Mei on 06/07/2023.
//

import UIKit
import SwiftUI

public final class Metropolis {
    private static let name = "Metropolis"

    public static func bold(size: CGFloat) -> Font {
        return Font.custom("\(name)-Bold", size: size)
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

