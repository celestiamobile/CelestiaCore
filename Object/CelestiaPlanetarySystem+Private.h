//
//  CelestiaPlanetarySystem+Private.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaPlanetarySystem.h"
#include "celengine/body.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaPlanetarySystem (Private)

- (instancetype)initWithSystem:(PlanetarySystem *)system;
- (PlanetarySystem *)system;

@end

NS_ASSUME_NONNULL_END
