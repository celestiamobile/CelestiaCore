//
//  FontHelper.h
//  CelestiaCore
//
//  Created by 李林峰 on 2020/6/8.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface FallbackFont : NSObject

@property (readonly) NSString *filePath;
@property (readonly) NSInteger collectionIndex;

@end

FallbackFont * _Nullable GetFontForLocale(NSString *locale, CTFontUIFontType fontType);

NS_ASSUME_NONNULL_END
