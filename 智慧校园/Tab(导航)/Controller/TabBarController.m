//
//  TabBarController.m
//  智慧校园
//
//  Created by doushuyao on 2017/9/7.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "TabBarController.h"
#import "MainController.h"
#import "WaitController.h"
#import "AchieveController.h"
#import "SettingController.h"
#import "MeController.h"
#import "UIImage+Image.h"
#import "MBProgressHUD.h"

@interface TabBarController ()

@end

@implementation TabBarController


// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    // 2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    
    self.navigationItem.hidesBackButton = YES;
    
    
}
-(void)setupAllChildViewController{

    MainController* main = [[MainController alloc]init];
   // UINavigationController* nav1 = [[UINavigationController alloc]initWithRootViewController:main];
    [self addChildViewController:main];
    
    WaitController* wait = [[WaitController alloc]init];
   // UINavigationController* nav2 = [[UINavigationController alloc]initWithRootViewController:wait];
    [self addChildViewController:wait];
    
    SettingController* setting = [[SettingController alloc]init];
   // UINavigationController* nav3 = [[UINavigationController alloc]initWithRootViewController:setting];
    [self addChildViewController:setting];
    
    AchieveController* achieve = [[AchieveController alloc]init];
   // UINavigationController* nav4 = [[UINavigationController alloc]initWithRootViewController:achieve];
    [self addChildViewController:achieve];
    
    MeController* me = [[MeController alloc]init];
  //  UINavigationController* nav5 = [[UINavigationController alloc]initWithRootViewController:me];
    [self addChildViewController:me];
    
}
- (void)setupAllTitleButton
{
    // 0:nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"首页";
    nav.tabBarItem.image = [UIImage imageNamed:@"main"];
    // 快速生成一个没有渲染图片
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"smain"];
    

    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"提交维修";
    nav1.tabBarItem.image = [UIImage imageNamed:@"wait"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"swait"];
    
    
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"二维码点名";
    nav2.tabBarItem.image = [UIImage imageNamed:@"saoyisao1"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"saoyisao2"];
    

    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"维修情况";
    nav3.tabBarItem.image = [UIImage imageNamed:@"service"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"sservice"];
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[4];
    nav4.tabBarItem.title = @"我的";
    nav4.tabBarItem.image = [UIImage imageNamed:@"mine"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"smine"];
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
