//
//  CelestiaAppCore+Locale.h
//  CelestiaCore
//
//  Created by 李林峰 on 2020/2/25.
//  Copyright © 2020 李林峰. All rights reserved.
//

#import <CelestiaCore/CelestiaAppCore.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef __cplusplus
extern "C" {
#endif
NSString *LocalizedFilename(NSString *originalName);
NSString *LocalizedString(NSString *originalString);
#ifdef __cplusplus
}
#endif

NS_ASSUME_NONNULL_END
