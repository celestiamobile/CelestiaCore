//
//  Celestia+Extension.swift
//  MobileCelestia
//
//  Created by Li Linfeng on 2020/2/24.
//  Copyright © 2020 李林峰. All rights reserved.
//

import CelestiaCore

// MARK: singleton
private var core: CelestiaAppCore?

extension CelestiaAppCore {
    static var shared: CelestiaAppCore {
        if core == nil {
            core = CelestiaAppCore()
        }
        return core!
    }
}

func isCoreInitialized() -> Bool {
    return core?.isInitialized == true
}

extension CelestiaSelection {
    convenience init?(item: CelestiaBrowserItem) {
        if let object = item.entry {
            self.init(object: object)
        } else {
            return nil
        }
    }
}

var renderInfo: String {
    return CelestiaAppCore.shared.renderInfo
}

// MARK: Browser
var solBrowserRoot: CelestiaBrowserItem = {
    let universe = CelestiaAppCore.shared.simulation.universe
    let sol = universe.find("Sol")
    return CelestiaBrowserItem(name: universe.starCatalog.starName(sol.star!), catEntry: sol.star!, provider: universe)
}()

var starBrowserRoot: CelestiaBrowserItem = {
    let core = CelestiaAppCore.shared
    let universe = core.simulation.universe

    func updateAccumulation(result: inout [String : CelestiaBrowserItem], star: CelestiaStar) {
        let name = universe.starCatalog.starName(star)
        result[name] = CelestiaBrowserItem(name: name, catEntry: star, provider: universe)
    }

    let nearest = CelestiaStarBrowser(kind: .nearest, simulation: core.simulation).stars().reduce(into: [String : CelestiaBrowserItem](), updateAccumulation)
    let brightest = CelestiaStarBrowser(kind: .brightest, simulation: core.simulation).stars().reduce(into: [String : CelestiaBrowserItem](), updateAccumulation)
    let hasPlanets = CelestiaStarBrowser(kind: .starsWithPlants, simulation: core.simulation).stars().reduce(into: [String : CelestiaBrowserItem](), updateAccumulation)

    let nearestName = CelestiaString("Nearest Stars", comment: "")
    let brightestName = CelestiaString("Brightest Stars", comment: "")
    let hasPlanetsName = CelestiaString("Stars With Planets", comment: "")
    let stars = CelestiaBrowserItem(name: CelestiaString("Stars", comment: ""), children: [
        nearestName : CelestiaBrowserItem(name: nearestName, children: nearest),
        brightestName : CelestiaBrowserItem(name: brightestName, children: brightest),
        hasPlanetsName : CelestiaBrowserItem(name: hasPlanetsName, children: hasPlanets),
    ])
    return stars
}()

var dsoBrowserRoot: CelestiaBrowserItem = {
    let core = CelestiaAppCore.shared
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

    func updateAccumulation(result: inout [String : CelestiaBrowserItem], item: (key: String, value: [String : CelestiaBrowserItem])) {
        let fullName = typeMap[item.key]!
        result[fullName] = CelestiaBrowserItem(name: fullName, children: item.value)
    }

    let prefixes = ["SB", "S", "E", "Irr", "Neb", "Glob", "Open cluster"]

    var tempDict = prefixes.reduce(into: [String : [String : CelestiaBrowserItem]]()) { $0[$1] = [String : CelestiaBrowserItem]() }

    let catalog = universe.dsoCatalog
    catalog.forEach({ (dso) in
        let matchingType = prefixes.first(where: {dso.type.hasPrefix($0)}) ?? "Unknown"
        let name = catalog.dsoName(dso)
        if tempDict[matchingType] != nil {
            tempDict[matchingType]![name] = CelestiaBrowserItem(name: name, catEntry: dso, provider: universe)
        }
    })

    let results = tempDict.reduce(into: [String : CelestiaBrowserItem](), updateAccumulation)
    return CelestiaBrowserItem(name: CelestiaString("Deep Sky Objects", comment: ""), children: results)
}()

extension CelestiaDSOCatalog {
    subscript(index: Int) -> CelestiaDSO {
        get {
            return object(at: index)
        }
    }
}

public struct CelestiaDSOCatalogIterator: IteratorProtocol {
    private let catalog: CelestiaDSOCatalog
    private var index = 0

    public typealias Element = CelestiaDSO

