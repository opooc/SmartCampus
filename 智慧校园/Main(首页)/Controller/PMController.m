//
//  PMController.m
//  智慧校园
//
//  Created by doushuyao on 2017/9/15.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "PMController.h"
#import "STPickerView.h"
#import "STPickerArea.h"

@interface PMController ()<UITextFieldDelegate, STPickerAreaDelegate>

@property(nonatomic,strong)UILabel* weekn;
@property(nonatomic,strong)UILabel* weathern;
@property(nonatomic,strong)UILabel* winddirectn;
@property(nonatomic,strong)UILabel* temphighn;
@property(nonatomic,strong)UILabel* templown;
@property(nonatomic,strong)UILabel* tempn;
@property(nonatomic,strong)UILabel* sportn;

@end

@implementation PMController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snow.png"]];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT);
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
    [self.view addSubview:effectView];
    [self.view addSubview:imageView];
    
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"snow.png"]];
    
    self.title =@"PM2.5查询";
    
    _area = [[UITextField alloc]init];
    _area.frame = CGRectMake(SCREEN_WIDTH*0.5 - 80,80,SCREEN_WIDTH-100,80);
    _area.placeholder = @"请点击文字选择地区";
    [_area setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _area.font = [UIFont systemFontOfSize:23];
    _area.delegate = self;
    [self.view addSubview:_area];
    
    
    
    _week = [[UILabel alloc]init];
    _week.frame = CGRectMake(23, 200, 100, 30);
    _week.text = @"        排名:";
    _week.textColor = [UIColor grayColor];
    _week.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_week];
    
    _weather = [[UILabel alloc]init];
    _weather.frame = CGRectMake(23, 250, 100, 30);
    _weather.text = @"        时间:";
    _weather.textColor = [UIColor grayColor];
    _weather.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_weather];
    
    _winddirect = [[UILabel alloc]init];
    _winddirect.frame = CGRectMake(23, 300, 100, 30);
    _winddirect.text = @"     PM2.5:";
    _winddirect.textColor = [UIColor grayColor];
    _winddirect.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_winddirect];
    
    _temphigh = [[UILabel alloc]init];
    _temphigh.frame = CGRectMake(23, 350, 100, 30);
    _temphigh.text = [NSString stringWithFormat:@"空气指数:"];
    _temphigh.textColor = [UIColor grayColor];
    _temphigh.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_temphigh];
    
    _templow = [[UILabel alloc]init];
    _templow.frame = CGRectMake(23, 400, 100, 30);
    _templow.text = @"空气质量:";
    _templow.textColor = [UIColor grayColor];
    _templow.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_templow];
    
    _temp = [[UILabel alloc]init];
    _temp.frame = CGRectMake(23, 450, 100, 30);
    _temp.text = @"CO指数:";
    _temp.textColor = [UIColor grayColor];
    _temp.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_temp];
    

    
    
    
    
    
    _weekn = [[UILabel alloc]init];
    _weekn.frame = CGRectMake(120, 200, 100, 30);
    _weekn.textColor = [UIColor grayColor];
    _weekn.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:_weekn];
    
    _weathern = [[UILabel alloc]init];
    _weathern.frame = CGRectMake(120, 250, 300, 30);
    _weathern.textColor = [UIColor grayColor];
    _weathern.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:_weathern];
    
    _winddirectn = [[UILabel alloc]init];
    _winddirectn.frame = CGRectMake(120, 300, 100, 30);
    _winddirectn.textColor = [UIColor grayColor];;
    _winddirectn.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:_winddirectn];
    
    _temphighn = [[UILabel alloc]init];
    _temphighn.frame = CGRectMake(120, 350, 100, 30);
    _temphighn.textColor = [UIColor grayColor];;
    _temphighn.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:_temphighn];
    
    _templown = [[UILabel alloc]init];
    _templown.frame = CGRectMake(120, 400, 100, 30);
    _templown.textColor = [UIColor grayColor];;
    _templown.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:_templown];
    
    
    _tempn = [[UILabel alloc]init];
    _tempn.frame = CGRectMake(120, 450, 100, 30);
    _tempn.textColor = [UIColor grayColor];;
    _tempn.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:_tempn];
    
    

    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self.area resignFirstResponder];
    
    STPickerArea *pickerArea = [[STPickerArea alloc]init];
    [pickerArea setDelegate:self];
    [pickerArea setSaveHistory:YES];
    [pickerArea setContentMode:STPickerContentModeCenter];
    [pickerArea show];
}
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.area.text = text;
    [self show:city];
}

