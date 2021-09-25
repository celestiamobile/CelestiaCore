//
// UserDefaults.swift
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

import Foundation

private var appDefaults: UserDefaults?

enum UserDefaultsKey: String {
    case databaseVersion
    case dataDirPath
    case configFile
    case fullDPI
    case msaa
    #if os(iOS) || os(tvOS)
    case frameRate
    case onboardMessageDisplayed
    #endif
}

extension UserDefaults {
    private var databaseVersion: Int { return 1 }

    static var app: UserDefaults {
        if appDefaults == nil {
            appDefaults = .standard
            appDefaults?.initialize()
        }
        return appDefaults!
    }

    private func upgrade() {
        self[.databaseVersion] = databaseVersion
    }

    private func initialize() {
        upgrade()
    }

    subscript<T>(key: UserDefaultsKey) -> T? {
        get {
            return value(forKey: key.rawValue) as? T
        }
        set {
            setValue(newValue, forKey: key.rawValue)
        }
    }
}
