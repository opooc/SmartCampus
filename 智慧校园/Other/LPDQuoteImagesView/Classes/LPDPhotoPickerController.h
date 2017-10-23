//
//  LPDPhotoPickerController.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPDAlbumModel;
@interface LPDPhotoPickerController : UIViewController

@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, strong) LPDAlbumModel *model;

@property (nonatomic, copy) void (^backButtonClickHandle)(LPDAlbumModel *model);

@end

@interface LYGCollectionView : UICollectionView

@end
