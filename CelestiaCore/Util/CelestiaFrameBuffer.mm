// CelestiaFrameBuffer.mm
//
// Copyright (C) 2025, Celestia Development Team
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.


#import "CelestiaFrameBuffer.h"

#include <celengine/framebuffer.h>

@interface CelestiaFrameBuffer ()

@property (nonatomic) FramebufferObject *frameBuffer;
@property (nonatomic) GLint oldFboId;

@end

@implementation CelestiaFrameBuffer

- (instancetype)initWithSize:(CGSize)size attachments:(CelestiaFrameBufferAttachment)attachments {
    self = [super init];
    if (self) {
        _frameBuffer = new FramebufferObject(size.width, size.height, (unsigned int)attachments);
    }
    return self;
}

- (void)dealloc {
    delete _frameBuffer;
}

- (BOOL)bind {
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, &_oldFboId);
    return (BOOL)_frameBuffer->bind();
}

- (BOOL)unbind {
    return (BOOL)_frameBuffer->unbind(_oldFboId);
}

@end
