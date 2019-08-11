/*
 *  CelestiaGalaxy+Private.h
 *  celestia
 *
 *  Created by Bob Ippolito on Sat Jun 08 2002.
 *  Copyright (c) 2002 Chris Laurel. All rights reserved.
 *
 */

#import "CelestiaGalaxy.h"
#include <celengine/galaxy.h>

@interface CelestiaGalaxy (Private)

- (instancetype)initWithGalaxy:(Galaxy *)galaxy;
- (Galaxy *)galaxy;

@end
