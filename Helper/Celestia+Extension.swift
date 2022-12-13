//
// Celestia+Extension.swift
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

import CelestiaCore
import Foundation

// MARK: singleton
private var core: AppCore?

extension AppCore {
    static var shared: AppCore {
        if core == nil {
            core = AppCore()
        }
        return core!
    }
}

func isCoreInitialized() -> Bool {
    return core?.isInitialized == true
}

extension Selection {
    convenience init?(item: BrowserItem) {
        if let object = item.entry {
            self.init(object: object)
        } else {
            return nil
        }
    }
}

// MARK: Browser
func createStaticBrowserItems() {
    if solBrowserRoot == nil {
        let universe = AppCore.shared.simulation.universe
        if let sol = universe.find("Sol").star {
            solBrowserRoot = BrowserItem(name: universe.starCatalog.starName(sol), alternativeName: CelestiaString("Solar System", comment: ""), catEntry: sol, provider: universe)
        }
    }

    if dsoBrowserRoot == nil {
        let core = AppCore.shared
        let universe = core.simulation.universe

        let typeMap = [
            "SB" : CelestiaString("Galaxies (Barred Spiral)", comment: ""),
            "S" : CelestiaString("Galaxies (Spiral)", comment: ""),
            "E" : CelestiaString("Galaxies (Elliptical)", comment: ""),
            "Irr" : CelestiaString("Galaxies (Irregular)", comment: ""),
            "Neb" : CelestiaString("Nebulae", comment: ""),
            "Glob" : CelestiaString("Globulars", comment: ""),
            "Open cluster" : CelestiaString("Open Clusters", comment: ""),
            "Unknown" : CelestiaString("Unknown", comment: ""),
        ]

        func updateAccumulation(result: inout [String : BrowserItem], item: (key: String, value: [String : BrowserItem])) {
            let fullName = typeMap[item.key]!
            result[fullName] = BrowserItem(name: fullName, children: item.value)
        }

        let prefixes = ["SB", "S", "E", "Irr", "Neb", "Glob", "Open cluster"]

        var tempDict = prefixes.reduce(into: [String : [String : BrowserItem]]()) { $0[$1] = [String : BrowserItem]() }

        let catalog = universe.dsoCatalog
        catalog.forEach({ (dso) in
            let matchingType = prefixes.first(where: {dso.type.hasPrefix($0)}) ?? "Unknown"
            let name = catalog.dsoName(dso)
            if tempDict[matchingType] != nil {
                tempDict[matchingType]![name] = BrowserItem(name: name, catEntry: dso, provider: universe)
            }
        })

        let results = tempDict.reduce(into: [String : BrowserItem](), updateAccumulation)
        dsoBrowserRoot = BrowserItem(name: CelestiaString("Deep Sky Objects", comment: ""), alternativeName: CelestiaString("DSOs", comment: ""), children: results)
    }

    if brightestStars == nil {
        brightestStars = createStarBrowserRootItem(kind: .brightest, title: CelestiaString("Brightest Stars (Absolute Magnitude)", comment: ""), ordered: true)
    }

    if starsWithPlanets == nil {
        starsWithPlanets = createStarBrowserRootItem(kind: .brightest, title: CelestiaString("Stars with Planets", comment: ""), ordered: false)
    }
}

func createStarBrowserRootItem(kind: StarBrowserKind, title: String, ordered: Bool) -> BrowserItem {
    let core = AppCore.shared
    let universe = core.simulation.universe

    func updateAccumulation(result: inout [String : BrowserItem], star: Star) {
        let name = universe.starCatalog.starName(star)
        result[name] = BrowserItem(name: name, catEntry: star, provider: universe)
    }

    func updateAccumulationOrdered(result: inout [BrowserItemKeyValuePair], star: Star) {
        let name = universe.starCatalog.starName(star)
        result.append(BrowserItemKeyValuePair(name: name, browserItem: BrowserItem(name: name, catEntry: star, provider: universe)))
    }

    if ordered {
        let items = StarBrowser(kind: kind, simulation: core.simulation).stars().reduce(into: [BrowserItemKeyValuePair](), updateAccumulationOrdered)
        return BrowserItem(name: title, orderedChildren: items)
    } else {
        let items = StarBrowser(kind: kind, simulation: core.simulation).stars().reduce(into: [String : BrowserItem](), updateAccumulation)
        return BrowserItem(name: title, children: items)
    }
}

func createDynamicBrowserItems() {
    let nearest = createStarBrowserRootItem(kind: .nearest, title: CelestiaString("Nearest Stars", comment: ""), ordered: true)
    let brighter = createStarBrowserRootItem(kind: .brighter, title: CelestiaString("Brightest Stars", comment: ""), ordered: true)

    var children = [
        nearest.name: nearest,
        brighter.name: brighter,
    ]

    if let brightest = brightestStars {
        children[brightest.name] = brightest
    }

    if let hasPlanets = starsWithPlanets {
        children[hasPlanets.name] = hasPlanets
    }
    starBrowserRoot = BrowserItem(name: CelestiaString("Stars", comment: ""), children: children)
}

