//
//  CelestiaUniversalCoord.h
//  celestia
//
//  Created by Bob Ippolito on Fri Jun 07 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CelestiaUniversalCoord.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaUniversalCoord : NSObject

-(double)distanceTo:(CelestiaUniversalCoord *)t;
-(CelestiaUniversalCoord *)difference:(CelestiaUniversalCoord *)t;

@end

NS_ASSUME_NONNULL_END
