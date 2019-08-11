//
//  CelestiaDSOCatalog+Private.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaDSOCatalog.h"
#include "celengine/dsodb.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaDSOCatalog (Private)

- (instancetype)initWithDatabase:(DSODatabase *)database;

- (DSODatabase *)database;

@end

NS_ASSUME_NONNULL_END
