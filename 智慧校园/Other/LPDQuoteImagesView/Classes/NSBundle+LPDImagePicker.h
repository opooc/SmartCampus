//
//  NSBundle+LPDImagePicker.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (LPDImagePicker)
+ (NSString *)lpd_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)lpd_localizedStringForKey:(NSString *)key;
@end
