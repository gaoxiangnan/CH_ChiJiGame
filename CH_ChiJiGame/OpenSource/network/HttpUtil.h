//
//  HttpUtil.h
//  jinzhuantou
//
//  Created by jianfengChen on 15/5/20.
//  Copyright (c) 2015年 陈 剑锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"
//定义一个协议
@protocol HttpDelegate <NSObject>

@required
///http回调 tag http请求的标识  response 返回的结果
-(void)httpCallBack:(int)tag Response:(NSDictionary *)response;

@end

///http请求类型
typedef NS_ENUM(NSInteger, HttpType){
    HttpTypeGet=0,
    HttpTypePost=1,
    HttpTypePostFile=2,
};


@interface HttpUtil : NSObject

///请求地址
@property(nonatomic,strong) NSString *url;
//http请求类型
@property HttpType httpType;
///标签 用于回调区分开多个http请求
@property int tag;
///代理  用于执行回调
@property(nonatomic,assign) id<HttpDelegate> delegate;
///post请求参数
@property(nonatomic,strong) NSString *strParams;
///上传文件请求 非文件参数
@property(nonatomic,strong) NSArray *arrParams;
///上传文件数组
@property(nonatomic,strong) NSArray *Files;
///上传文件的名称数组
@property(nonatomic,strong) NSArray *FileNames;
///是否显示指示层
@property BOOL showHud;

///异步get请求
///Url:地址
///Tag:标签、编号 用于回调方法中区分
///CallBack:回调对象 请求完成后会执行对象的httpCallBack方法
///ShowHud:是否显示出来指示层
+(void)AsyncGetRequestWithUrl:(NSString *)url
                          Tag:(int)tag
                     CallBack:(id<HttpDelegate>) callBack
                      ShowHud:(BOOL)showHud;


///异步post请求
///Url:地址
///Params:参数 例如:uid=1&sign=xxx
///Tag:标签、编号 用于回调方法中区分
///CallBack:回调对象 请求完成后会执行对象的httpCallBack方法
///ShowHud:是否显示出来指示层
+(void)AsyncPostRequestWithUrl:(NSString *)url
                        Params:(NSString *)params
                           Tag:(int)tag
                      CallBack:(id<HttpDelegate>) callBack
                       ShowHud:(BOOL)showHud;

///异步post请求 包含文件
///Url:地址
///Params:参数 没个参数是一个NSDictionary @"key" 为参数名 value 为参数值
///Files:文件数组
///FileNames:文件的 name数组
///Tag:标签、编号 用于回调方法中区分
///CallBack:回调对象 请求完成后会执行对象的httpCallBack方法
///ShowHud:是否显示出来指示层
+(void)AsyncPostFormRequestWithUrl:(NSString *)url
                            Params:(NSArray *)params
                             Files:(NSArray *)Files
                         FileNames:(NSArray *)FileNames
                               Tag:(int)tag
                          CallBack:(id<HttpDelegate>) callBack
                           ShowHud:(BOOL)showHud;
/*
 同步请求方法 h文件注释掉 防止错误调用
 
///发送post请求 传图片和参数
+ (NSData *)postFileRequestWithUrl: (NSString *)url
                    postParems: (NSArray *)postParems
                         Files: (NSArray *)Files
                     FileNames: (NSArray *)FileNames;

///发送get请求
+(NSData *)getRequestWithUrl:(NSString *)urlString;
///发送post请求
+(NSData *)postRequestWithUrl:(NSString *)urlString params:(NSString *) params;
*/
@end

