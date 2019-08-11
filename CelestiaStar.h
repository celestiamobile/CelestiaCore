//
//  CelestiaStar.h
//  celestia
//
//  Created by Bob Ippolito on Sat Jun 08 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import "CelestiaCatEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaStar : CelestiaCatEntry

@property unsigned int catalogNumber;
@property float luminosity;

@property (readonly) float radius;
@property (readonly) float temperature;

- (void)setAbsoluteMagnitude:(float)m;
- (float)apparentMagnitude:(float)m;

@end

NS_ASSUME_NONNULL_END
