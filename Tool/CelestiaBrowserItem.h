//
//  CelestiaBrowserItem.h
//  CelestiaCore
//
//  Created by Li Linfeng on 13/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaDSO;
@class CelestiaStar;
@class CelestiaBody;
@class CelestiaLocation;
@class CelestiaUniverse;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaBrowserItem : NSObject

- (instancetype)initWithDSO:(CelestiaDSO *)aDSO;
- (instancetype)initWithStar:(CelestiaStar *)aStar;
- (instancetype)initWithBody:(CelestiaBody *)aBody;
- (instancetype)initWithLocation:(CelestiaLocation *)aLocation;
- (instancetype)initWithName:(NSString *)aName;

@end

NS_ASSUME_NONNULL_END
