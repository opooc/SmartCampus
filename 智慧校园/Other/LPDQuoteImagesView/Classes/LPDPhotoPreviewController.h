//
//  LPDPhotoPreviewController.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPDPhotoPreviewController : UIViewController

@property (nonatomic, strong) NSMutableArray *models;                  ///< All photo models / 所有图片模型数组
@property (nonatomic, strong) NSMutableArray *photos;                  ///< All photos  / 所有图片数组
@property (nonatomic, assign) NSInteger currentIndex;           ///< Index of the photo user click / 用户点击的图片的索引
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;       ///< If YES,return original photo / 是否返回原图


/// Return the new selected photos / 返回最新的选中图片数组
@property (nonatomic, copy) void (^backButtonClickBlock)(BOOL isSelectOriginalPhoto);
@property (nonatomic, copy) void (^doneButtonClickBlock)(BOOL isSelectOriginalPhoto);

@property (nonatomic, copy) void (^doneButtonClickBlockWithPreviewType)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto);

@end
