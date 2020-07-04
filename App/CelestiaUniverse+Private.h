//
// CelestiaUniverse+Private.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaUniverse.h"
#include <celengine/universe.h>

@interface CelestiaUniverse (Private)

- (instancetype)initWithUniverse:(Universe *)uni;
- (Universe *)universe;

@end
