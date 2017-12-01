//
//  ViewUtil.h
//  jinzhuantou
//
//  Created by jianfengChen on 15/4/21.
//  Copyright (c) 2015年 陈 剑锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ViewUtil : NSObject

///根据标题和字体 得到大小
+(CGSize)getTitleSize :(NSString *)title font:(UIFont *)font Width:(float) width;
+(CGSize)getTitleSize :(NSString *)title font:(UIFont *)font;

///根据标题和字体 得到大小 (真实高度)
+(CGSize)getRealTitleSize :(NSString *)title font:(UIFont *)font Width:(float) width;

///实例化Label
///txt:文字
///font:字体
///color:颜色
///frameX、frameY:布局位置
///padding:左右间距 默认为0  如果不为0 居中显示
///Width:宽度 默认MAXFLOAT
+(UILabel *)createLabelWithTxt:(NSString *) txt Font:(UIFont *)font FontColor:(UIColor *)color frameX:(float)frameX frameY:(float) frameY;
///实例化Label
///txt:文字
///font:字体
///color:颜色
///frameX、frameY:布局位置
///padding:左右间距 默认为0  如果不为0 居中显示
///Width:宽度 默认MAXFLOAT
+(UILabel *)createLabelWithTxt:(NSString *) txt Font:(UIFont *)font FontColor:(UIColor *)color frameX:(float)frameX frameY:(float) frameY Padding:(int)padding;
///实例化Label
///txt:文字
///font:字体
///color:颜色
///frameX、frameY:布局位置
///padding:左右间距 默认为0  如果不为0 居中显示
///Width:宽度 默认MAXFLOAT
+(UILabel *)createLabelWithTxt:(NSString *) txt Font:(UIFont *)font FontColor:(UIColor *)color frameX:(float)frameX frameY:(float) frameY Width:(int)width;
///实例化Label
///txt:文字
///font:字体
///color:颜色
///frameX、frameY:布局位置
///padding:左右间距 默认为0  如果不为0 居中显示
///Width:宽度 默认MAXFLOAT
+(UILabel *)createLabelWithTxt:(NSString *) txt Font:(UIFont *)font FontColor:(UIColor *)color frameX:(float)frameX frameY:(float) frameY Padding:(int)padding Width:(float)width;

///隐藏掉navigationBar底部的黑线
+(void)hideNavigationBarLine:(UINavigationBar *)navigationBar;
///设置输入框左间距
+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;
///获取Navigation高度
+(float)getNavigationHeight:(UIViewController *)vc;
///获取tabBar的高度
+(float)getTabBarHeight:(UIViewController *)vc;

//+ (void)removeNavBlackLine:(UIView *)view;
@end