var solBrowserRoot: BrowserItem?
var starBrowserRoot: BrowserItem?
var dsoBrowserRoot: BrowserItem?
var brightestStars: BrowserItem?
var starsWithPlanets: BrowserItem?

extension DSOCatalog {
    subscript(index: Int) -> DSO {
        get {
            return object(at: index)
        }
    }
}

public struct DSOCatalogIterator: IteratorProtocol {
    private let catalog: DSOCatalog
    private var index = 0

    public typealias Element = DSO

    init(catalog: DSOCatalog) {
        self.catalog = catalog
    }

    mutating public func next() -> DSO? {
        defer { index += 1 }
        if index >= catalog.count {
            return nil
        }
        return catalog[index]
    }
}

extension DSOCatalog: Sequence {
    public typealias Iterator = DSOCatalogIterator

    public __consuming func makeIterator() -> DSOCatalogIterator {
        return DSOCatalogIterator(catalog: self)
    }
}

// MARK: Localization
func CelestiaString(_ key: String, comment: String, domain: String = "celestia_ui") -> String {
    if key.isEmpty { return key }
    return LocalizedString(key, domain)
}

func CelestiaFilename(_ key: String) -> String {
    return LocalizedFilename(key)
}

// MARK: Scripting
func readScripts() -> [Script] {
    var scripts = Script.scripts(inDirectory: "scripts", deepScan: true)
    if let extraScriptsPath = extraScriptDirectory?.path {
        scripts += Script.scripts(inDirectory: extraScriptsPath, deepScan: true)
    }
    return scripts
}

// MARK: Bookmark
final class BookmarkNode: NSObject {
    let isFolder: Bool

    @objc var name: String
    @objc var url: String
    @objc var children: [BookmarkNode]

    init(name: String, url: String, isFolder: Bool, children: [BookmarkNode] = []) {
        self.name = name
        self.url = url
        self.isFolder = isFolder
        self.children = children
        super.init()
    }

    @objc var isLeaf: Bool {
        return !isFolder
    }
}

extension BookmarkNode: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case isFolder
        case children
    }
}

extension AppCore {
    var currentBookmark: BookmarkNode? {
        let selection = simulation.selection
        if selection.isEmpty {
            return nil
        }
        let name: String
        if let star = selection.star {
            name = simulation.universe.starCatalog.starName(star)
        } else if let body = selection.body {
            name = body.name
        } else if let dso = selection.dso {
            name = simulation.universe.dsoCatalog.dsoName(dso)
        } else if let location = selection.location {
            name = location.name
        } else {
            name = CelestiaString("Unknown", comment: "")
        }
        return BookmarkNode(name: name, url: currentURL, isFolder: false)
    }
}

func readBookmarks() -> [BookmarkNode] {
    guard let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first else {
        return []
    }
    let bookmarkFilePath = "\(path)/bookmark.json"
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: bookmarkFilePath))
        return try JSONDecoder().decode([BookmarkNode].self, from: data)
    } catch let error {
        print("Bookmark reading error: \(error.localizedDescription)")
        return []
    }
}

func storeBookmarks(_ bookmarks: [BookmarkNode]) {
    guard let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first else {
        return
    }
    let bookmarkFilePath = "\(path)/bookmark.json"
    do {
        try JSONEncoder().encode(bookmarks).write(to: URL(fileURLWithPath: bookmarkFilePath))
    } catch let error {
        print("Bookmark writing error: \(error.localizedDescription)")
    }
}

extension String {
    var toLocalizationTemplate: String {
        // FIXME: this does not fix multiple %s with different indices
        return replacingOccurrences(of: "%s", with: "%@")
    }
}

// MARK: Overview
extension AppCore {
    func overviewForSelection(_ selection: Selection) -> String {
        if let body = selection.body {
            return overviewForBody(body)
        } else if let star = selection.star {
            return overviewForStar(star)
        } else if let dso = selection.dso {
            return overviewForDSO(dso)
        } else {
            return CelestiaString("No overview available.", comment: "")
        }
    }

