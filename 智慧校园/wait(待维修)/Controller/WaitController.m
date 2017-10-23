
//
//  WaitController.m
//  智慧校园
//
//  Created by doushuyao on 2017/9/7.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "WaitController.h"
#import "LPDQuoteImagesView.h"
#import "OHMySQL.h"
#import "Info.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "AFNetworking.h"

@interface WaitController ()<UITextViewDelegate,LPDQuoteImagesViewDelegate,WCSessionDelegate>
@property(nonatomic,strong)UITextView* textView;
@property(nonatomic,strong)UITextView* textView1;
@property(nonatomic,strong)UITextView* textView2;



@end
#define maxcount 100
@implementation WaitController
{   UIScrollView* bgScroll;
    
    UILabel * tip;
    UILabel * tip1;
    UILabel * tip2;
    
    UILabel* rightCount;
    CGFloat t2y;
    CGFloat imy;
    
    LPDQuoteImagesView *quoteImagesView;
    
    OHMySQLStoreCoordinator *coordinator;
    
    NSString* position;//位置
    NSString* note;//原因
    NSString* userid;//账号
    NSString* thing;//种类
    NSString* createtime;
    
    NSString* postwatchOS;

 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"在线报修";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    [self setImage];
    [self setbtn];
    
    
}
-(void)setupView{
    
    bgScroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    bgScroll.scrollEnabled = YES;
    bgScroll.alwaysBounceVertical = YES;
    [self.view addSubview:bgScroll];
    
    UILabel* textLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 15)];
    textLable.text = @"报修类型";
    [bgScroll addSubview:textLable];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(textLable.frame)+5, SCREEN_WIDTH-30, 50)];
    
    _textView.layer.borderWidth = 1;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _textView.font =  [UIFont systemFontOfSize:15];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIColor lightGrayColor];
    _textView.delegate = self;
    [bgScroll addSubview:_textView];
    
    UILabel* textLable1 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_textView.frame)+13, SCREEN_WIDTH, 15)];
    textLable1.text = @"报修地点";
    [bgScroll addSubview:textLable1];
  
    _textView1 = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(textLable1.frame)+5, SCREEN_WIDTH-30, 50)];
    
    _textView1.layer.borderWidth = 1;
    _textView1.layer.cornerRadius = 5;
    _textView1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _textView1.font =  [UIFont systemFontOfSize:15];
    _textView1.backgroundColor = [UIColor whiteColor];
    _textView1.textColor = [UIColor lightGrayColor];
    _textView1.delegate = self;
    [bgScroll addSubview:_textView1];
    
    
    UILabel* textLable2 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_textView1.frame)+13, SCREEN_WIDTH, 15)];
    textLable2.text = @"问题说明";
    [bgScroll addSubview:textLable2];
    
    _textView2 = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(textLable2.frame)+5, SCREEN_WIDTH-30, 120)];
    _textView2.layer.borderWidth = 1;
    _textView2.layer.cornerRadius = 5;
    _textView2.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _textView2.font =  [UIFont systemFontOfSize:15];
    _textView2.backgroundColor = [UIColor whiteColor];
    _textView2.textColor = [UIColor lightGrayColor];
    _textView2.delegate = self;
    t2y = CGRectGetMaxY(_textView2.frame);
    
    [bgScroll addSubview:_textView2];
    
    if (tip == nil) {
        tip = [[UILabel alloc]initWithFrame:CGRectMake(5,5,_textView.frame.size.width -10, 20)];
        
        tip.textColor = [UIColor lightGrayColor];
        tip.text = @"请输入报修类型";
        tip.font = [UIFont systemFontOfSize:15];
        [_textView addSubview:tip];
    }
    if (tip1 == nil) {
        tip1 = [[UILabel alloc]initWithFrame:CGRectMake(5,5,_textView1.frame.size.width -10, 20)];
        
        tip1.textColor = [UIColor lightGrayColor];
        tip1.text = @"请输入报修地点";
        tip1.font = [UIFont systemFontOfSize:15];
        [_textView1 addSubview:tip1];
    }
    if (tip2 == nil) {
        tip2 = [[UILabel alloc]initWithFrame:CGRectMake(5,5,_textView2.frame.size.width -10, 20)];
        
        tip2.textColor = [UIColor lightGrayColor];
        tip2.text = @"请输入问题说明";
        tip2.font = [UIFont systemFontOfSize:15];
        [_textView2 addSubview:tip2];
    }
    
    if (rightCount == nil) {
        rightCount = [[UILabel alloc]initWithFrame:CGRectMake(_textView.frame.size.width -50, CGRectGetMaxY(_textView.frame)-30, 50, 20)];
        rightCount.textColor = [UIColor lightGrayColor];
        rightCount.font = [UIFont systemFontOfSize:12];
        rightCount.textAlignment = NSTextAlignmentCenter;
        [self setCount:maxcount];
        [_textView addSubview:rightCount];
        
    }
   
    
}
-(void)setImage{

    quoteImagesView =[[LPDQuoteImagesView alloc] initWithFrame:CGRectMake(15, t2y+20, SCREEN_WIDTH-30 , 200) withCountPerRowInView:5 cellMargin:12];
    //初始化view的frame, view里每行cell个数, cell间距(上方的图片1 即为quoteImagesView)
   // 注:设置frame时,我们可以根据设计人员给的cell的宽度和最大个数、排列,间距去大致计算下quoteview的size.
    quoteImagesView.maxSelectedCount = 2;
    //最大可选照片数
    
    quoteImagesView.collectionView.scrollEnabled = NO;
    //view可否滑动
    
    quoteImagesView.navcDelegate = self;    //self 至少是一个控制器。
    //委托(委托controller弹出picker,且不用实现委托方法)
    
    [bgScroll  addSubview:quoteImagesView];
    //把view加到某一个视图上,就什么都不用管了！！！！
    

}

