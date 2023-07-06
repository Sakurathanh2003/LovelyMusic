//
//  BaseViewModel.swift
//  Wallpaper
//
//  Created by Thanh Vu on 23/02/2022.
//

import Foundation
import RxSwift

public protocol InputOutputViewModel {
    init()
}

public class BaseViewModel<Input: InputOutputViewModel, Output: InputOutputViewModel> {
    var input = Input()
    var output = Output()
    var disposeBag = DisposeBag()
}
