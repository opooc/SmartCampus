//
//  LPDQuoteImagesView.h
//  LPDQuoteImagesController
//
//  Created by Assuner on 2016/12/16.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPDPhotoArrangeCell.h"
#import "LPDPhotoArrangeCVlLayout.h"


#import "LPDImagePickerController.h"
#import "UIView+HandyValue.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LPDImageManager.h"
#import "LPDVideoPlayerController.h"
#import "LPDPhotoPreviewController.h"

@protocol LPDQuoteImagesViewDelegate <NSObject>
@optional

@end

@interface LPDQuoteImagesView : UIView

@property(strong, nonatomic) LPDImagePickerController *lpdImagePickerVc;


@property (assign, nonatomic) NSUInteger maxSelectedCount;       ///最大可选照片数
@property (assign, nonatomic) NSUInteger countPerRowInAlbum;     ///相册每行照片数

@property (assign, nonatomic) BOOL isShowTakePhotoSheet;         ///是否弹出拍照 图库Sheet

@property (strong, nonatomic) NSMutableArray *selectedPhotos;    ///选中的照片 UIImage数组 可copy
@property (strong, nonatomic) NSMutableArray *selectedAssets;    ///需要用到的模型数组

@property (strong, nonatomic) UICollectionView *collectionView;  ///选中图片排列集合view

@property (weak, nonatomic) UIViewController<LPDQuoteImagesViewDelegate>* navcDelegate;

- (instancetype)initWithFrame:(CGRect)frame withCountPerRowInView:(NSUInteger)ArrangeCount cellMargin:(CGFloat)cellMargin;

@end
