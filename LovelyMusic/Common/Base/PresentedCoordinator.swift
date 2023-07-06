//
//  PresentedCoordinator.swift
//  Wallpaper
//
//  Created by Thanh Vu on 24/02/2022.
//

import Foundation
import UIKit

open class PresentedCoordinator: Coordinator {
    var presentingViewController: UIViewController

    public init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
}
