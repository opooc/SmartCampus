//
//  LPDPhotoArrangeCell.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/16.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+HandyValue.h"
#import "UIImage+MyBundle.h"

@class LPDImagePickerController;
@class LPDQuoteSystemImagesView;

@interface LPDPhotoArrangeCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageThumbnail; //图片缩略图
@property (strong, nonatomic) UIImageView *videoThumbnail; //视频缩略图
@property (strong, nonatomic) UIButton *nookDeleteBtn;     //角标删除按钮
@property (assign, nonatomic) NSInteger row;               //行
@property (strong, nonatomic) id asset;                    //资源模型


- (UIView *)snapshotView;

@end
