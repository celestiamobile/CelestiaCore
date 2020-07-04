//
// CelestiaStarBrowser.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import <Foundation/Foundation.h>

@class CelestiaStar;
@class CelestiaSimulation;

typedef NS_ENUM(NSUInteger, CelestiaStarBrowserKind) {
    CelestiaStarBrowserKindNearest = 0,
    CelestiaStarBrowserKindBrightest = 2,
    CelestiaStarBrowserKindStarsWithPlants = 3,
};

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaStarBrowser : NSObject

- (instancetype)initWithKind:(CelestiaStarBrowserKind)kind simulation:(CelestiaSimulation *)simulation;

- (NSArray<CelestiaStar *> *)stars;

@end

NS_ASSUME_NONNULL_END
