//
//  TableViewCell.m
//  智慧校园
//
//  Created by doushuyao on 2017/9/8.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "TableViewCell.h"


@implementation TableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    // [self initUI];
    
    return self;
}

-(void)setDataSource:(NSDictionary *)dataSource{
    _dataSource = dataSource;
    
//    NSString*imageStr =  dataSource[@"imageV"];
    _imageV.image = dataSource[@"imageV"];
    
    _Reason.text = dataSource[@"Reason"];
    _submiter.text = dataSource[@"submiter"];
    _place.text = dataSource[@"place"];
    _data.text = dataSource[@"data"];
    _Need.text = dataSource[@"Need"];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
