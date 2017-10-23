//
//  Info.m
//  智慧校园
//
//  Created by doushuyao on 2017/9/11.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "Info.h"

@implementation Info

+ (Info *)sharedInstance
{
    static Info *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

- (void)save:(NSString *)user{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:user forKey:@"username"];
    [ud synchronize];
}

-(NSString *)getUser{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *us=@"";
    if([ud objectForKey:@"username"]){
        us=[ud objectForKey:@"username"];
    }
    return us;
}

- (void)savenum:(NSString *)num{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:num forKey:@"num"];
    [ud synchronize];
}

-(NSString *)getnum{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *us=@"";
    if([ud objectForKey:@"num"]){
        us=[ud objectForKey:@"num"];
    }
    return us;
}

-(void)savexue:(NSString *)xue{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:xue forKey:@"xue"];
    [ud synchronize];
    
}
-(NSString *)getxue{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *us=@"";
    if([ud objectForKey:@"xue"]){
        us=[ud objectForKey:@"xue"];
    }
    return us;
}
@end