    init(catalog: CelestiaDSOCatalog) {
        self.catalog = catalog
    }

    mutating public func next() -> CelestiaDSO? {
        defer { index += 1 }
        if index >= catalog.count {
            return nil
        }
        return catalog[index]
    }
}

extension CelestiaDSOCatalog: Sequence {
    public typealias Iterator = CelestiaDSOCatalogIterator

    public __consuming func makeIterator() -> CelestiaDSOCatalogIterator {
        return CelestiaDSOCatalogIterator(catalog: self)
    }
}

// MARK: Localization
func CelestiaString(_ key: String, comment: String) -> String {
    return LocalizedString(key)
}

func CelestiaFilename(_ key: String) -> String {
    return LocalizedFilename(key)
}

// MARK: Scripting
func readScripts() -> [CelestiaScript] {
    var scripts = CelestiaScript.scripts(inDirectory: "scripts", deepScan: true)
    if let extraScriptsPath = extraScriptDirectory?.path {
        scripts += CelestiaScript.scripts(inDirectory: extraScriptsPath, deepScan: true)
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

extension CelestiaAppCore {
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

// MARK: Overview
extension CelestiaAppCore {
    func overviewForSelection(_ selection: CelestiaSelection) -> String {
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

    private func overviewForBody(_ body: CelestiaBody) -> String {
        var str = ""

        if body.isEllipsoid {
            str += String(format: CelestiaString("Equatorial radius: %@", comment: ""), body.radius.radiusString)
        } else {
            str += String(format: CelestiaString("Size: %@", comment: ""), body.radius.radiusString)
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
            str += String(format: CelestiaString("Sidereal rotation period: %@", comment: ""), String(format: CelestiaString(unitTemplate, comment: ""), rotPeriod))
            if dayLength != 0 {
                str += "\n"
                str += String(format: CelestiaString("Length of day: %@", comment: ""), String(format: CelestiaString(unitTemplate, comment: ""), dayLength))
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

    private func overviewForStar(_ star: CelestiaStar) -> String {
        var str = ""

        let time = simulation.time

        let celPos = star.position(at: time).offet(from: .zero)
        let eqPos = Astro.ecliptic(toEquatorial: Astro.cel(toJ2000Ecliptic: celPos))
        let sph = Astro.rect(toSpherical: eqPos)

        let hms = DMS(decimal: sph.dx)
        str += String(format: CelestiaString("RA: %dh %dm %.2fs", comment: ""), hms.hours, abs(hms.minutes), abs(hms.seconds))

        str += "\n"
        let dms = DMS(decimal: sph.dy)
        str += String(format: CelestiaString("DEC: %d° %d′ %.2f″", comment: ""), dms.degrees, abs(dms.minutes), abs(dms.seconds))

        return str
    }

    private func overviewForDSO(_ dso: CelestiaDSO) -> String {
        var str = ""

        let celPos = dso.position
        let eqPos = Astro.ecliptic(toEquatorial: Astro.cel(toJ2000Ecliptic: celPos))
        var sph = Astro.rect(toSpherical: eqPos)

        let hms = DMS(decimal: sph.dx)
        str += String(format: CelestiaString("RA: %dh %dm %.2fs", comment: ""), hms.hours, abs(hms.minutes), abs(hms.seconds))

        str += "\n"
        var dms = DMS(decimal: sph.dy)
        str += String(format: CelestiaString("Dec: %d° %d′ %.2f″", comment: ""), dms.degrees, abs(dms.minutes), abs(dms.seconds))

        let galPos = Astro.equatorial(toGalactic: eqPos)
        sph = Astro.rect(toSpherical: galPos)

        str += "\n"
        dms = DMS(decimal: sph.dx)
        str += String(format: CelestiaString("L: %d° %d′ %.2f″", comment: ""), dms.degrees, abs(dms.minutes), abs(dms.seconds))

        str += "\n"
        dms = DMS(decimal: sph.dy)
        str += String(format: CelestiaString("B: %d° %d′ %.2f″", comment: ""), dms.degrees, abs(dms.minutes), abs(dms.seconds))

        return str
    }
}

private extension Float {
    var radiusString: String {
        if self < 1 {
            return String(format: CelestiaString("%d m", comment: ""), Int(self * 1000))
        }
        return String(format: CelestiaString("%d km", comment: ""), Int(self))
    }
}
