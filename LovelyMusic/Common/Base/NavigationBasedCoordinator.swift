//
//  NavigationBasedCoordinator.swift
//  Wallpaper
//
//  Created by Thanh Vu on 24/02/2022.
//

import Foundation
import UIKit

open class NavigationBasedCoordinator: Coordinator {
    var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
}
