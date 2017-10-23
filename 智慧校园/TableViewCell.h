//
//  TableViewCell.h
//  智慧校园
//
//  Created by doushuyao on 2017/9/8.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *Reason;
@property (weak, nonatomic) IBOutlet UILabel *submiter;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *Need;

@property (nonatomic, strong) NSDictionary *dataSource;
@end
