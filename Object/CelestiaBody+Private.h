/*
 *  CelestiaBoddy+Private.h
 *  celestia
 *
 *  Created by Bob Ippolito on Sat Jun 08 2002.
 *  Copyright (c) 2002 Chris Laurel. All rights reserved.
 *
 */

#import "CelestiaBody.h"
#include <celengine/body.h>

@interface CelestiaBody (Private)

- (instancetype)initWithBody:(Body *)body;
- (Body *)body;

@end
