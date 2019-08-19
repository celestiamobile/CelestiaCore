//
//  CelestiaStarCatalog.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaStar;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaStarCatalog : NSObject

@property (readonly) NSInteger count;

- (CelestiaStar *)objectAtIndex:(NSInteger)index;

- (NSString *)starName:(CelestiaStar *)star;

- (NSArray<NSString *> *)completionForName:(NSString *)name NS_SWIFT_NAME(completion(for:));

@end

NS_ASSUME_NONNULL_END
