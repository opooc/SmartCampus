//
//  LPDImagePickerController.m
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import "LPDImagePickerController.h"
#import "LPDPhotoPickerController.h"
#import "LPDPhotoPreviewController.h"
#import "LPDAssetModel.h"
#import "LPDAssetCell.h"
#import "UIView+HandyValue.h"
#import "LPDImageManager.h"
#import "UIImage+MyBundle.h"
@interface LPDImagePickerController ()

{
    NSTimer *_timer;
    UILabel *_tipLable;
    UIButton *_settingBtn;
    BOOL _pushPhotoPickerVc;
    BOOL _didPushPhotoPickerVc;
    
    UIButton *_progressHUD;
    UIView *_HUDContainer;
    UIActivityIndicatorView *_HUDIndicatorView;
    UILabel *_HUDLable;
    
    UIStatusBarStyle _originStatusBarStyle;
}
/// 默认4列, LPDPhotoPickerController中的照片collectionView
@property (nonatomic, assign) NSInteger columnNumber;
@end

@implementation LPDImagePickerController

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    [LPDImageManager manager].shouldFixOrientation = NO;
    
    // Default appearance, you can reset these after this method
    // 默认的外观,你可以在这个方法后重置
    self.oKButtonTitleColorNormal   = [UIColor colorWithRed:(0/255.0) green:(138/255.0) blue:(241/255.0) alpha:1.0];
    self.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    
    if (iOS7Later) {
        self.navigationBar.barTintColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setBarItemTextFont:(UIFont *)barItemTextFont {
    _barItemTextFont = barItemTextFont;
    [self configBarButtonItemAppearance];
}

- (void)setBarItemTextColor:(UIColor *)barItemTextColor {
    _barItemTextColor = barItemTextColor;
    [self configBarButtonItemAppearance];
}

- (void)configBarButtonItemAppearance {
    UIBarButtonItem *barItem;
    if (iOS9Later) {
        barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[LPDImagePickerController class]]];
    } else {
        barItem = [UIBarButtonItem appearanceWhenContainedIn:[LPDImagePickerController class], nil];
    }
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = self.barItemTextColor;
    textAttrs[NSFontAttributeName] = self.barItemTextFont;
    [barItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _originStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    [UIApplication sharedApplication].statusBarStyle = iOS7Later ? UIStatusBarStyleLightContent : UIStatusBarStyleBlackOpaque;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = _originStatusBarStyle;
    [self hideProgressHUD];
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<LPDImagePickerControllerDelegate>)delegate {
    return [self initWithMaxImagesCount:maxImagesCount columnNumber:4 delegate:delegate pushPhotoPickerVc:YES];
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<LPDImagePickerControllerDelegate>)delegate {
    return [self initWithMaxImagesCount:maxImagesCount columnNumber:columnNumber delegate:delegate pushPhotoPickerVc:YES];
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<LPDImagePickerControllerDelegate>)delegate pushPhotoPickerVc:(BOOL)pushPhotoPickerVc {
    _pushPhotoPickerVc = pushPhotoPickerVc;
    LPDAlbumPickerController *albumPickerVc = [[LPDAlbumPickerController alloc] init];
    albumPickerVc.columnNumber = columnNumber;
    self = [super initWithRootViewController:albumPickerVc];
    if (self) {
        self.maxImagesCount = maxImagesCount > 0 ? maxImagesCount : 9; // Default is 9 / 默认最大可选9张图片
        self.pickerDelegate = delegate;
        self.selectedModels = [NSMutableArray array];
        
        // 默认准许用户选择原图和视频, 你也可以在这个方法后置为NO
        self.allowPickingOriginalPhoto = YES;
        self.allowPickingVideo = YES;
        self.allowPickingImage = YES;
        self.allowTakePicture = YES;
        self.sortAscendingByModificationDate = YES;
        self.autoDismiss = YES;
        self.columnNumber = columnNumber;
        [self configDefaultSetting];
        
        if (![[LPDImageManager manager] authorizationStatusAuthorized]) {
           /* _tipLable = [[UILabel alloc] init];
            _tipLable.frame = CGRectMake(8, 120, self.view.lpd_width - 16, 60);
            _tipLable.textAlignment = NSTextAlignmentCenter;
            _tipLable.numberOfLines = 0;
            _tipLable.font = [UIFont systemFontOfSize:16];
            _tipLable.textColor = [UIColor blackColor];
            NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
            if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
            NSString *tipText = [NSString stringWithFormat:[NSBundle lpd_localizedStringForKey:@"Allow %@ to access your album in \"Settings -> Privacy -> Photos\""],appName];
            _tipLable.text = tipText;
            [self.view addSubview:_tipLable];
            
            _settingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [_settingBtn setTitle:self.settingBtnTitleStr forState:UIControlStateNormal];
            _settingBtn.frame = CGRectMake(0, 180, self.view.lpd_width, 44);
            _settingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            [_settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_settingBtn];*///////友好提醒
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(observeAuthrizationStatusChange) userInfo:nil repeats:YES];
        } else {
            [self pushPhotoPickerVc];
        }
    }
    return self;
}

