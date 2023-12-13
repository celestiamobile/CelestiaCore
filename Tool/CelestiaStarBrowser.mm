//
// CelestiaStarBrowser.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaStarBrowser.h"
#import "CelestiaStar+Private.h"
#import "CelestiaUniverse+Private.h"
#include "celengine/starbrowser.h"

#define BROWSER_MAX_STAR_COUNT          100

@interface CelestiaStarBrowser () {
    celestia::engine::StarBrowser *b;
}

@end

@implementation CelestiaStarBrowser

- (instancetype)initWithKind:(CelestiaStarBrowserKind)kind universe:(CelestiaUniverse *)universe {
    self = [super init];
    if (self) {
        b = new celestia::engine::StarBrowser([universe universe]);
        switch (kind)
        {
        case CelestiaStarBrowserKindNearest:
            b->setComparison(celestia::engine::StarBrowser::Comparison::Nearest);
            b->setFilter(celestia::engine::StarBrowser::Filter::Visible);
            break;
        case CelestiaStarBrowserKindBrighter:
            b->setComparison(celestia::engine::StarBrowser::Comparison::ApparentMagnitude);
            b->setFilter(celestia::engine::StarBrowser::Filter::Visible);
            break;
        case CelestiaStarBrowserKindBrightest:
            b->setComparison(celestia::engine::StarBrowser::Comparison::AbsoluteMagnitude);
            b->setFilter(celestia::engine::StarBrowser::Filter::Visible);
            break;
        case CelestiaStarBrowserKindStarsWithPlants:
            b->setComparison(celestia::engine::StarBrowser::Comparison::Nearest);
            b->setFilter(celestia::engine::StarBrowser::Filter::WithPlanets);
            break;
        default:
            break;
        }
    }
    return self;
}

- (NSArray<CelestiaStar *> *)stars {
    std::vector<celestia::engine::StarBrowserRecord> records;
    b->populate(records);

    if (records.empty()) return [NSArray array];

    NSMutableArray* starArray = [NSMutableArray array];
    for (const auto &record : records)
    {
        CelestiaStar *star = [[CelestiaStar alloc] initWithStar:const_cast<Star *>(record.star)];
        [starArray addObject:star];
    }

    return starArray;
}

- (void)dealloc {
    delete b;
}

@end
