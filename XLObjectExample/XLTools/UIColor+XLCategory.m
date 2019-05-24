//
//  UIColor+XLCategory.m
//  XLObjectExample
//
//  Created by GDXL2012 on 2018/5/31.
//  Copyright © 2018年 GDXL2012. All rights reserved.
//

#import "UIColor+XLCategory.h"

@implementation UIColor (XLCategory)

/**
 获取16进制颜色
 
 @param hexValue 16进制数值
 @return UIColor
 */
+ (instancetype)hexColor:(int)hexValue{
    return [UIColor hexColor:hexValue alpha:1.0f];
}

/**
 获取16进制颜色
 
 @param hexValue 16进制数值
 @param alpha 透明度 0.0f ~ 1.0f
 @return UIColor
 */
+ (UIColor *)hexColor:(int)hexValue alpha:(CGFloat)alpha {
    float red   = ((float)((hexValue & 0xFF0000) >> 16)) / 255.0;
    float green = ((float)((hexValue & 0xFF00) >> 8)) / 255.0;
    float blue  = ((float)(hexValue & 0xFF)) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/**
 获取16进制颜色
 
 @param string 16进制字符串【#XXXXXX】
 @return UIColor
 */
+ (instancetype)colorWithHexString:(NSString *)string{
    return [UIColor colorWithHexString:string alpha:1.0f];
}

/**
 获取16进制颜色
 
 @param string 16进制字符串【#XXXXXX】
 @param alpha 透明度 0.0f ~ 1.0f
 @return UIColor
 */
+ (instancetype)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha {
    // 去除首尾的空格
    string = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // 字符串必须是6位以上
    if ([string length] < 6) {
        return [UIColor clearColor];
    }
    
    // 去除【0X】【#】标识位
    if ([string hasPrefix:@"0X"]) {
        string = [string substringFromIndex:2];
    }
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    // 再次判断字符串长度是否符合
    if ([string length] != 6) {
        return [UIColor clearColor];
    }
    // 分割RGB色值：每两位为一个色值
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [string substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [string substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [string substringWithRange:range];
    
    // 扫描字符串并转换16进制为10进制
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

@end
