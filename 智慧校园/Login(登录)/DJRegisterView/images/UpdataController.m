//
//  UpdataController.m
//  智慧校园
//
//  Created by doushuyao on 17/5/26.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "UpdataController.h"
#import <BmobSDK/Bmob.h>
#import "DJRegisterView.h"
#import "LoginController.h"

@interface UpdataController ()
@property(nonatomic,strong)BmobUser *user;
@end

@implementation UpdataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DJRegisterView* updata = [[DJRegisterView alloc]initwithFrame:[UIScreen mainScreen].bounds action:^(NSString *key1, NSString *key2, NSString *yzm) {
        if (key1 == key2) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码输入不一致" delegate:self cancelButtonTitle:@"重新输入" otherButtonTitles:nil];
            [alert show];
        }
        else{
            BmobQuery *query = [BmobUser query];
            [query whereKey:@"username" equalTo:yzm];
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if (array) {
                    [BmobUser resetPasswordInbackgroundWithSMSCode:key1 andNewPassword:yzm block:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            NSLog(@"%@",@"重置密码成功");
                        } else {
                            NSLog(@"%@",error);
                           
                        }
                    }];
                }
                else{
        
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无此用户" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    
              }
      
            }];}}];
        
    [self.view addSubview:updata];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"<登录" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem =leftBarItem;
    
    // Do any additional setup after loading the view.
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
    [self.navigationController pushViewController:login animated:NO];}






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