/// This init method just for previewing photos / 用这个初始化方法以预览图片
- (instancetype)initWithSelectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index{
    LPDPhotoPreviewController *previewVc = [[LPDPhotoPreviewController alloc] init];
    self = [super initWithRootViewController:previewVc];
    if (self) {
        self.selectedAssets = [NSMutableArray arrayWithArray:selectedAssets];
        self.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto;
        [self configDefaultSetting];
        
        previewVc.photos = [NSMutableArray arrayWithArray:selectedPhotos];
        previewVc.currentIndex = index;
        __weak typeof(self) weakSelf = self;
        [previewVc setDoneButtonClickBlockWithPreviewType:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                if (weakSelf.didFinishPickingPhotosHandle) {
                    weakSelf.didFinishPickingPhotosHandle(photos,assets,isSelectOriginalPhoto);
                }
            }];
        }];
    }
    return self;
}


- (void)configDefaultSetting {
    self.timeout = 15;
    self.photoWidth = 828.0;
    self.photoPreviewMaxWidth = 600;
    self.barItemTextFont = [UIFont systemFontOfSize:15];
    self.barItemTextColor = [UIColor whiteColor];
    self.allowPreview = YES;
    
    [self configDefaultImageName];
    [self configDefaultBtnTitle];
}

- (void)configDefaultImageName {
    self.takePictureImageName = @"takePicture.png";
    self.photoSelImageName = @"photo_sel_photoPickerVc.png";
    self.photoDefImageName = @"photo_def_photoPickerVc.png";
    self.photoNumberIconImageName = @"photo_number_icon.png";
    self.photoPreviewOriginDefImageName = @"preview_original_def.png";
    self.photoOriginDefImageName = @"photo_original_def.png";
    self.photoOriginSelImageName = @"photo_original_sel.png";
}

- (void)configDefaultBtnTitle {
    self.doneBtnTitleStr = [NSBundle lpd_localizedStringForKey:@"Done"];
    self.cancelBtnTitleStr = [NSBundle lpd_localizedStringForKey:@"Cancel"];
    self.previewBtnTitleStr = [NSBundle lpd_localizedStringForKey:@"Preview"];
    self.fullImageBtnTitleStr = [NSBundle lpd_localizedStringForKey:@"Full image"];
    self.settingBtnTitleStr = [NSBundle lpd_localizedStringForKey:@"Setting"];
    self.processHintStr = [NSBundle lpd_localizedStringForKey:@"Processing..."];
}

- (void)observeAuthrizationStatusChange {
    if ([[LPDImageManager manager] authorizationStatusAuthorized]) {
        [_tipLable removeFromSuperview];
        [_settingBtn removeFromSuperview];
        [_timer invalidate];
        _timer = nil;
        [self pushPhotoPickerVc];
    }
}

- (void)pushPhotoPickerVc {
    _didPushPhotoPickerVc = NO;
    // 1.6.8 判断是否需要push到照片选择页,如果_pushPhotoPickerVc为NO,则不push
    if (!_didPushPhotoPickerVc && _pushPhotoPickerVc) {
        LPDPhotoPickerController *photoPickerVc = [[LPDPhotoPickerController alloc] init];
        photoPickerVc.isFirstAppear = YES;
        photoPickerVc.columnNumber = self.columnNumber;
        [[LPDImageManager manager] getCameraRollAlbum:self.allowPickingVideo allowPickingImage:self.allowPickingImage completion:^(LPDAlbumModel *model) {
            photoPickerVc.model = model;
            [self pushViewController:photoPickerVc animated:YES];
            _didPushPhotoPickerVc = YES;
        }];
    }
}

- (void)showAlertWithTitle:(NSString *)title {
    if (iOS8Later) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:[NSBundle lpd_localizedStringForKey:@"OK"] style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:[NSBundle lpd_localizedStringForKey:@"OK"] otherButtonTitles:nil, nil] show];
    }
}

