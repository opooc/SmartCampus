//
//  LPDPhotoPreviewCell.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPDAssetModel,LPDProgressView;
@interface LPDPhotoPreviewCell : UICollectionViewCell
@property (nonatomic, strong) LPDAssetModel *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)();
@property (nonatomic, copy) void (^imageProgressUpdateBlock)(double progress);

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) LPDProgressView *progressView;




- (void)recoverSubviews;

@end
