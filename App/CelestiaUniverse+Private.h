/*
 *  CelestiaUniverse+Private.h
 *  celestia
 *
 *  Created by Bob Ippolito on Fri Jun 07 2002.
 *  Copyright (c) 2002 Chris Laurel. All rights reserved.
 *
 */

#import "CelestiaUniverse.h"
#include <celengine/universe.h>

@interface CelestiaUniverse (Private)

- (instancetype)initWithUniverse:(Universe *)uni;
- (Universe *)universe;

@end
