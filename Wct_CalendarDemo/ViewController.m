//
//  ViewController.m
//  Wct_CalendarDemo
//
//  Created by Wcting on 2019/10/30.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testCalendar];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableString *strFormatter = [NSMutableString string];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay fromDate:[NSDate date]];
    [dateComponents setDay:dateComponents.day+1];
    [strFormatter appendFormat:@"%@",[self getDateFormatterStringWith:dateComponents]];
    NSLog(@"当前年月日:%@",strFormatter);
    [self getDayCountOfMonth];
}

- (NSString *)getDateFormatterStringWith:(NSDateComponents *)components
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *dateCurrent = [calendar dateFromComponents:components];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strCalender = [formatter stringFromDate:dateCurrent];
    
    return strCalender;
}

- (void)getDayCountOfMonth
{
    NSDate *date = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsCurrent = [currentCalendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];//kCFCalendarUnitMonth|kCFCalendarUnitDay
    [componentsCurrent setMonth:componentsCurrent.month + 1];
    NSDate *dateNext = [currentCalendar dateFromComponents:componentsCurrent];
    NSRange range = [currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateNext];
    NSInteger daysCount = range.length;
    NSLog(@"%ld月有多少天:%ld",(long)componentsCurrent.month,(long)daysCount);
}

- (void)testCalendar
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comp = [[NSDateComponents alloc] init];
    
    [comp setDay:2];
    [comp setMonth:11];
    [comp setYear:2011];
    
    NSDate * date = [calendar dateFromComponents:comp];
    
    NSDateComponents * addComponents = [[NSDateComponents alloc] init];
    for(int i = 0; i< 7; i ++){
        [addComponents setDay:i];
        NSDate * d = [calendar dateByAddingComponents:addComponents toDate:date options:0];
        NSDateComponents * dComponents = [calendar components:(kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay)fromDate:d];
        
        int day = [dComponents day];
        //        NSLog(@"Date：%@ Day：%i",[d description],day);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strCalender = [formatter stringFromDate:d];
        NSLog(@"Date：%@ Day：%i",strCalender,day);
        
    }
}

@end

