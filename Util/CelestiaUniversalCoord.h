//
//  CelestiaUniversalCoord.h
//  celestia
//
//  Created by Bob Ippolito on Fri Jun 07 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaVector;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaUniversalCoord : NSObject

- (double)distanceFrom:(CelestiaUniversalCoord *)t;
- (CelestiaUniversalCoord *)difference:(CelestiaUniversalCoord *)t;
- (CelestiaVector *)offetFrom:(CelestiaUniversalCoord *)t;

@end

NS_ASSUME_NONNULL_END
