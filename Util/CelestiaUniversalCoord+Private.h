/*
 *  CelestiaUniversalCoord+Private.h
 *  celestia
 *
 *  Created by Bob Ippolito on Fri Jun 07 2002.
 *  Copyright (c) 2002 Chris Laurel. All rights reserved.
 *
 */

#import "CelestiaUniversalCoord.h"
#include <celengine/univcoord.h>

@interface CelestiaUniversalCoord (Private)

- (instancetype)initWithUniversalCoord:(UniversalCoord)uni;
- (UniversalCoord)universalCoord;

@end
