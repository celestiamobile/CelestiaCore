//
// CelestiaFrameBuffer.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

typedef NS_OPTIONS(NSUInteger, CelestiaFrameBufferAttachment) {
    CelestiaFrameBufferAttachmentColor =    1 << 0,
    CelestiaFrameBufferAttachmentDepth =    1 << 1,
} NS_SWIFT_NAME(FrameBufferAttachment);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FrameBuffer)
@interface CelestiaFrameBuffer : NSObject

- (instancetype)initWithSize:(CGSize)size attachments:(CelestiaFrameBufferAttachment)attachments;
- (BOOL)bind;
- (BOOL)unbind;

@end

NS_ASSUME_NONNULL_END
