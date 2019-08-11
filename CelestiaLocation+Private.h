//
//  CelestiaLocation.h
//  celestia
//
//  Created by Da Woon Jung on 12/31/06.
//  Copyright 2006 Chris Laurel. All rights reserved.
//

#import "CelestiaLocation.h"
#include "location.h"

@interface CelestiaLocation (Private)

- (instancetype)initWithLocation:(Location *)aLocation;
- (Location*)location;

@end
