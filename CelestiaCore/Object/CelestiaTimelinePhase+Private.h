//
// CelestiaTimelinePhase+Private.h
//
// Copyright © 2023 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#include <celengine/timelinephase.h>
#import "CelestiaTimelinePhase.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaTimelinePhase (Private)

- (instancetype)initWithTimelinePhase:(const TimelinePhase::SharedConstPtr&)timelinePhase;

@end

NS_ASSUME_NONNULL_END
