//
//  CelestiaObserver+Private.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/9/22.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaObserver.h"
#include "observer.h"

@interface CelestiaObserver (Private)

- (instancetype)initWithObserver:(Observer *)observer;
- (Observer *)observer;

@end
