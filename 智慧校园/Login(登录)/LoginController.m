//
//  LoginController.m
//  智慧校园
//
//  Created by doushuyao on 17/5/23.
//  Copyright © 2017年 opooc. All rights reserved.
//
#import <BmobSDK/Bmob.h>
#import "LoginController.h"
#import "DJRegisterView.h"

#import "SearchController.h"
#import "RegisterController.h"

#import "TabBarController.h"
#import "Info.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    DJRegisterView* LoginVc = [[DJRegisterView alloc]
                               initwithFrame:
                               [UIScreen mainScreen].bounds
                               djRegisterViewType:DJRegisterViewTypeNav action:^(NSString *acc, NSString *key) {
                                   NSLog(@"点击了登录");
                                   NSLog(@"\n输入的账户%@\n密码%@",acc,key);
                                 
                                   
                                   [BmobUser loginInbackgroundWithAccount:acc andPassword:key block:^(BmobUser *user, NSError *error) {
                                       if (user) {
                                           NSLog(@"%@",user);
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                           [alert show];
                                             [[Info sharedInstance]save:acc];
                                           TabBarController* tab =  [[TabBarController alloc]init];
                                           [self.navigationController pushViewController:tab animated:YES];


                                       } else {
                                           NSLog(@"%@",error);
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                           [alert show];

                                       }
                                   }];
                                  
                                   
                               } zcAction:^{
                                   RegisterController* regist =[[RegisterController alloc]init];
                                   [self.navigationController pushViewController:regist animated:YES];
                                   
                                   
                               } wjAction:^{
                                   SearchController* search = [[SearchController alloc]init];
                                   [self.navigationController pushViewController:search animated:YES];
                                   
                               }];
   
    [self.view addSubview:LoginVc];
    self.navigationItem.hidesBackButton = YES;
    

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
