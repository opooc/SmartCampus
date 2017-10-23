//
//  LPDAssetModel.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LPDAssetModelMediaType){
    LPDAssetModelMediaTypePhoto = 0,
    LPDAssetModelMediaTypeLivePhoto,
    LPDAssetModelMediaTypeVideo,
    LPDAssetModelMediaTypeAudio,
};

@class PHAsset;
@interface LPDAssetModel : NSObject

@property (nonatomic, strong) id asset;             // PHAsset or ALAsset
@property (nonatomic, assign) BOOL isSelected;      // 选中状态
@property (nonatomic, assign) LPDAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;

+ (instancetype)modelWithAsset:(id)asset type:(LPDAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(LPDAssetModelMediaType)type timeLength:(NSString *)timeLength;

@end

@class PHFetchResult;
@interface LPDAlbumModel : NSObject

@property (nonatomic, strong) NSString *name;        //名字
@property (nonatomic, assign) NSInteger count;       //相片总量
@property (nonatomic, strong) id result;             ///< PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSArray *selectedModels;
@property (nonatomic, assign) NSUInteger selectedCount;

@end