- (void)showProgressHUD {
    if (!_progressHUD) {
        _progressHUD = [UIButton buttonWithType:UIButtonTypeCustom];
        [_progressHUD setBackgroundColor:[UIColor clearColor]];
        
        _HUDContainer = [[UIView alloc] init];
        _HUDContainer.frame = CGRectMake((self.view.lpd_width - 120) / 2, (self.view.lpd_height - 90) / 2, 120, 90);
        _HUDContainer.layer.cornerRadius = 8;
        _HUDContainer.clipsToBounds = YES;
        _HUDContainer.backgroundColor = [UIColor darkGrayColor];
        _HUDContainer.alpha = 0.7;
        
        _HUDIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _HUDIndicatorView.frame = CGRectMake(45, 15, 30, 30);
        
        _HUDLable = [[UILabel alloc] init];
        _HUDLable.frame = CGRectMake(0,40, 120, 50);
        _HUDLable.textAlignment = NSTextAlignmentCenter;
        _HUDLable.text = self.processHintStr;
        _HUDLable.font = [UIFont systemFontOfSize:15];
        _HUDLable.textColor = [UIColor whiteColor];
        
        [_HUDContainer addSubview:_HUDLable];
        [_HUDContainer addSubview:_HUDIndicatorView];
        [_progressHUD addSubview:_HUDContainer];
    }
    [_HUDIndicatorView startAnimating];
    [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    
    // if over time, dismiss HUD automatic
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideProgressHUD];
    });
}

- (void)hideProgressHUD {
    if (_progressHUD) {
        [_HUDIndicatorView stopAnimating];
        [_progressHUD removeFromSuperview];
    }
}

- (void)setMaxImagesCount:(NSInteger)maxImagesCount {
    _maxImagesCount = maxImagesCount;
    if (maxImagesCount > 1) {
        _showSelectBtn = YES;
        
    }
}

- (void)setShowSelectBtn:(BOOL)showSelectBtn {
    _showSelectBtn = showSelectBtn;
    // 多选模式下,不允许让showSelectBtn为NO
    if (!showSelectBtn && _maxImagesCount > 1) {
        _showSelectBtn = YES;
    }
}



- (void)setTimeout:(NSInteger)timeout {
    _timeout = timeout;
    if (timeout < 5) {
        _timeout = 5;
    } else if (_timeout > 60) {
        _timeout = 60;
    }
}

- (void)setColumnNumber:(NSInteger)columnNumber {
    _columnNumber = columnNumber;
    if (columnNumber <= 2) {
        _columnNumber = 2;
    } else if (columnNumber >= 6) {
        _columnNumber = 6;
    }
    
    LPDAlbumPickerController *albumPickerVc = [self.childViewControllers firstObject];
    albumPickerVc.columnNumber = _columnNumber;
    [LPDImageManager manager].columnNumber = _columnNumber;
}

- (void)setMinPhotoWidthSelectable:(NSInteger)minPhotoWidthSelectable {
    _minPhotoWidthSelectable = minPhotoWidthSelectable;
    [LPDImageManager manager].minPhotoWidthSelectable = minPhotoWidthSelectable;
}

- (void)setMinPhotoHeightSelectable:(NSInteger)minPhotoHeightSelectable {
    _minPhotoHeightSelectable = minPhotoHeightSelectable;
    [LPDImageManager manager].minPhotoHeightSelectable = minPhotoHeightSelectable;
}

- (void)setHideWhenCanNotSelect:(BOOL)hideWhenCanNotSelect {
    _hideWhenCanNotSelect = hideWhenCanNotSelect;
    [LPDImageManager manager].hideWhenCanNotSelect = hideWhenCanNotSelect;
}

- (void)setPhotoPreviewMaxWidth:(CGFloat)photoPreviewMaxWidth {
    _photoPreviewMaxWidth = photoPreviewMaxWidth;
    if (photoPreviewMaxWidth > 800) {
        _photoPreviewMaxWidth = 800;
    } else if (photoPreviewMaxWidth < 500) {
        _photoPreviewMaxWidth = 500;
    }
    [LPDImageManager manager].photoPreviewMaxWidth = _photoPreviewMaxWidth;
}

- (void)setSelectedAssets:(NSMutableArray *)selectedAssets {
    _selectedAssets = selectedAssets;
    _selectedModels = [NSMutableArray array];
    for (id asset in selectedAssets) {
        LPDAssetModel *model = [LPDAssetModel modelWithAsset:asset type:LPDAssetModelMediaTypePhoto];
        model.isSelected = YES;
        [_selectedModels addObject:model];
    }
}

