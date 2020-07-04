//
// CelestiaBody+Private.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaBody.h"
#include <celengine/body.h>

@interface CelestiaBody (Private)

- (instancetype)initWithBody:(Body *)body;
- (Body *)body;

@end
