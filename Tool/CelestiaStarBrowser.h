//
//  CelestiaStarBrowser.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
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
