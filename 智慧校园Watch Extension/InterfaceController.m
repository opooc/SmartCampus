//
//  InterfaceController.m
//  智慧校园Watch Extension
//
//  Created by doushuyao on 2017/9/14.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface InterfaceController ()<WCSessionDelegate>
{
    WCSession * session;
}
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *Time;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *Timedate;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *Thing;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *Thingdate;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
 
    

    // Configure interface objects here.
}
- (IBAction)look {
    
    if ([WCSession isSupported]) {
        session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    /*将接收到的消息展示到刚刚准备好的label上*/
    [self.Timedate setText:session.receivedApplicationContext[@"Timedate"]];
    [self.Thingdate setText:session.receivedApplicationContext[@"Thingdate"]];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



