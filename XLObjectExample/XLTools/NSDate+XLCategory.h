//
//  NSDate+XLCategory.h
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/5/24.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (XLCategory)

//获取最近七天时间 数组
+(NSMutableArray *)latelyWeekTime;

//获取最近dayCount天时间 数组
+(NSMutableArray *)latelyDaysTimeForCount:(NSInteger)dayCount;

@end

NS_ASSUME_NONNULL_END
