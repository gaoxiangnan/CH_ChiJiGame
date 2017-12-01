//
//  ViewUtil.m
//  jinzhuantou
//
//  Created by jianfengChen on 15/4/21.
//  Copyright (c) 2015年 陈 剑锋. All rights reserved.
//

#import "ViewUtil.h"

@implementation ViewUtil

+(CGSize)getTitleSize :(NSString *)title font:(UIFont *)font
{
    return [self getTitleSize:title font:font Width:MAXFLOAT];
}

+(CGSize)getTitleSize :(NSString *)title font:(UIFont *)font Width:(float) width
{
    //过时方法
    //return [title sizeWithFont:[UIFont fontWithName:font size:size] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size =[title boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //高度如果低于21 返回21
    if(size.height<21){
        size.height = 21;
    }
    return size;
}

+(CGSize)getRealTitleSize :(NSString *)title font:(UIFont *)font Width:(float) width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    return [title boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}


///实例化Label
///txt:文字
///font:字体
///color:颜色
///frameX、frameY:布局位置
///padding:左右间距 默认为0  如果不为0 居中显示
///Width:宽度 默认MAXFLOAT
+(UILabel *)createLabelWithTxt:(NSString *) txt Font:(UIFont *)font FontColor:(UIColor *)color frameX:(float)frameX frameY:(float) frameY
{
    return [self createLabelWithTxt:txt Font:font FontColor:color frameX:frameX frameY:frameY Padding:0 Width:MAXFLOAT];
}

+(UILabel *)createLabelWithTxt:(NSString *) txt Font:(UIFont *)font FontColor:(UIColor *)color frameX:(float)frameX frameY:(float) frameY Padding:(int)padding
{
    return [self createLabelWithTxt:txt Font:font FontColor:color frameX:frameX frameY:frameY Padding:padding Width:MAXFLOAT];
}

+(UILabel *)createLabelWithTxt:(NSString *) txt Font:(UIFont *)font FontColor:(UIColor *)color frameX:(float)frameX frameY:(float) frameY Width:(int)width
{
    return [self createLabelWithTxt:txt Font:font FontColor:color frameX:frameX frameY:frameY Padding:0 Width:width];
}

+(UILabel *)createLabelWithTxt:(NSString *) txt Font:(UIFont *)font FontColor:(UIColor *)color frameX:(float)frameX frameY:(float) frameY Padding:(int)padding Width:(float)width
{
    CGSize txtSize = [self getTitleSize:txt font:font Width:width];
    CGRect rect = CGRectMake(frameX, frameY, txtSize.width + padding*2, txtSize.height);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    [label setText:txt];
    //居中
    if(padding !=0){
        [label setTextAlignment:NSTextAlignmentCenter];
    }
    //支持\n换行
    [label setNumberOfLines:0];
    [label setFont:font];
    [label setTextColor:color];
    return label;
}

+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

///隐藏NavigationBar 底部的黑线
+(void)hideNavigationBarLine:(UINavigationBar *)navigationBar
{
    if ([navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        /*
        NSArray *list=navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }*/
        [self removeNavBlackLine:navigationBar];
    }
}

+ (void)removeNavBlackLine:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if (subView.subviews.count) {
            [self removeNavBlackLine:subView];
        } else {
            
            if (subView.frame.size.height <= 1) {
                [subView removeFromSuperview];
            }
        }
    }
}

///获取Navigation高度
+(float)getNavigationHeight:(UIViewController *)vc
{
    if(vc.navigationController){
        return vc.navigationController.navigationBar.frame.origin.y+vc.navigationController.navigationBar.frame.size.height;
    }else{
        return 64;
    }
}

+(float)getTabBarHeight:(UIViewController *)vc
{
    if(vc.tabBarController){
        return vc.tabBarController.tabBar.frame.size.height;
    }else{
        return 49;
    }
}
@end