-(void)setbtn{
    UIButton* sub = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_textView2.frame)+200, SCREEN_WIDTH-30, 40)];
    [sub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sub setTitle:@"提 交" forState:UIControlStateNormal];
    [sub setBackgroundColor:[UIColor colorWithRed:244.0/255.0 green:158.0/255.0 blue:17.0/255.0 alpha:1.0]];
    sub.titleLabel.font = [UIFont systemFontOfSize:20];
    sub.layer.cornerRadius = 5;
    sub.layer.masksToBounds = YES;
    [sub addTarget:self action:@selector(subToServer) forControlEvents:UIControlEventTouchUpInside];
    [bgScroll addSubview:sub];
}
-(void)subToServer{
    
    
    UIAlertView* tishi = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
    [tishi show];
    
   NSArray* imageArray =  [NSArray arrayWithArray:quoteImagesView.selectedPhotos];
    UIImage* image1 = [imageArray firstObject];
    
    [self setMysql];
    [self setWatchOS];
    [self postServer:image1];

}
-(void)postServer:(UIImage*)image{
    //AFN3.0+基于封住HTPPSession的句柄
    
    ;
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://123.206.103.115/opooc/doAction3.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        NSData *imageData = UIImagePNGRepresentation(image);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
//        [formData appendPartWithFileData:imageData
//                                    name:@"file"
//                                fileName:fileName
//                                mimeType:@"image/png"];
        //使用formData来拼接数据
        /*
         第一个参数:二进制数据 要上传的文件参数
         第二个参数:服务器规定的
         第三个参数:该文件上传到服务器以什么名称保存
         */
       
//
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功---%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败---%@",error);
    }];

}


-(void)setCount:(NSInteger) count{
    
    rightCount.text = [NSString stringWithFormat:@"%ld",(long)count];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    
    NSString*txt = [_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString*txt1 = [_textView1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString*txt2 = [_textView2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    position = txt1;//位置
    note = txt2;//原因
    
    thing = txt;//种类
    
    tip.hidden = txt.length>0;
    tip1.hidden = txt1.length>0;
    tip2.hidden = txt2.length>0;
    
    
    if (txt.length>maxcount) {
        _textView.text = [txt substringToIndex:maxcount];
    }
    [self setCount:(maxcount - txt.length)];
}

-(void)setMysql{
    NSString *timestr = [NSString stringWithFormat:@"%ld",(long)[self gettime]];
    createtime = timestr;
    postwatchOS = [self timestampSwitchTime:[self gettime] andFormatter: @"YYYY-MM-dd hh:mm:ss"];
    userid = [[Info sharedInstance]getUser];
    
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
    
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory INSERT:@"irs_repair_info" set:@{
                                                                                   @"createtime": createtime,
                                                                                   @"evaluate": @"",
                                                                                  
                                                                                   @"note": note,
                                                                                   @"picture": @"",
                                                                                   @"position": position,
                                                                                   @"progress": @"",
                                                                                   @"thing": thing,
                                                                                   @"updatetime": @"",
                                                                                    @"userid": userid,
                                                                                    @"wxid": @""
                                                                                   }];
    NSError *error;
    [queryContext executeQueryRequest:query error:&error];

}

-(NSInteger )gettime{
        
        
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    
    
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:
    
    
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeSp;
    

}
//ssssssss
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
     [_textView1 resignFirstResponder];
     [_textView2 resignFirstResponder];
    
}
-(void)setWatchOS{
    
    if ([WCSession isSupported]) {
        WCSession * session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
        [session updateApplicationContext:@{@"Timedate":postwatchOS ,@"Thingdate":note} error:nil];
        
    }
    
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
