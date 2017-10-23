//
//  LPDImagePickerController.h
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPDAssetModel.h"
#import "NSBundle+LPDImagePicker.h"

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

@protocol LPDImagePickerControllerDelegate;
@interface LPDImagePickerController : UINavigationController
// 用这个初始化方法
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<LPDImagePickerControllerDelegate>)delegate;
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<LPDImagePickerControllerDelegate>)delegate;
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<LPDImagePickerControllerDelegate>)delegate pushPhotoPickerVc:(BOOL)pushPhotoPickerVc;
/// 用这个初始化方法以预览图片
- (instancetype)initWithSelectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index;
///用这个初始化方法以裁剪图片


/// Default is 9 / 默认最大可选9张图片
@property (nonatomic, assign) NSInteger maxImagesCount;

/// 最小照片必选张数,默认是0
@property (nonatomic, assign) NSInteger minImagesCount;

/// 让完成按钮一直可以点击,无须最少选择一张图片
@property (nonatomic, assign) BOOL alwaysEnableDoneBtn;

/// 对照片排序,按修改时间升序,默认是YES。如果设置为NO,最新的照片会显示在最前面,内部的拍照按钮会排在第一个
@property (nonatomic, assign) BOOL sortAscendingByModificationDate;

/// Default is 828px / 默认828像素宽
@property (nonatomic, assign) CGFloat photoWidth;

/// Default is 600px / 默认600像素宽
@property (nonatomic, assign) CGFloat photoPreviewMaxWidth;

/// 超时时间,默认为15秒,当取图片时间超过15秒还没有取成功时,会自动dismiss HUD；
@property (nonatomic, assign) NSInteger timeout;

/// 默认为YES,如果设置为NO,原图按钮将隐藏,用户不能选择发送原图
@property (nonatomic, assign) BOOL allowPickingOriginalPhoto;

/// 默认为YES,如果设置为NO,用户将不能选择发送视频
@property (nonatomic, assign) BOOL allowPickingVideo;

/// 默认为YES,如果设置为NO,用户将不能选择发送图片
@property(nonatomic, assign) BOOL allowPickingImage;


/// 默认为YES,如果设置为NO,拍照按钮将隐藏,用户将不能在选择器中拍照
@property(nonatomic, assign) BOOL allowTakePicture;


/// 默认为YES,如果设置为NO,预览按钮将隐藏,用户将不能去预览照片
@property (nonatomic, assign) BOOL allowPreview;

/// 默认为YES,如果设置为NO, 选择器将不会自己dismiss
@property(nonatomic, assign) BOOL autoDismiss;


/// 用户选中过的图片数组
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, strong) NSMutableArray<LPDAssetModel *> *selectedModels;


/// 最小可选中的图片宽度,默认是0,小于这个宽度的图片不可选中
@property (nonatomic, assign) NSInteger minPhotoWidthSelectable;
@property (nonatomic, assign) NSInteger minPhotoHeightSelectable;

/// 隐藏不可以选中的图片,默认是NO,不推荐将其设置为YES
@property (nonatomic, assign) BOOL hideWhenCanNotSelect;


/// 单选模式,maxImagesCount为1时才生效
@property (nonatomic, assign) BOOL showSelectBtn;   ///< 在单选模式下,照片列表页中,显示选择按钮,默认为NO

- (void)showAlertWithTitle:(NSString *)title;
- (void)showProgressHUD;
- (void)hideProgressHUD;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;

@property (nonatomic, copy) NSString *takePictureImageName;
@property (nonatomic, copy) NSString *photoSelImageName;
@property (nonatomic, copy) NSString *photoDefImageName;
@property (nonatomic, copy) NSString *photoOriginSelImageName;
@property (nonatomic, copy) NSString *photoOriginDefImageName;
@property (nonatomic, copy) NSString *photoPreviewOriginDefImageName;
@property (nonatomic, copy) NSString *photoNumberIconImageName;

/// Appearance / 外观颜色 + 按钮文字
@property (nonatomic, strong) UIColor *oKButtonTitleColorNormal;
@property (nonatomic, strong) UIColor *oKButtonTitleColorDisabled;
@property (nonatomic, strong) UIColor *barItemTextColor;
@property (nonatomic, strong) UIFont *barItemTextFont;

@property (nonatomic, copy) NSString *doneBtnTitleStr;
@property (nonatomic, copy) NSString *cancelBtnTitleStr;
@property (nonatomic, copy) NSString *previewBtnTitleStr;
@property (nonatomic, copy) NSString *fullImageBtnTitleStr;
@property (nonatomic, copy) NSString *settingBtnTitleStr;
@property (nonatomic, copy) NSString *processHintStr;

/// Public Method
- (void)cancelButtonClick;

// 这个照片选择器会自己dismiss,当选择器dismiss的时候,会执行下面的handle
// 你也可以设置autoDismiss属性为NO,选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES,表明用户选择了原图
// 你可以通过一个asset获得原图,通过这个方法:[[LPDImageManager manager]
// photos数组里的UIImage对象,默认是828像素宽,你可以通过设置photoWidth属性的值来改变它
@property (nonatomic, copy) void (^didFinishPickingPhotosHandle)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto);
@property (nonatomic, copy) void (^didFinishPickingPhotosWithInfosHandle)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,NSArray<NSDictionary *> *infos);
@property (nonatomic, copy) void (^imagePickerControllerDidCancelHandle)();
// 如果用户选择了一个视频,下面的handle会被执行
// 如果系统版本大于iOS8,asset是PHAsset类的对象,否则是ALAsset类的对象
@property (nonatomic, copy) void (^didFinishPickingVideoHandle)(UIImage *coverImage,id asset);

@property (nonatomic, weak) id<LPDImagePickerControllerDelegate> pickerDelegate;

@end


@protocol LPDImagePickerControllerDelegate <NSObject>
@optional

// 这个照片选择器会自己dismiss,当选择器dismiss的时候,会执行下面的handle
// 你也可以设置autoDismiss属性为NO,选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES,表明用户选择了原图
// 你可以通过一个asset获得原图,通过这个方法:[[LPDImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象,默认是828像素宽,你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(LPDImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto;
- (void)imagePickerController:(LPDImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos;
- (void)imagePickerControllerDidCancel:(LPDImagePickerController *)picker __attribute__((deprecated("Use -lpd_imagePickerControllerDidCancel:.")));
- (void)lpd_imagePickerControllerDidCancel:(LPDImagePickerController *)picker;

// 如果用户选择了一个视频,下面的handle会被执行
// 如果系统版本大于iOS8,asset是PHAsset类的对象,否则是ALAsset类的对象
- (void)imagePickerController:(LPDImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset;
@end


@interface LPDAlbumPickerController : UIViewController
@property (nonatomic, assign) NSInteger columnNumber;
@end


