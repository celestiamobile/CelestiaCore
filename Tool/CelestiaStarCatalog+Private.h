//
// CelestiaStarCatalog+Private.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaStarCatalog.h"
#include "celengine/stardb.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaStarCatalog (Private)

- (instancetype)initWithDatabase:(StarDatabase *)database;

- (StarDatabase *)database;

@end

NS_ASSUME_NONNULL_END
