//
//  NetworkErrorEmbededView.swift
//  Wallpaper
//
//  Created by Thanh Vu on 04/03/2022.
//

import Foundation
import UIKit

final class NetworkErrorEmbededView: UIView {
    var retryAction: (() -> Void)?
    @IBAction func retryButtonDidTap(_ sender: Any) {
        retryAction?()
    }
}
