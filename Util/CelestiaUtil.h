//
//  AstroUitl.h
//  celestia
//
//  Created by Bob Ippolito on Fri Jun 07 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Astro)

@property (readonly) double julianDay;

+ (instancetype)dateWithJulian:(double)jd;

@end

@interface Astro : NSObject

+ (NSString *)stringWithCoordinateSystem:(int)n;
+ (int)coordinateSystem:(NSString *)coord;
+ (double)speedOfLight;
+ (double)J2000;
+ (double)G;
+ (double)solarMass;
+ (double)earthMass;
+ (float)lumToAbsMag:(float)lum;
+ (float)lumToAppMag:(float)lum lightYears:(float)lyrs;
+ (float)absMagToLum:(float)mag;
+ (float)absToAppMag:(float)mag lightYears:(float)lyrs;
+ (float)appToAbsMag:(float)mag lightYears:(float)lyrs;
+ (float)lightYearsToParsecs:(float)ly;
+ (float)parsecsToLightYears:(float)pc;
+ (double)lightYearsToKilometers:(double)ly;
+ (double)kilometersToLightYears:(double)km;
+ (double)lightYearsToAU:(double)ly;
+ (double)AUtoLightYears:(double)au;
+ (double)kilometersToAU:(double)km;
+ (double)AUtoKilometers:(double)au;
+ (double)microLightYearsToKilometers:(double)mly;
+ (double)kilometersToMicroLightYears:(double)km;
+ (double)microLightYearsToAU:(double)mly;
+ (double)AUtoMicroLightYears:(double)au;
+ (double)secondsToJulianDate:(double)sec;
+ (double)julianDateToSeconds:(double)jd;
+ (NSArray<NSNumber *> *)decimalToDegMinSec:(double)angle;
+ (double)degMinSecToDecimal:(NSArray*)dms;
+ (NSArray<NSNumber *> *)anomaly:(double)meanAnamaly eccentricity:(double)eccentricity;
+ (double)meanEclipticObliquity:(double)jd;

@end

NS_ASSUME_NONNULL_END
