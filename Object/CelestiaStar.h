//
//  CelestiaStar.h
//  celestia
//
//  Created by Bob Ippolito on Sat Jun 08 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import <CelestiaCore/CelestiaAstroObject.h>

NS_ASSUME_NONNULL_BEGIN

@class CelestiaUniversalCoord;

@interface CelestiaStar : CelestiaAstroObject

@property float luminosity;

@property (readonly) float radius;
@property (readonly) float temperature;

@property (readonly) NSString *webInfoURL;
@property (readonly) NSString *spectralType;
@property (readonly) float absoluteMagnitude;

- (void)setAbsoluteMagnitude:(float)m;
- (float)apparentMagnitude:(float)m;

- (CelestiaUniversalCoord *)positionAtTime:(NSDate *)time NS_SWIFT_NAME(position(at:));

@end

NS_ASSUME_NONNULL_END
