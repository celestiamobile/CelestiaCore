//
// CelestiaRotationModel+Private.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaRotationModel.h"
#include "celephem/rotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaRotationModel (Private)

- (instancetype)initWithRotation:(const RotationModel *)rotation;
- (const RotationModel *)rotation;

@end

NS_ASSUME_NONNULL_END
