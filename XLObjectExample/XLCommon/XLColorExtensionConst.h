//
//  XLColorExtensionConst.h
//  XLObjectExample
//
//  Created by GDXL2012 on 2018/5/31.
//  Copyright © 2018年 GDXL2012. All rights reserved.
//

#ifndef XLColorExtensionConst_h
#define XLColorExtensionConst_h
#import "UIColor+XLCategory.h"

/**
 方法定义
 **/
// RGB Color
#define RGBAColor(r, g, b, a)       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBColor(r, g, b)           [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0f]

// 16进制值转换
#define HexColor(hex)               [UIColor colorWithHexString:hex]
#define HexAlphaColor(hex, a)   [UIColor colorWithHexString:hex alpha:(a)]

#endif /* XLColorExtensionConst_h */
