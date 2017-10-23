//
//  tableHeadView.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/21.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "DSYPhotoHelper.h"

@interface ZZYPhotoDelegateHelper: NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, copy) DSYPhotoHelperBlock selectImageBlock;

@end

@interface DSYPhotoHelper ()
@property (nonatomic, strong) ZZYPhotoDelegateHelper *helper;

@end

static DSYPhotoHelper *picker = nil;
@implementation DSYPhotoHelper


+ (instancetype)shareHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picker = [[DSYPhotoHelper alloc] init];
    });
    return picker;
}

- (void)showImageViewSelcteWithResultBlock:(DSYPhotoHelperBlock)selectImageBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * library = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self creatWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary block:selectImageBlock];
    }];
    UIAlertAction * carmare = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self creatWithSourceType:UIImagePickerControllerSourceTypeCamera block:selectImageBlock];
        }else{
            //[MBProgressHUD showError:@"相机功能暂不能使用"];
        }
    }];
    [alertController addAction:canleAction];
    [alertController addAction:library];
    [alertController addAction:carmare];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
  


- (void)creatWithSourceType:(UIImagePickerControllerSourceType)sourceType block:selectImageBlock{
    picker.helper                  = [[ZZYPhotoDelegateHelper alloc] init];
    picker.delegate                = picker.helper;
    picker.sourceType              = sourceType;
    picker.allowsEditing = YES;//默认是可以修改的
    
    picker.helper.selectImageBlock = selectImageBlock;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

@end


@implementation ZZYPhotoDelegateHelper

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *theImage = nil;
    // 判断,图片是否允许修改。默认是可以的
    if ([picker allowsEditing]){
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    if (_selectImageBlock) {
        _selectImageBlock(theImage);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
