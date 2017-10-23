//
//  SetpwdController.m
//  智慧校园
//
//  Created by doushuyao on 17/5/25.
//  Copyright © 2017年 opooc. All rights reserved.
//
#import <BmobSDK/Bmob.h>
#import "SetpwdController.h"
#import "DJRegisterView.h"
#import "LoginController.h"
#import "RegisterController.h"
@interface SetpwdController ()

@end

@implementation SetpwdController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    DJRegisterView *djSetPassView = [[DJRegisterView alloc]
                                     initwithFrame:self.view.bounds action:^(NSString *key1, NSString *key2,NSString* phoneStr) {
                                         NSLog(@"%@----%@---%@",key1,key2,phoneStr);
                                         if (key1 != key2) {
                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码输入不一致" delegate:self cancelButtonTitle:@"重新输入" otherButtonTitles:nil];
                                             [alert show];
                                         }
                                         else{
                                             BmobUser *registerUser = [[BmobUser alloc] init];
                                             [registerUser setUsername:_PhoneNum];
                                             [registerUser setPassword:key1];
                                             [registerUser setMobilePhoneNumber:_PhoneNum];
                                             
                                             NSLog(@"%@--%@--%@",phoneStr,key1,key2);
                                             
                                             [registerUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
                                                 if (isSuccessful){
                                                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                                     [alert show];
                                                     NSLog(@"Sign up successfully");
                                                 } else {
                                                     NSLog(@"%@",error);
                                                 }
                                             }];
                                         
                                         }
                                         
                                     }];
 UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"<登录" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem =leftBarItem;
    [self.view addSubview:djSetPassView];
    
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
