//
//  tableHeadView.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/12.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "meTableHeadView.h"
#import "headBtn.h"
#import "DSYPhotoHelper.h"
#import "LoginController.h"
#import "Info.h"
#import <UShareUI/UShareUI.h>

@implementation meTableHeadView


-(instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}


-(void)initUI{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4*3-64);
    
    _bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_WIDTH/4*3)];
    _bg.image = [UIImage imageNamed:@"backImage"];
    _bg.contentMode = UIViewContentModeScaleAspectFill;
    _bg.layer.masksToBounds = true;
    [self addSubview:_bg];
    
    
    CGFloat Y = 35/736.0*SCREEN_HEIGHT;
    CGFloat offset = 15/736.0*SCREEN_HEIGHT;
    
    _portrait = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, Y, 90, 90)];
    _portrait.image  = [UIImage imageNamed:@"Portrait"];
    _portrait.layer.cornerRadius = 45;
    _portrait.layer.masksToBounds = true;
    _portrait.layer.borderColor = [[UIColor whiteColor] CGColor];
    _portrait.layer.borderWidth = 2;
    _portrait.userInteractionEnabled = YES;
    UITapGestureRecognizer* gas = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gas)];
    [_portrait addGestureRecognizer:gas];
    [self addSubview:_portrait];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_portrait.frame)+offset, SCREEN_WIDTH, 20)];
    _name.textAlignment = NSTextAlignmentCenter;
    _name.textColor = [UIColor whiteColor];
    _name.font = [UIFont systemFontOfSize:17];
    _name.text = @"Opooc";
    [self addSubview:_name];
    
    _remindBtn = [[headBtn alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-110-10, CGRectGetMaxY(_name.frame)+offset, 110, 30)];
    [_remindBtn setImage:[UIImage imageNamed:@"Clock"] forState:0];
    [_remindBtn setTitle:@"退出" forState:0];
    [_remindBtn addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_remindBtn];
    
    
    _share = [[headBtn alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, CGRectGetMinY(_remindBtn.frame), 110, 30)];
    [_share setImage:[UIImage imageNamed:@"Share"] forState:0];
    [_share setTitle:@"分享" forState:0];
    [_share addTarget:self action:@selector(UshareUI) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_share];
    

}
-(void)tuichu{
    LoginController* login = [[LoginController alloc]init];
    [[self View:self].navigationController pushViewController:login animated:YES];
    [[Info sharedInstance]save:@""];


}
- (UIViewController *)View:(UIView *)view{
    UIResponder *responder = view;
    //循环获取下一个响应者,直到响应者是一个UIViewController类的一个对象为止,然后返回该对象.
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

-(void)gas{
    [[DSYPhotoHelper shareHelper]showImageViewSelcteWithResultBlock:^(id data) {
        _portrait.image = (UIImage*) data;
    }];

}
-(void)UshareUI{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sms)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        if(platformType == UMSocialPlatformType_Sina){
            
            [self shareTextToPlatformType:platformType];
        }
        else{
            
            [self shareWebPageToPlatformType:platformType];}
        
    }];
    
}
//友盟分享
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"智慧校园";
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"智慧校园" descr:@"智慧校园App是由曲园团队开发,为曲师大学生开发的产品,志于帮助同学们更加便捷的体验校园生活。。" thumImage:[UIImage imageNamed:@"icon-72"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://qfnu.opooc.com";
    //分享消息对象设置分享内容对象
    
    
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
@end
