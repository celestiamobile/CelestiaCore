/*
 *  CelestiaStar+Private.h
 *  celestia
 *
 *  Created by Bob Ippolito on Sat Jun 08 2002.
 *  Copyright (c) 2002 Chris Laurel. All rights reserved.
 *
 */

#import "CelestiaStar.h"
#include <celengine/star.h>

@interface CelestiaStar(Private)

- (instancetype)initWithStar:(Star *)star;
- (Star *)star;

@end
