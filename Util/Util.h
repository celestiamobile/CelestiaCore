//
//  Util.h
//  celestia
//
//  Created by Da Woon Jung on 05/07/24.
//  Copyright 2005 Chris Laurel. All rights reserved.
//

#ifndef _UTIL_H_
#define _UTIL_H_

#include <libintl.h>
#ifndef gettext
#include "POSupport.h"
#define gettext(s)      localizedUTF8String(s)
#define dgettext(d,s)   localizedUTF8StringWithDomain(d,s)
#endif

#endif
