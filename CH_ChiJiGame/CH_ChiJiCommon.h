//
//  CH_ChiJiCommon.h
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/20.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#ifndef CH_ChiJiCommon_h
#define CH_ChiJiCommon_h


#endif /* CH_ChiJiCommon_h */

#define BaseURL @"jdsc.codechm.com"

//通过RGB设置颜色
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kColorWithRGB(r, g, b, a) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
//设备信息
#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度
#define KISHighVersion_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define KIS_IPHONE_6P ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] bounds].size.height == 736.0)//6plus
#define KAddFont_6P(font) (((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] bounds].size.height == 736.0)?font+2:font)//6plus font＋2

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]//16进制颜色转换

#ifdef DEBUG_MODE
#define NPrintLog(FORMAT, ...) printf("%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NPrintLog(...)
#endif
