//  LPDAssetCell.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSUInteger, LPDAssetCellType){
    LPDAssetCellTypePhoto = 0,
    LPDAssetCellTypeLivePhoto,
    LPDAssetCellTypeVideo,
    LPDAssetCellTypeAudio,
};
@class LPDAssetModel;
@interface LPDAssetCell : UICollectionViewCell

@property (weak, nonatomic) UIButton *selectPhotoButton;
@property (nonatomic, strong) LPDAssetModel *model;
@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, assign) LPDAssetCellType type;
@property (nonatomic, copy) NSString *representedAssetIdentifier;
@property (nonatomic, assign) PHImageRequestID imageRequestID;

@property (nonatomic, copy) NSString *photoSelImageName;
@property (nonatomic, copy) NSString *photoDefImageName;

@property (nonatomic, assign) BOOL showSelectBtn;

@end


@class LPDAlbumModel;

@interface LPDAlbumCell : UITableViewCell

@property (nonatomic, strong) LPDAlbumModel *model;
@property (weak, nonatomic) UIButton *selectedCountButton;

@end


@interface LPDAssetCameraCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end

