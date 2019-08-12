//
//  CelestiaSimulation+Private.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaSimulation.h"
#include <celengine/simulation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaSimulation (Private)

- (instancetype)initWithSimulation:(Simulation*)sim;
- (Simulation *)simulation;

@end

NS_ASSUME_NONNULL_END
