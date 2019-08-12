//
//  CelestiaStarCatalog+Private.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaStarCatalog.h"
#include "celengine/stardb.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaStarCatalog (Private)

- (instancetype)initWithDatabase:(StarDatabase *)database;

- (StarDatabase *)database;

@end

NS_ASSUME_NONNULL_END
