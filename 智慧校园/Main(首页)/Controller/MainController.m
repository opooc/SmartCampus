//
//  MainController.m
//  智慧校园
//
//  Created by doushuyao on 2017/9/7.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "MainController.h"
#import "MainHeadScrollView.h"
#import "ToolButtonView.h"
#import "ToolModel.h"
#import "CFWebViewController.h"
#import "rebotController.h"
#import "WeatherViewController.h"
#import "PMController.h"

@interface MainController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) MainHeadScrollView* scrollView;
@property (nonatomic, strong) NSArray* dataArr;
@property(nonatomic,strong)UIView* allMainBtnView;

@end

@implementation MainController
{
    CGFloat hi;
    CGFloat barhi;
}


-(NSArray*)dataArr{
    if (_dataArr ==nil) {
        NSString* dataPath = [[NSBundle mainBundle]pathForResource:@"ToolData" ofType:@"plist"];
        self.dataArr = [NSArray arrayWithContentsOfFile:dataPath];
        NSMutableArray* tempArray = [NSMutableArray array];
        for (NSDictionary* dic in self.dataArr) {
            ToolModel * model = [ToolModel btnWihtDict:dic];
            [tempArray addObject:model];
        }
        self.dataArr = tempArray;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
 
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMainHeadScrollView];
    
    [self setbar];
    [self setbtn];
}
-(void)setMainHeadScrollView{
    self.scrollView = [[MainHeadScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 170) ImagesCount:5];
    hi = CGRectGetMaxY(self.scrollView.frame);
    //点击图片的回调＃＃＃＃＃＃＃＃＃＃
    [self.scrollView tapImageViewBlock:^(NSInteger tag) {
        NSLog(@"点击图片Block回调  %zd",tag);
        
    }];
    [self.view addSubview:self.scrollView];
    
}
-(void)setbtn{
    CGFloat Bwidth = self.view.frame.size.width;
    CGFloat Bheight = self.view.frame.size.height+64+32;
    
    UIView* allMainBtnView = [[UIView alloc]initWithFrame:CGRectMake(0,barhi+8,Bwidth,Bheight*0.5)];
    
    _allMainBtnView = allMainBtnView;
    //_allMainBtnView.backgroundColor = [UIColor brownColor];
    NSInteger allCols = 4;
    
    // 2.商品的宽度 和 高度
    CGFloat width = 80;
    CGFloat height = 80;
    // 3.求出水平间距 和 垂直间距
    CGFloat allMainBtnviewWidth = self.allMainBtnView.frame.size.width;
    CGFloat allMainBtnviewHeight = self.allMainBtnView.frame.size.height;
    CGFloat hMargin = (allMainBtnviewWidth - allCols * width) / (allCols -1);
    CGFloat vMargin = (allMainBtnviewHeight-32 - 4*height) / 1;
    for (int i=0;i<8;i++) {
        // 4. 设置索引
        NSInteger index = self.allMainBtnView.subviews.count;
        // 5.求出x值
        CGFloat x = (hMargin + width) * (index % allCols);
        CGFloat y = (vMargin + height) * (index / allCols);
        
        /***********************.创建一个按钮*****************************/
        ToolButtonView *btnView = [[ToolButtonView alloc] initWithModel:self.dataArr[index]];
        btnView.label.font = [UIFont systemFontOfSize:15];
        btnView.label.textColor = [UIColor grayColor];
        
        btnView.btn.layer.cornerRadius = 6;
        btnView.btn.layer.masksToBounds = YES;
        
        /*****   根据按钮的编号 添加弹出控制器*/
        if (index== 0) {
            [btnView.btn addTarget:self action:@selector(cet) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (index== 1) {
            [btnView.btn addTarget:self action:@selector(xiaoli) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (index== 2) {
            [btnView.btn addTarget:self action:@selector(weather) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (index== 3) {
            [btnView.btn addTarget:self action:@selector(rebot) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (index== 4) {
            [btnView.btn addTarget:self action:@selector(pm) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (index== 5) {
            [btnView.btn addTarget:self action:@selector(zfb) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (index== 6) {
            [btnView.btn addTarget:self action:@selector(taobao) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (index== 7) {
            [btnView.btn addTarget:self action:@selector(wangyiyun) forControlEvents:UIControlEventTouchUpInside];
        }
        
        btnView.frame = CGRectMake(x, y, width, height);
        // btnView.backgroundColor = [UIColor blueColor];
        [self.allMainBtnView addSubview:btnView];
        
    }
    
    [self.view addSubview:_allMainBtnView];
    
}
-(void)cet{
    CFWebViewController* cet = [[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"http://cet.neea.edu.cn/cet"]];
    [self.navigationController pushViewController:cet animated:YES];
    
}
-(void)xiaoli{
    
    CFWebViewController* cet = [[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"http://jwc.qfnu.edu.cn/__local/7/E6/90/1AD52DD6E2D4D341A6CFA3DA12A_241AEED1_203B6.pdf"]];
    [self.navigationController pushViewController:cet animated:YES];
    
}

-(void)weather{
    WeatherViewController* weather = [[WeatherViewController alloc]init];
    
    [self.navigationController pushViewController:weather animated:YES];
    
}

-(void)rebot{
    rebotController* rebot =[[rebotController alloc]init];
    [self.navigationController pushViewController:rebot animated:YES];
    
}
-(void)pm{

    PMController* pm = [[PMController alloc]init];
    [self.navigationController pushViewController:pm animated:YES];

}
-(void)zfb{

    CFWebViewController* cet = [[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"https://virtualprod.alipay.com/educate/index.htm"]];
    [self.navigationController pushViewController:cet animated:YES];
}
-(void)taobao{
    CFWebViewController* cet = [[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"https://h5.m.taobao.com/#index"]];
    [self.navigationController pushViewController:cet animated:YES];


}
-(void)wangyiyun{
    CFWebViewController* cet = [[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"http://music.163.com/"]];
    [self.navigationController pushViewController:cet animated:YES];

}

-(void)setbar{
    int dayx = 0;
    
    UIView* content = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), SCREEN_HEIGHT, 80)];
    barhi = CGRectGetMaxY(content.frame);
    
    UIImageView* qiqiu = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qiqiu.png"]];
    qiqiu.frame = CGRectMake(0, 1, 50, 76);
    
    UIView* meiriView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, 80, 20)];
    UILabel* meiriLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, 30)];
    meiriLable.text = @"每日一言";
    UIImageView* shuView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shu.png"]];
    shuView.frame = CGRectMake(0, 0, 8, 30);
    meiriLable.textColor = [UIColor grayColor];
    meiriLable.font = [UIFont systemFontOfSize:15];
    [meiriView addSubview:meiriLable];
    [meiriView addSubview:shuView];
    
    
    UILabel* time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, content.frame.size.height-15, 100, 15)];
    time.text = [self gettime];
    time.font = [UIFont systemFontOfSize:12];
    time.textColor = [UIColor grayColor];
    
    UILabel* mingyan = [[UILabel alloc]initWithFrame:CGRectMake(80, meiriView.frame.size.height, SCREEN_WIDTH-100, 60)];
    
    mingyan.numberOfLines = 0;
    
    switch (dayx%10) {
        case 0:
            mingyan.text = @"没有等出来的辉煌;只有走出来的美丽。";
            break;
        case 1:
            mingyan.text = @"凡事要三思,但比三思更重要的是三思而行。";
            break;
        case 2:
            mingyan.text = @"当你懈怠的时候,请想一下你父母期盼的眼神。";
            break;
        case 3:
            mingyan.text = @"成功是别人失败时还在坚持。";
            break;
        case 4:
            mingyan.text = @"生命之灯因热情而点燃,生命之舟因拼搏而前行。";
            break;
        case 5:
            mingyan.text = @"空谈不如实干。踱步何不向前行。";
            break;
        case 6:
            mingyan.text = @"如果要挖井,就要挖到水出为止。";
            break;
        case 7:
            mingyan.text = @"贪图省力的船夫,目标永远下游。";
            break;
        case 8:
            mingyan.text = @"成功决不喜欢会见懒汉,而是唤醒懒汉。";
            break;
        case 9:
            mingyan.text = @"机遇永远是准备好的人得到的。";
            break;
        default:
            break;
    }
    
    
    
    [self.view addSubview:content];
    [content addSubview:qiqiu];
    [content addSubview:meiriView];
    [content addSubview:time];
    [content addSubview:mingyan];
    
    
    
}
-(NSString*)gettime{
    NSDate *now                               = [NSDate date];
    NSCalendar *calendar                      = [NSCalendar currentCalendar];
    NSUInteger unitFlags                      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent           = [calendar components:unitFlags fromDate:now];
    int y                                     = (short)[dateComponent year];//年
    int m                                    =(short) [dateComponent month];//月
    int mou                                    = (short)[dateComponent month];//月
    int d                                      = (short)[dateComponent day];//日
    int day                                      = (short)[dateComponent day];//日
    if(m==1||m==2) {
        m+=12;
        y--;
    }
    int iWeek=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7+1;
    NSString *Week;
    switch (iWeek) {
        case 1:
            Week=@"一";
            break;
        case 2:
            Week=@"二";
            break;
        case 3:
            Week=@"三";
            break;
        case 4:
            Week=@"四";
            break;
        case 5:
            Week=@"五";
            break;
        case 6:
            Week=@"六";
            break;
        case 7:
            Week=@"日";
            break;
        default:
            Week=@"";
            break;
    }
    NSString*str =[NSString stringWithFormat:@"%d月%d日 星期%@",mou,day,Week];

    return str;
    
    
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
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
