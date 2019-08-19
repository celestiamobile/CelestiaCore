//
//  CelestiaMath.h
//  celestia
//
//  Created by Bob Ippolito on Sat Jun 08 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaVector : NSArray

@property (readonly) NSNumber *x;
@property (readonly) NSNumber *y;
@property (readonly) NSNumber *z;
@property (readonly) NSNumber *w;

@property (readonly) double dx;
@property (readonly) double dy;
@property (readonly) double dz;
@property (readonly) double dw;

-(void)encodeWithCoder:(NSCoder*)coder;
-(id)initWithCoder:(NSCoder*)coder;
+(CelestiaVector*)vectorWithArray:(NSArray*)v;
+(CelestiaVector*)vectorWithx:(NSNumber*)v y:(NSNumber*)y;
+(CelestiaVector*)vectorWithx:(NSNumber*)v y:(NSNumber*)y z:(NSNumber*)z;
+(CelestiaVector*)vectorWithx:(NSNumber*)v y:(NSNumber*)y z:(NSNumber*)z w:(NSNumber*)w;
-(CelestiaVector*)initWithArray:(NSArray*)v;
-(CelestiaVector*)initWithx:(NSNumber*)v y:(NSNumber*)y;
-(CelestiaVector*)initWithx:(NSNumber*)v y:(NSNumber*)y z:(NSNumber*)z;
-(CelestiaVector*)initWithx:(NSNumber*)v y:(NSNumber*)y z:(NSNumber*)z w:(NSNumber*)w;
-(NSUInteger)count;
-(NSNumber*)objectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
