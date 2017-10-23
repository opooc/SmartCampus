//
//  AchieveController.m
//  智慧校园
//
//  Created by doushuyao on 2017/9/7.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "AchieveController.h"
#import "TableViewCell.h"
#import "OHMySQL.h"
#import <UIImageView+WebCache.h>
#import "MBProgressHUD.h"

@interface AchieveController ()<UITableViewDelegate,UITableViewDataSource,SDWebImageManagerDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong)NSArray *dataSource;
@end

@implementation AchieveController
{
    UITableView *_tableView;
    OHMySQLStoreCoordinator *coordinator;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
 
    hud.label.text = NSLocalizedString(@"数据加载中...", @"Please wait a little!");
    
    // Set the details label text. Let's make it multiline this time.
    
    hud.detailsLabel.text = NSLocalizedString(@"Please Wait a minute！", @"HUD title");
    
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        [self LoginMysql];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([NSThread isMainThread])
            {
                [self.view  setNeedsDisplay];
            }
            else
            {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [self.view  setNeedsDisplay];
                    
                });
            }
            [self initUI];
            [hud hideAnimated:YES];
            
            
        });
        
    });
     //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // (@"YYYY-MM-dd hh:mm:ss")----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
   // NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}

-(void)LoginMysql{
    OHMySQLUser *user = [[OHMySQLUser alloc] initWithUserName:@"root"
                                                     password:@"root"
                                                   serverName:@"123.206.103.115"
                                                       dbName:@"irs"
                                                         port:3306
                                                       socket:@"etc/mysql.sock"];
    coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:user];
    [coordinator connect];
    
    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
    queryContext.storeCoordinator = coordinator;
    
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory SELECT:@"irs_repair_info" condition:nil];
    NSError *error = nil;
    NSArray *tasks = [queryContext executeQueryRequestAndFetchResult:query error:&error];
    NSLog(@"%@",tasks);
    
    
     NSMutableArray* mutdataSource;
    
     mutdataSource = [[NSMutableArray alloc]init];
    for (int i = 0; i < tasks.count; i++) {
        
        NSDictionary* dic = tasks[i];
        //时间
        NSString* datastr = dic[@"createtime"];
        NSInteger idata = [datastr intValue];
        NSString* data = [self timestampSwitchTime:idata andFormatter:@"YYYY-MM-dd hh:mm:ss"];
    
        

        //图片
        NSString* imageV0 = dic[@"picture"];
        NSString* imageVStr = [NSString stringWithFormat:@"http://123.206.103.115%@",imageV0];
        
        NSURL* imageURL = [NSURL URLWithString:imageVStr];
        UIImage* imageV;
        
        if ([imageV0 isEqualToString:@""]) {
            imageV =[UIImage imageNamed:@"unshow.jpg"];
            [imageV drawInRect:CGRectMake(0, 0, 150, 150)];
            
        }
        else{
            
            NSData * data1 = [NSData dataWithContentsOfURL:imageURL];
            imageV = [UIImage imageWithData:data1];
             [imageV drawInRect:CGRectMake(0, 0, 150, 150)];
            NSLog(@"%@",imageV);
        }
        
         NSLog(@"%@",imageV);
        
        //地点
        NSString* place0 = dic[@"position"];
        NSString* place = [NSString stringWithFormat:@"地点:%@",place0];
        //原因
        NSString* Reason = dic[@"note"];
        //报修者id
        NSString* submiter0 = dic[@"userid"];
        NSString* submiter = [NSString stringWithFormat:@"账号:%@",submiter0];
        //进度
        NSString* Need0 = dic[@"progress"];
        NSInteger Needi = [Need0 intValue];
        NSString* Need;
        switch (Needi) {
            case 0:
                Need =@"待维修";
                break;
            case 1:
                Need =@"维修中";
                break;
            case 2:
                Need =@"已维修";
                break;
            default:
                break;
        }
        [mutdataSource addObject:@{@"imageV":imageV,
                                   @"Reason":Reason,
                                   @"submiter":submiter,
                                   @"place":place,
                                   @"data":data,
                                   @"Need":Need}];
 
    }
     _dataSource = [NSArray arrayWithArray:mutdataSource];
    NSLog(@"%@",_dataSource);
}


-(void)initUI{

   
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.masksToBounds = false;
    
    //_tableView.estimatedRowHeight = 200;
   // _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _tableView.tableFooterView = [[UIView alloc]init];
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 200;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = _dataSource[indexPath.row];
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.dataSource = dict;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{

    [coordinator disconnect];
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
