//
//  AppPreference.swift
//  Wallpaper
//
//  Created by Thanh Vu on 02/03/2022.
//

import Foundation

private struct Const {
    static let startTimesKey = "startTimes"
    static let didShowTapToMinimizeGuide = "didShowTapToMinimizeGuide"
    static let didShowPressToPreviewGuide = "didShowPressToPreviewGuide"
}

class AppPreference {
    var appStartTimes: Int

    init() {
        let userDefault = UserDefaults.standard
        self.appStartTimes = userDefault.integer(forKey: Const.startTimesKey)
    }

    func increaseStartTimes() {
        self.appStartTimes += 1
        let userDefault = UserDefaults.standard
        userDefault.set(self.appStartTimes, forKey: Const.startTimesKey)
        userDefault.synchronize()
    }

    var didShowTapToMinimizeGuide: Bool {
        return UserDefaults.standard.bool(forKey: Const.didShowTapToMinimizeGuide)
    }

    var didShowPressToPreviewGuide: Bool {
        return UserDefaults.standard.bool(forKey: Const.didShowPressToPreviewGuide)
    }

    func markAsDidShowTapToMinimizeGuide() {
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: Const.didShowTapToMinimizeGuide)
        userDefault.synchronize()
    }

    func markAsDidShowPressToPreviewGuide() {
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: Const.didShowPressToPreviewGuide)
        userDefault.synchronize()
    }
}
