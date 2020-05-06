//
//  CelestiaAppCore+Locale.m
//  CelestiaCore
//
//  Created by 李林峰 on 2020/2/25.
//  Copyright © 2020 李林峰. All rights reserved.
//

#import "CelestiaAppCore+Locale.h"

#include <celutil/util.h>
#include <celutil/gettext.h>

NSString *LocalizedFilename(NSString *originalName)
{
    return [NSString stringWithUTF8String:LocaleFilename([originalName UTF8String]).string().c_str()];
}

NSString *LocalizedString(NSString *originalString, NSString *domain)
{
    return [NSString stringWithUTF8String:dgettext([domain UTF8String], [originalString UTF8String])];
}
