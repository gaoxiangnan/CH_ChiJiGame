//
//  CH_NetWorkManager.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/27.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "CH_NetWorkManager.h"
#import <CommonCrypto/CommonDigest.h>//md5
#import "AFNetworking.h"



@implementation CH_NetWorkManager
+ (instancetype)sharedManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:nil];
    });
    
    return instance;
}
- (void)requestWithURLString: (NSString *)URLString
                  parameters: (NSDictionary *)parameters
                      method: (NSString *)method
                    callBack: (void (^)(id))callBack {
    
    //判断请求方法是GET还是POST
    if ([method isEqualToString:@"GET"]) {
        //调用AFN框架的方法
        [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //如果请求成功，则回调responseObject
            callBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //如果请求失败，控制台打印错误信息
            NSLog(@"%@",error);
        }];
    }
    
    if ([method isEqualToString:@"POST"]) {
        [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}



+ (void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message buttonTitle:(NSString*)btnTitle
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:btnTitle
                                          otherButtonTitles:nil];
    [alert show];
}









@end

