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

enum UserDefaultsKey: String {
    case databaseVersion
    case dataDirPath
    case configFile
    case fullDPI
    case msaa
    #if os(iOS) || os(tvOS)
    case frameRate
    case onboardMessageDisplayed
    case lastNewsID
    #endif
}

extension UserDefaults {
    private var databaseVersion: Int { return 1 }

    static let app: UserDefaults = {
        let defaults = UserDefaults.standard
        defaults.initialize()
        return defaults
    }()

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
