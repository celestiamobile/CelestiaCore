//
//  CelestiaSelection+Private.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaSelection.h"
#include <celengine/selection.h>

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaSelection (Private)

- (instancetype)initWithSelection:(Selection)selection;
- (Selection)selection;

@end

NS_ASSUME_NONNULL_END
