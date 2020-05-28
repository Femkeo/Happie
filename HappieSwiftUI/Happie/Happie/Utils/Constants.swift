//
//  Constants.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import Foundation
import SwiftUI

struct userDefaultKeys {
    static let currentUser = "CurrentUser"
    static let launchedBefore = "wasLaunchedBefore"
}

struct images {
    static let background = "background"
    static let airBalloonScene = "airBalloonScene"
}

struct Colors {
    static let orangeLightest = "orangeLightest"
    static let orangeMid = "orangeMid"
    static let orangeDarkest = "orangeDarkest"
}

func logger<T>(object: T, filename: String = #file, line: Int = #line, funcname: String = #function) {
    // Macro disabled only to run the Playground
    // Remeber to remove the comments
    //#if DEBUG
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss:SSS"
    let process = ProcessInfo.processInfo

    print("\(dateFormatter.string(from: NSDate() as Date)) \(process.processName))[\(process.processIdentifier)]\n \(filename)(\(line))\n \(funcname):\r\t\(object)\n")
    //#endif
}


