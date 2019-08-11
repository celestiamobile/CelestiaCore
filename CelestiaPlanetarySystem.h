//
//  CelestiaPlanetarySystem.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaBody;
@class CelestiaStar;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaPlanetarySystem : NSObject

@property (nullable, readonly) CelestiaBody *primaryObject;
@property (nullable, readonly) CelestiaStar *star;

@end

NS_ASSUME_NONNULL_END
