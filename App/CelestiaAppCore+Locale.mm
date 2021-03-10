//
// CelestiaAppCore+Locale.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaAppCore+Locale.h"

#include <celutil/fsutils.h>
#include <celutil/gettext.h>

NSString *LocalizedFilename(NSString *originalName)
{
    using namespace celestia::util;
    return [NSString stringWithUTF8String:LocaleFilename([originalName UTF8String]).string().c_str()];
}

NSString *LocalizedString(NSString *originalString, NSString *domain)
{
    return [NSString stringWithUTF8String:dgettext([domain UTF8String], [originalString UTF8String])];
}