- (void)setAllowPickingImage:(BOOL)allowPickingImage {
    _allowPickingImage = allowPickingImage;
    NSString *allowPickingImageStr = _allowPickingImage ? @"1" : @"0";
    [[NSUserDefaults standardUserDefaults] setObject:allowPickingImageStr forKey:@"lpd_allowPickingImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setAllowPickingVideo:(BOOL)allowPickingVideo {
    _allowPickingVideo = allowPickingVideo;
    NSString *allowPickingVideoStr = _allowPickingVideo ? @"1" : @"0";
    [[NSUserDefaults standardUserDefaults] setObject:allowPickingVideoStr forKey:@"lpd_allowPickingVideo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setSortAscendingByModificationDate:(BOOL)sortAscendingByModificationDate {
    _sortAscendingByModificationDate = sortAscendingByModificationDate;
    [LPDImageManager manager].sortAscendingByModificationDate = sortAscendingByModificationDate;
}

- (void)settingBtnClick {
    if (iOS8Later) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else {
        NSURL *privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
        if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
            [[UIApplication sharedApplication] openURL:privacyUrl];
        } else {
            NSString *message = [NSBundle lpd_localizedStringForKey:@"Can not jump to the privacy settings page, please go to the settings page by self, thank you"];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[NSBundle lpd_localizedStringForKey:@"Sorry"] message:message delegate:nil cancelButtonTitle:[NSBundle lpd_localizedStringForKey:@"OK"] otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (iOS7Later) viewController.automaticallyAdjustsScrollViewInsets = NO;
    if (_timer) { [_timer invalidate]; _timer = nil;}
    [super pushViewController:viewController animated:animated];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Public

- (void)cancelButtonClick {
    if (self.autoDismiss) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self callDelegateMethod];
        }];
    } else {
        [self callDelegateMethod];
    }
}

- (void)callDelegateMethod {
    // 兼容旧版本
    if ([self.pickerDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [self.pickerDelegate imagePickerControllerDidCancel:self];
    }
    if ([self.pickerDelegate respondsToSelector:@selector(lpd_imagePickerControllerDidCancel:)]) {
        [self.pickerDelegate lpd_imagePickerControllerDidCancel:self];
    }
    if (self.imagePickerControllerDidCancelHandle) {
        self.imagePickerControllerDidCancelHandle();
    }
}

@end


@interface LPDAlbumPickerController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
}
@property (nonatomic, strong) NSMutableArray *albumArr;
@end

@implementation LPDAlbumPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = [NSBundle lpd_localizedStringForKey:@"Photos"];
    LPDImagePickerController *imagePickerVc = (LPDImagePickerController *)self.navigationController;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:imagePickerVc.cancelBtnTitleStr style:UIBarButtonItemStylePlain target:imagePickerVc action:@selector(cancelButtonClick)];
    [self configTableView];
    // 1.6.10 采用微信的方式,只在相册列表页定义backBarButtonItem为返回,其余的顺系统的做法
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSBundle lpd_localizedStringForKey:@"Back"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    LPDImagePickerController *imagePickerVc = (LPDImagePickerController *)self.navigationController;
    [imagePickerVc hideProgressHUD];
    if (_albumArr) {
        for (LPDAlbumModel *albumModel in _albumArr) {
            albumModel.selectedModels = imagePickerVc.selectedModels;
        }
        [_tableView reloadData];
    } else {
        [self configTableView];
    }
}

- (void)configTableView {
    LPDImagePickerController *imagePickerVc = (LPDImagePickerController *)self.navigationController;
    [[LPDImageManager manager] getAllAlbums:imagePickerVc.allowPickingVideo allowPickingImage:imagePickerVc.allowPickingImage completion:^(NSArray<LPDAlbumModel *> *models) {
        _albumArr = [NSMutableArray arrayWithArray:models];
        for (LPDAlbumModel *albumModel in _albumArr) {
            albumModel.selectedModels = imagePickerVc.selectedModels;
        }
        if (!_tableView) {
            CGFloat top = 44;
            if (iOS7Later) top += 20;
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, top, self.view.lpd_width, self.view.lpd_height - top) style:UITableViewStylePlain];
            _tableView.rowHeight = 70;
            _tableView.tableFooterView = [[UIView alloc] init];
            _tableView.dataSource = self;
            _tableView.delegate = self;
            [_tableView registerClass:[LPDAlbumCell class] forCellReuseIdentifier:@"LPDAlbumCell"];
            [self.view addSubview:_tableView];
        } else {
            [_tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albumArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LPDAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPDAlbumCell"];
    LPDImagePickerController *imagePickerVc = (LPDImagePickerController *)self.navigationController;
    cell.selectedCountButton.backgroundColor = imagePickerVc.oKButtonTitleColorNormal;
    cell.model = _albumArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LPDPhotoPickerController *photoPickerVc = [[LPDPhotoPickerController alloc] init];
    photoPickerVc.columnNumber = self.columnNumber;
    LPDAlbumModel *model = _albumArr[indexPath.row];
    photoPickerVc.model = model;
    __weak typeof(self) weakSelf = self;
    [photoPickerVc setBackButtonClickHandle:^(LPDAlbumModel *model) {
        [weakSelf.albumArr replaceObjectAtIndex:indexPath.row withObject:model];
    }];
    [self.navigationController pushViewController:photoPickerVc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma clang diagnostic pop

@end


