//
//  NSDate+XLCategory.m
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/5/24.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import "NSDate+XLCategory.h"

@implementation NSDate (XLCategory)

//获取最近七天时间 数组
+(NSMutableArray *)latelyWeekTime{
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    
    for (int i = 6; i >= 0; i --) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = -i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        
        //转换英文为中文
        NSString *chinaStr = [NSDate cTransformFromE:weekStr];
        
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@\n%@",dateStr,chinaStr];
        [eightArr addObject:strTime];
    }
    
    return eightArr;
}

//获取最近dayCount天时间 数组
+(NSMutableArray *)latelyDaysTimeForCount:(NSInteger)dayCount{
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    
    for (int i = dayCount - 1; i >= 0; i --) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = -i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        
        //转换英文为中文
        NSString *chinaStr = [NSDate cTransformFromE:weekStr];
        
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@\n%@",dateStr,chinaStr];
        [eightArr addObject:strTime];
    }
    
    return eightArr;
}

//转换英文为中文
+(NSString *)cTransformFromE:(NSString *)theWeek{
    NSString *chinaStr;
    if(theWeek){
        if([theWeek isEqualToString:@"Monday"] ||
           [theWeek isEqualToString:@"星期一"]){
            chinaStr = @"周一";
        }else if([theWeek isEqualToString:@"Tuesday"] ||
                 [theWeek isEqualToString:@"星期二"]){
            chinaStr = @"周二";
        }else if([theWeek isEqualToString:@"Wednesday"] ||
                 [theWeek isEqualToString:@"星期三"]){
            chinaStr = @"周三";
        }else if([theWeek isEqualToString:@"Thursday"] ||
                 [theWeek isEqualToString:@"星期四"]){
            chinaStr = @"周四";
        }else if([theWeek isEqualToString:@"Friday"] ||
                 [theWeek isEqualToString:@"星期五"]){
            chinaStr = @"周五";
        }else if([theWeek isEqualToString:@"Saturday"] ||
                 [theWeek isEqualToString:@"星期六"]){
            chinaStr = @"周六";
        }else if([theWeek isEqualToString:@"Sunday"] ||
                 [theWeek isEqualToString:@"星期日"]){
            chinaStr = @"周日";
        }
    }
    return chinaStr;
}
@end
