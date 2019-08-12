//
//  CelestiaScript.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/12.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaScript : NSObject

@property (readonly) NSString *filename;
@property (readonly) NSString *title;

+ (NSArray<CelestiaScript *> *)scriptsInDirectory:(NSString *)directory deepScan:(BOOL)deep;

@end

NS_ASSUME_NONNULL_END
