//
//  DJRegisterView.h
//  DJRegisterView
//
//  Created by asios on 15/8/14.
//  Copyright (c) 2015年 LiangDaHong. All rights reserved.
//
//
//  第一次写 '库' 多多包涵
//  邮箱: asiosldh@163.com
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    DJRegisterViewTypeNoNav,   // 登录界面(没导航条)
    DJRegisterViewTypeNav,     // 登录界面(有导航条)
} DJRegisterViewType;

typedef enum : NSUInteger {
    DJRegisterViewTypeScanfPhoneSMS, // 输入手机号 获取验证码
    DJRegisterViewTypeNoScanfSMS,    // 找回密码 ()
} DJRegisterViewTypeSMS;



@interface DJRegisterView : UIView

// 登录界面
- (instancetype )initwithFrame:(CGRect)frame
            djRegisterViewType:(DJRegisterViewType)djRegisterViewType      //类型
                        action:(void (^)(NSString *acc,NSString *key))action  // 点击登录的回调block
                      zcAction:(void (^)(void))zcAction   // 点击注册的回调block
                      wjAction:(void (^)(void))wjAction;  // 点击忘记的回调block


// 1.找回密码 (界面)  2.输入手机号获取验证码界面
- (instancetype )initwithFrame:(CGRect)frame
         djRegisterViewTypeSMS:(DJRegisterViewTypeSMS)djRegisterViewTypeSMS //类型
                       plTitle:(NSString *)plTitle  // 填写验证码 的提示文字
                         title:(NSString *)title    // 填写验证码 的提示文字
                        phoneholder:(NSString *)phoneholder
                            hq:(BOOL (^)(NSString *phoneStr))hqAction // 获取验证码的 回调block(返回是否获取成功,phoneStr:输入的手机号)
                      tjAction:(void (^)(NSString *phoneStr,NSString *yzmStr))tjAction; // 点击提交的回调block

// (设置密码界面)
- (instancetype )initwithFrame:(CGRect)frame
                        action:(void (^)(NSString *key1,NSString *key2,NSString* phoneStr))action;


@end
