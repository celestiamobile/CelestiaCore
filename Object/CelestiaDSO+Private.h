//
//  CelestiaDSO.h
//  celestia
//
//  Created by Da Woon Jung on 12/30/06.
//  Copyright 2006 Chris Laurel. All rights reserved.
//

#import "CelestiaDSO.h"
#include "deepskyobj.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaDSO (Private)

- (instancetype)initWithDSO:(DeepSkyObject *)aDSO;
- (DeepSkyObject *)DSO;

@end

NS_ASSUME_NONNULL_END
