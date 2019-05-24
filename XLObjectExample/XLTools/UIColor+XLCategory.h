//
//  UIColor+XLCategory.h
//  XLObjectExample
//
//  Created by GDXL2012 on 2018/5/31.
//  Copyright © 2018年 GDXL2012. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIColor (XLCategory)

/**
 获取16进制颜色
 
 @param hexValue 16进制数值
 @return UIColor
 */
+ (instancetype)hexColor:(int)hexValue;

/**
 获取16进制颜色
 
 @param hexValue 16进制数值
 @param alpha 透明度 0.0f ~ 1.0f
 @return UIColor
 */
+ (UIColor *)hexColor:(int)hexValue alpha:(CGFloat)alpha;

/**
 获取16进制颜色
 
 @param string 16进制字符串【#XXXXXX】
 @return UIColor
 */
+ (instancetype)colorWithHexString:(NSString *)string;

/**
 获取16进制颜色
 
 @param string 16进制字符串【#XXXXXX】
 @param alpha 透明度 0.0f ~ 1.0f
 @return UIColor
 */
+ (instancetype)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;

@end
