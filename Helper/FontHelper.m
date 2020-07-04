//
// FontHelper.m
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "FontHelper.h"

@implementation FallbackFont

- (instancetype)initWithFilePath:(NSString *)filePath collectionIndex:(NSInteger)collectionIndex {
    self = [super init];
    if (self) {
        _filePath = filePath;
        _collectionIndex = collectionIndex;
    }
    return self;
}

@end

FallbackFont *GetFontForLocale(NSString *locale, CTFontUIFontType fontType)
{
    // Probe to find font
    NSString *c = @"a";
    if ([locale isEqualToString:@"zh_CN"] || [locale isEqualToString:@"zh_TW"] || [locale isEqualToString:@"ja"])
        c = @"一";
    else if ([locale isEqualToString:@"ko"])
        c = @"가";
    else if ([locale isEqualToString:@"ar"])
        c = @"ئ";

    NSString *fontPath = nil;
    NSInteger collectionIndex = 0;
    CTFontRef defaultFont = CTFontCreateUIFontForLanguage(fontType, 0, nil);
    if (defaultFont)
    {
        CTFontRef fb = CTFontCreateForStringWithLanguage(defaultFont, (CFStringRef)c, CFRangeMake(0, 1), NULL);
        if (fb)
        {
            CFURLRef url = (CFURLRef)CTFontCopyAttribute(fb, kCTFontURLAttribute); // Font path
            CFStringRef name = (CFStringRef)CTFontCopyAttribute(fb, kCTFontNameAttribute); // Font name
            if (url && name)
            {
                CFStringRef anotherName = NULL;
                if (CFStringHasPrefix(name, CFSTR(".PingFang"))) {
                    // Avoid use dot prefixed PingFang
                    anotherName = CFStringCreateWithSubstring(kCFAllocatorDefault, name, CFRangeMake(1, CFStringGetLength(name) - 1));
                }

                CFStringRef urlString = CFURLCreateStringByReplacingPercentEscapes(CFAllocatorGetDefault(), CFURLCopyPath(url), CFSTR(""));
                // Find index in the font file
                CFArrayRef fontDescs = CTFontManagerCreateFontDescriptorsFromURL(url);
                CFIndex count = CFArrayGetCount(fontDescs);
                for (CFIndex i = 0; i < count; i++)
                {
                    CTFontDescriptorRef des = (CTFontDescriptorRef)CFArrayGetValueAtIndex(fontDescs, i);
                    CFStringRef currentName = (CFStringRef)CTFontDescriptorCopyAttribute(des, kCTFontNameAttribute);
                    if (currentName) {
                        if (anotherName && CFStringCompare(anotherName, currentName, 0) == kCFCompareEqualTo) {
                            // another name is preferred, jump out of the loop immediately
                            CFRelease(currentName);
                            fontPath = (__bridge NSString *)urlString;
                            collectionIndex = i;
                            break;
                        } else if (CFStringCompare(name, currentName, 0) == kCFCompareEqualTo) {
                            // a font is found but might not be the preferred one
                            CFRelease(currentName);
                            fontPath = (__bridge NSString *)urlString;
                            collectionIndex = i;
                            if (!anotherName)
                                break; // Only one choice, jump out the loop immediately
                        } else {
                            CFRelease(currentName);
                        }
                    }
                }
                if ([fontPath hasSuffix:@"ttf"])
                    collectionIndex = collectionIndex << 16;  // This is a variation
                CFRelease(url);
                CFRelease(name);
                CFRelease(fontDescs);
                CFRelease(urlString);
                if (anotherName)
                    CFRelease(anotherName);
            }
            CFRelease(fb);
        }
        CFRelease(defaultFont);
    }
    if (fontPath != nil)
        return [[FallbackFont alloc] initWithFilePath:fontPath collectionIndex:collectionIndex];
    return nil;
}
