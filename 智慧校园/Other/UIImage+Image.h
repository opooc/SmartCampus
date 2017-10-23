//
//  UIImage+Image.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (instancetype)imageOriginalWithName:(NSString *)imageName;

- (instancetype)xmg_circleImage;

+ (instancetype)xmg_circleImageNamed:(NSString *)name;
@end
