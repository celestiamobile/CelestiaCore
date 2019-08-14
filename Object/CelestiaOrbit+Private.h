//
//  CelestiaOrbit+Private.h
//  CelestiaCore
//
//  Created by Li Linfeng on 14/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaOrbit.h"
#include "celephem/orbit.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaOrbit (Private)

- (instancetype)initWithOrbit:(const Orbit *)orbit;
- (const Orbit *)orbit;

@end

NS_ASSUME_NONNULL_END
