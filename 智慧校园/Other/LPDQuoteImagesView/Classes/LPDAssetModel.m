//
//  LPDAssetModel.m
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import "LPDAssetModel.h"
#import "LPDImageManager.h"

@implementation LPDAssetModel

+ (instancetype)modelWithAsset:(id)asset type:(LPDAssetModelMediaType)type{
    LPDAssetModel *model = [[LPDAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(LPDAssetModelMediaType)type timeLength:(NSString *)timeLength {
    LPDAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

@end

@implementation LPDAlbumModel

- (void)setResult:(id)result {
    _result = result;
    BOOL allowPickingImage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lpd_allowPickingImage"] isEqualToString:@"1"];
    BOOL allowPickingVideo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lpd_allowPickingVideo"] isEqualToString:@"1"];
    [[LPDImageManager manager] getAssetsFromFetchResult:result allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage completion:^(NSArray<LPDAssetModel *> *models) {
        _models = models;
        if (_selectedModels) {
            [self checkSelectedModels];
        }
    }];
}

- (void)setSelectedModels:(NSArray *)selectedModels {
    _selectedModels = selectedModels;
    if (_models) {
        [self checkSelectedModels];
    }
}

- (void)checkSelectedModels {
    self.selectedCount = 0;
    NSMutableArray *selectedAssets = [NSMutableArray array];
    for (LPDAssetModel *model in _selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (LPDAssetModel *model in _models) {
        if ([[LPDImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            self.selectedCount ++;
        }
    }
}


@end
