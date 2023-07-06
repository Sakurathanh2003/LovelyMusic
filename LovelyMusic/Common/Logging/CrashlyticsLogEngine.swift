//
//  CrashlyticsLogEngine.swift
//  PlantIdentification
//
//  Created by Thanh Vu on 25/11/2020.
//

import Foundation
import FirebaseCrashlytics
class CrashlyticsLogEngine: LoggingEngine {
    func log(_ msg: String) {
        Crashlytics.crashlytics().log(msg)
    }
}
