//
// URL.swift
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

import Foundation

class UniformedURL {
    private let securityScoped: Bool

    let url: URL
    let stale: Bool

    private init?(url: URL, securityScoped: Bool, stale: Bool) {
        if securityScoped && !url.startAccessingSecurityScopedResource() {
            return nil
        }
        self.stale = stale
        self.url = url
        self.securityScoped = securityScoped
    }

    convenience init(url: URL, securityScoped: Bool = false) {
        self.init(url: url, securityScoped: securityScoped, stale: false)!
    }

    convenience init?(bookmark: Data) throws {
        var stale: Bool = false
        #if os(macOS) || targetEnvironment(macCatalyst)
        let resolved = try URL(resolvingBookmarkData: bookmark, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &stale)
        #else
        let resolved = try URL(resolvingBookmarkData: bookmark, options: .withoutUI, relativeTo: nil, bookmarkDataIsStale: &stale)
        #endif
        self.init(url: resolved, securityScoped: true, stale: stale)
    }

    func bookmark() throws -> Data? {
        if !stale || !securityScoped { return nil }
        // only generate bookmark when it is stale
        let bookmark = try url.bookmarkData(options: .init(rawValue: 0), includingResourceValuesForKeys: nil, relativeTo: nil)
        return bookmark
    }

    deinit {
        if securityScoped {
            url.stopAccessingSecurityScopedResource()
        }
    }
}

extension Bundle {
    static var app: Bundle {
        let current = Bundle.main
        if current.bundleURL.pathExtension == "appex" {
            #if os(macOS) || targetEnvironment(macCatalyst)
            return Bundle(url: current.bundleURL.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent())!
            #else
            return Bundle(url: current.bundleURL.deletingLastPathComponent().deletingLastPathComponent())!
            #endif
        }
        return current
    }
}

let defaultDataDirectory: URL = {
    return Bundle.app.url(forResource: "CelestiaResources", withExtension: nil)!
}()

let defaultConfigFile: URL = {
    return defaultDataDirectory.appendingPathComponent("celestia.cfg")
}()

let extraDirectory: URL? = {
    let supportDirectory = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    let parentDirectory = supportDirectory.appendingPathComponent("CelestiaResources")
    do {
        try FileManager.default.createDirectory(at: parentDirectory, withIntermediateDirectories: true, attributes: nil)
        let extraDirectory = parentDirectory.appendingPathComponent("extras")
        try FileManager.default.createDirectory(at: extraDirectory, withIntermediateDirectories: true, attributes: nil)
        let scriptDirectory = parentDirectory.appendingPathComponent("scripts")
        try FileManager.default.createDirectory(at: scriptDirectory, withIntermediateDirectories: true, attributes: nil)
    } catch _ {
        return nil
    }
    return parentDirectory
}()

let extraScriptDirectory: URL? = extraDirectory?.appendingPathComponent("scripts")

private func path(for key: UserDefaultsKey, defaultValue: URL) -> UniformedURL {
    if let bookmark: Data = UserDefaults.app[key] {
        if let url = try? UniformedURL(bookmark: bookmark) {
            if url.stale {
                do {
                    if let newBookmark = try url.bookmark() {
                        UserDefaults.app[key] = newBookmark
                    }
                } catch {}
            }
            return url
        }
        return UniformedURL(url: defaultValue)
    } else if let path: String = UserDefaults.app[key] {
        return UniformedURL(url: URL(fileURLWithPath: path))
    } else {
        return UniformedURL(url: defaultValue)
    }
}

func currentDataDirectory() -> UniformedURL {
    return path(for: .dataDirPath, defaultValue: defaultDataDirectory)
}

func currentConfigFile() -> UniformedURL {
    return path(for: .configFile, defaultValue: defaultConfigFile)
}

func saveDataDirectory(_ bookmark: Data?) {
    UserDefaults.app[.dataDirPath] = bookmark
}

func saveConfigFile(_ bookmark: Data?) {
    UserDefaults.app[.configFile] = bookmark
}
