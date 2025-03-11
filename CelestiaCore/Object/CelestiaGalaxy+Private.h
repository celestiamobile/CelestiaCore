//
// CelestiaGalaxy+Private.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaGalaxy.h"
#include <celengine/galaxy.h>

@interface CelestiaGalaxy (Private)

- (instancetype)initWithGalaxy:(Galaxy *)galaxy;
- (Galaxy *)galaxy;

@end