    private func overviewForBody(_ body: Body) -> String {
        var str = ""

        let radius = body.radius
        let radiusString: String
        let oneMiInKm: Float = 1.609344
        let oneFtInKm: Float = 0.0003048
        if (measurementSystem == .imperial) {
            if (radius >= oneMiInKm) {
                radiusString = String.localizedStringWithFormat(CelestiaString("%d mi", comment: ""), Int(radius / oneMiInKm))
            } else {
                radiusString = String.localizedStringWithFormat(CelestiaString("%d ft", comment: ""), Int(radius / oneFtInKm))
            }
        } else {
            if (radius >= 1) {
                radiusString = String.localizedStringWithFormat(CelestiaString("%d km", comment: ""), Int(radius))
            } else {
                radiusString = String.localizedStringWithFormat(CelestiaString("%d m", comment: ""), Int(radius * 1000))
            }
        }

        if body.isEllipsoid {
            str += String.localizedStringWithFormat(CelestiaString("Equatorial radius: %s", comment: "").toLocalizationTemplate, radiusString)
        } else {
            str += String.localizedStringWithFormat(CelestiaString("Size: %s", comment: "").toLocalizationTemplate, radiusString)
        }

        let orbit = body.orbit(at: simulation.time)
        let rotation = body.rotation(at: simulation.time)

        let orbitalPeriod: TimeInterval = orbit.isPeriodic ? orbit.period : 0

        if rotation.isPeriodic && body.type != .spacecraft {

            var rotPeriod = rotation.period

            var dayLength: TimeInterval = 0.0

            if orbit.isPeriodic {
                let siderealDaysPerYear = orbitalPeriod / rotPeriod
                let solarDaysPerYear = siderealDaysPerYear - 1.0
                if solarDaysPerYear > 0.0001 {
                    dayLength = orbitalPeriod / (siderealDaysPerYear - 1.0)
                }
            }

            let unitTemplate: String

            if rotPeriod < 2.0 {
                rotPeriod *= 24.0
                dayLength *= 24.0

                unitTemplate = CelestiaString("%.2f hours", comment: "")
            } else {
                unitTemplate = CelestiaString("%.2f days", comment: "")
            }
            str += "\n"
            str += String.localizedStringWithFormat(CelestiaString("Sidereal rotation period: %s", comment: "").toLocalizationTemplate, String.localizedStringWithFormat(CelestiaString(unitTemplate, comment: ""), rotPeriod))
            if dayLength != 0 {
                str += "\n"
                str += String.localizedStringWithFormat(CelestiaString("Length of day: %s", comment: "").toLocalizationTemplate, String.localizedStringWithFormat(CelestiaString(unitTemplate, comment: ""), dayLength))
            }
        }

        if body.hasRings {
            str += "\n"
            str += CelestiaString("Has rings", comment: "")
        }
        if body.hasAtmosphere {
            str += "\n"
            str += CelestiaString("Has atmosphere", comment: "")
        }

        return str
    }

    private func overviewForStar(_ star: Star) -> String {
        var str = ""

        let time = simulation.time

        let celPos = star.position(at: time).offet(from: .zero)
        let eqPos = AstroUtils.ecliptic(toEquatorial: AstroUtils.cel(toJ2000Ecliptic: celPos))
        let sph = AstroUtils.rect(toSpherical: eqPos)

        let hms = DMS(decimal: sph.dx)
        str += String.localizedStringWithFormat(CelestiaString("RA: %dh %dm %.2fs", comment: ""), hms.hours, abs(hms.minutes), abs(hms.seconds))

        str += "\n"
        let dms = DMS(decimal: sph.dy)
        str += String.localizedStringWithFormat(CelestiaString("DEC: %d° %d′ %.2f″", comment: ""), dms.degrees, abs(dms.minutes), abs(dms.seconds))

        return str
    }

    private func overviewForDSO(_ dso: DSO) -> String {
        var str = ""

        let celPos = dso.position
        let eqPos = AstroUtils.ecliptic(toEquatorial: AstroUtils.cel(toJ2000Ecliptic: celPos))
        var sph = AstroUtils.rect(toSpherical: eqPos)

        let hms = DMS(decimal: sph.dx)
        str += String.localizedStringWithFormat(CelestiaString("RA: %dh %dm %.2fs", comment: ""), hms.hours, abs(hms.minutes), abs(hms.seconds))

        str += "\n"
        var dms = DMS(decimal: sph.dy)
        str += String.localizedStringWithFormat(CelestiaString("Dec: %d° %d′ %.2f″", comment: ""), dms.degrees, abs(dms.minutes), abs(dms.seconds))

        let galPos = AstroUtils.equatorial(toGalactic: eqPos)
        sph = AstroUtils.rect(toSpherical: galPos)

        str += "\n"
        dms = DMS(decimal: sph.dx)
        str += String.localizedStringWithFormat(CelestiaString("L: %d° %d′ %.2f″", comment: ""), dms.degrees, abs(dms.minutes), abs(dms.seconds))

        str += "\n"
        dms = DMS(decimal: sph.dy)
        str += String.localizedStringWithFormat(CelestiaString("B: %d° %d′ %.2f″", comment: ""), dms.degrees, abs(dms.minutes), abs(dms.seconds))

        return str
    }
}
