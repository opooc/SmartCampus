//
//  RegisterController.m
//  智慧校园
//
//  Created by doushuyao on 17/5/25.
//  Copyright © 2017年 opooc. All rights reserved.
//
#import <BmobSDK/Bmob.h>
#import "RegisterController.h"
#import "DJRegisterView.h"
#import "SetpwdController.h"
#import "LoginController.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DJRegisterView *RegisterView = [[DJRegisterView alloc]
                                initwithFrame:self.view.bounds djRegisterViewTypeSMS:DJRegisterViewTypeScanfPhoneSMS plTitle:@"请输入获取到的验证码"
                                title:@"下一步"
                                    phoneholder:@"请输入要注册的手机号"
                                hq:^BOOL(NSString *phoneStr) {
                                    if ([self isMobileNumber:phoneStr]) {
                                        [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneStr andTemplate:@"opooc" resultBlock:^(int msgId, NSError *error) {
                                            if (error) {
                                                NSLog(@"%@",error);
                                            } else {
                                                //获得smsID
                                               
                                                NSLog(@"sms ID:%d",msgId);
                                            }
                                        }];
                                           return YES;
                                    }
                                    else{
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"伙计,手机号不正确或填写错误" delegate:self cancelButtonTitle:@"更改" otherButtonTitles:nil];
                                        [alert show];
                                        return NO;

                                    }
                                 
                                }
                                
                                tjAction:^(NSString *phoneStr,NSString *yzmStr) {
                                    
                                    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber: phoneStr andSMSCode:yzmStr resultBlock:^(BOOL isSuccessful, NSError *error) {
                                        
                                        if (isSuccessful) {
                                            NSLog(@"%@",@"验证成功,可执行用户请求的操作");
                                        SetpwdController* setpwd = [[SetpwdController alloc]init];
                                            setpwd.PhoneNum = phoneStr;

                                           [self.navigationController pushViewController:setpwd animated:YES];
                                            
                                        }
                                        
                                        else {
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"伙计,验证码错误或未填写" delegate:self cancelButtonTitle:@"重写" otherButtonTitles:nil];
                                            [alert show];
                                            
                                            
                                        }
                                        
                                    }];
                                   
                                    NSLog(@"6666--------");
                                    
                                }];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"<登录" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem =leftBarItem;
    [self.view addSubview:RegisterView];
    

}

-(void)back{
    LoginController* login = [[LoginController alloc]init];
    
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型为立方体动画
    animation.type = @"cube";
    //设置动画时长
    animation.duration =0.5f;
    //设置运动的方向
    animation.subtype =kCATransitionFromRight;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:login animated:NO];


}

- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
