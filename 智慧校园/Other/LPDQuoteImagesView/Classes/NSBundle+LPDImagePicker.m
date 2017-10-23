//
//  NSBundle+LPDImagePicker.m
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import "NSBundle+LPDImagePicker.h"
#import "LPDImagePickerController.h"

@implementation NSBundle (LPDImagePicker)
+ (instancetype)lpd_imagePickerBundle {
    static NSBundle *lpd_Bundle = nil;
    if (lpd_Bundle == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:[LPDImagePickerController class]];
        lpd_Bundle = [NSBundle bundleWithPath:[NSString stringWithFormat:@"%@/LPDImagePickerController.bundle", bundle.bundlePath]];
    }
   
    return lpd_Bundle;
}

+ (NSString *)lpd_localizedStringForKey:(NSString *)key {
    return [self lpd_localizedStringForKey:key value:@""];
}

+ (NSString *)lpd_localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else {
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle lpd_imagePickerBundle] pathForResource:language ofType:@"lproj"]];
    }
    NSString *value1 = [bundle localizedStringForKey:key value:value table:nil];
    return value1;
}
@end
