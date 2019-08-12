//
//  CelestiaDSOCatalog.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaDSO;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaDSOCatalog : NSObject

@property (readonly) NSInteger count;

- (CelestiaDSO *)objectAtIndex:(NSInteger)index;

- (NSString *)dsoName:(CelestiaDSO *)dso;

@end

NS_ASSUME_NONNULL_END
