//
//  STPickerDate.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerDate.h"
#import "NSCalendar+STPicker.h"

typedef NS_OPTIONS(NSUInteger, STCalendarUnit) {
    STCalendarUnitYear  = (1UL << 0),
    STCalendarUnitMonth = (1UL << 1),
    STCalendarUnitDay   = (1UL << 2),
    STCalendarUnitHour  = (1UL << 3),
    STCalendarUnitMinute= (1UL << 4),
};

@interface STPickerDate()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.年 */
@property (nonatomic, assign)NSInteger year;
/** 2.月 */
@property (nonatomic, assign)NSInteger month;
/** 3.日 */
@property (nonatomic, assign)NSInteger day;

@end

@implementation STPickerDate

#pragma mark - --- init 视图初始化 ---

- (void)setupUI {
    
    self.title = @"请选择日期";
    
    _yearLeast = 1900;
    _yearSum   = 200;
    _heightPickerComponent = 28;
//    self.calendarUnit = STCalendarUnitYear | STCalendarUnitMonth | STCalendarUnitDay;
    
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.yearSum;
            break;
        case 1:
            return 12;
            break;
        default:
            return [NSCalendar getDaysWithYear:self.year month:self.month];
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:{
            self.year = row + self.yearLeast;
            [pickerView reloadComponent:2];
        }break;
        case 1:{
            self.month = row + 1;
            [pickerView reloadComponent:2];
        }break;
        case 2:{
        }break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    //设置分割线的颜色
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height <=1) {
            obj.backgroundColor = self.borderButtonColor;
        }
    }];
    
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%zd", row + self.yearLeast];
    }else if (component == 1){
        text =  [NSString stringWithFormat:@"%zd", row + 1];
    }else{
        text = [NSString stringWithFormat:@"%zd", row + 1];
    }

    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    if ([self.delegate respondsToSelector:@selector(pickerDate:year:month:day:)]) {
        NSInteger day = [self.pickerView selectedRowInComponent:2] + 1;
         [self.delegate pickerDate:self year:self.year month:self.month day:day];
    }
   
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- setters 属性 ---

- (void)setYearLeast:(NSInteger)yearLeast
{
    if (yearLeast<=0) {
        return;
    }
    
    _yearLeast = yearLeast;
    [self.pickerView selectRow:(_year - _yearLeast) inComponent:0 animated:NO];
    [self.pickerView selectRow:(_month - 1) inComponent:1 animated:NO];
    [self.pickerView selectRow:(_day - 1) inComponent:2 animated:NO];
    [self.pickerView reloadAllComponents];
}

- (void)setYearSum:(NSInteger)yearSum{
    if (yearSum<=0) {
        return;
    }
    
    _yearSum = yearSum;
    [self.pickerView reloadAllComponents];
}

#pragma mark - --- getters 属性 ---


@end


