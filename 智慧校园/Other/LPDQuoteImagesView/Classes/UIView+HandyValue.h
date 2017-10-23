//
//  UIView+HandyValue.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LPDOscillatoryAnimationType){
    LPDOscillatoryAnimationToBigger,
    LPDOscillatoryAnimationToSmaller,
};

#define RELATIVE_VALUE(x) (x*[[UIScreen mainScreen] bounds].size.width/375)
@interface UIView (HandyValue)

@property (nonatomic) CGFloat lpd_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat lpd_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat lpd_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat lpd_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat lpd_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat lpd_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat lpd_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat lpd_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint lpd_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  lpd_size;        ///< Shortcut for frame.size.

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(LPDOscillatoryAnimationType)type;


@end
