//
//  CelestiaRotationModel+Private.h
//  CelestiaCore
//
//  Created by Li Linfeng on 14/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaRotationModel.h"
#include "celephem/rotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaRotationModel (Private)

- (instancetype)initWithRotation:(const RotationModel *)rotation;
- (const RotationModel *)rotation;

@end

NS_ASSUME_NONNULL_END