-(void)show:(NSString*)body{
    NSString *appcode = @"da658159a4d9483d8fb26fc7f0ed0d7d";
    NSString *host = @"https://ali-pm25.showapi.com";
    NSString *path = @"/pm25-detail";
    NSString *method = @"GET";
    
    NSString * bodyString = [body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *querys = [NSString stringWithFormat: @"?city=%@",bodyString];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    //    NSString *bodys = @"";
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
                                                       //                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       
                                                       //打印应答中的body
                                                       
                                                       NSDictionary* dict1 = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableContainers error:nil];
                                                       NSDictionary* dict3 = [dict1 objectForKey:@"showapi_res_body"];
                                                       NSDictionary* dict2 = [dict3 objectForKey:@"pm"];
                                                       
                                                       
                                                       NSString* week = [dict2 objectForKey:@"num"];
                                                       NSString* weather = [dict2 objectForKey:@"ct"];
                                                       NSString* winddirect = [dict2 objectForKey:@"pm2_5"];
                                                       NSString* temp = [dict2 objectForKey:@"aqi"];
                                                       NSString* temphigh = [dict2 objectForKey:@"quality"];
                                                       NSString* templow = [dict2 objectForKey:@"co"];
                                                       NSArray* sportArr = [dict2 objectForKey:@"index"];
                                                       NSDictionary* sportx = sportArr[1];
                                                       NSString* sprotstr = [sportx objectForKey:@"detail"];
                                                       
                                                       
                                                       
                                                       NSLog(@"Response body: %@,%@,%@,%@" , week,weather,winddirect,sprotstr);
                                                       
                                                       if ([NSThread isMainThread])
                                                       {
                                                           _weekn.text = week;
                                                           _weathern.text = weather;
                                                           _winddirectn.text = winddirect;
                                                           _tempn.text = temp;
                                                           _temphighn.text = templow;
                                                           _templown.text = temphigh;
                                                           _sportn.text = sprotstr;
                                                           
                                                           [_weekn  setNeedsDisplay];
                                                           [_weathern  setNeedsDisplay];
                                                           [_winddirectn  setNeedsDisplay];
                                                           [_tempn  setNeedsDisplay];
                                                           [_temphighn  setNeedsDisplay];
                                                           [_templown  setNeedsDisplay];
                                                           [_sportn  setNeedsDisplay];
                                                       }
                                                       else
                                                       {
                                                           dispatch_sync(dispatch_get_main_queue(), ^{
                                                               //Update UI in UI thread here
                                                               _weekn.text = week;
                                                               _weathern.text = weather;
                                                               _winddirectn.text = winddirect;
                                                               _tempn.text = temp;
                                                               _temphighn.text = templow;
                                                               _templown.text = temphigh;
                                                               _sportn.text = sprotstr;
                                                               
                                                               [_weekn  setNeedsDisplay];
                                                               [_weathern  setNeedsDisplay];
                                                               [_winddirectn  setNeedsDisplay];
                                                               [_tempn  setNeedsDisplay];
                                                               [_temphighn  setNeedsDisplay];
                                                               [_templown  setNeedsDisplay];
                                                               [_sportn  setNeedsDisplay];
                                                           });
                                                       }
                                                       
                                                   }];
    
    [task resume];
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
