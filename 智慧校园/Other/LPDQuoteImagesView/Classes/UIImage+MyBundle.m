//
//  UIImage+MyBundle.m
//  LPDQuoteSystemImagesController
//
//  Created by assuner on 2016/12/19.
//  Copyright © assuner 2016年 . All rights reserved.
//

#import "UIImage+MyBundle.h"
#import "LPDQuoteImagesView.h"

@implementation UIImage (MyBundle)

+ (UIImage *)imageNamedFromMyBundle:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[LPDQuoteImagesView class]];
    return [UIImage imageNamed:name inBundle:[NSBundle bundleWithPath:[NSString stringWithFormat:@"%@/LPDImagePickerController.bundle", bundle.bundlePath]] compatibleWithTraitCollection:nil];
    
}
@end
