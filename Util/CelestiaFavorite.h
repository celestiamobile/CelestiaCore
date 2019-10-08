//
//  CelestiaFavorite.h
//  CelestiaCore
//
//  Created by Li Linfeng on 8/10/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaFavorite : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly, nullable) NSString *url;
@property (nonatomic, readonly, nullable) NSArray<CelestiaFavorite *> *children;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
