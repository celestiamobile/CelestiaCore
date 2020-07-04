//
// CelestiaSimulation+Private.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaSimulation.h"
#include <celengine/simulation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaSimulation (Private)

- (instancetype)initWithSimulation:(Simulation*)sim;
- (Simulation *)simulation;

@end

NS_ASSUME_NONNULL_END
