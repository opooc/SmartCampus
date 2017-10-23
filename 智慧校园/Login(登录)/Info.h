//
//  Info.h
//  智慧校园
//
//  Created by doushuyao on 2017/9/11.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject

@property (nonatomic, copy) NSString *Username;  //用户名
+ (Info *)sharedInstance;//单例方法
-(void)save:(NSString *)user;
-(NSString *)getUser;

-(void)savenum:(NSString *)num;
-(NSString *)getnum;

-(void)savexue:(NSString *)xue;
-(NSString *)getxue;
@end
