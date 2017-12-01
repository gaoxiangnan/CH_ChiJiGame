//
//  UserHelper.m
//  jinzhuantou
//
//  Created by jianfengChen on 15/5/6.
//  Copyright (c) 2015年 陈 剑锋. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper

+(BOOL)isLogin
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString *openid = [settings objectForKey:@"openid"];
    if(openid){
        return YES;
    }else{
       return NO;
    }
}

+ (UserInfo *)getUserInfo
{
    UserInfo *userInfo = [[UserInfo alloc] init];
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    userInfo.access_token = [settings objectForKey:@"access_token"];
    userInfo.expires_in = [settings objectForKey:@"expires_in"];
    userInfo.openid=[settings objectForKey:@"openid"];
    
    
    userInfo.refresh_token = [settings objectForKey:@"refresh_token"];
    userInfo.scope = [settings objectForKey:@"scope"];
    userInfo.unionid = [settings objectForKey:@"unionid"];
    
    
    userInfo.city = [settings objectForKey:@"city"];
    userInfo.country = [settings objectForKey:@"country"];
    userInfo.headimgurl = [settings objectForKey:@"headimgurl"];
    
    userInfo.language = [settings objectForKey:@"language"];
    userInfo.nickname = [settings objectForKey:@"nickname"];
    userInfo.privilege = [settings objectForKey:@"privilege"];
    
    userInfo.province = [settings objectForKey:@"province"];
    userInfo.sex = [settings objectForKey:@"sex"];

    return userInfo;
}

+(void)saveUserInfo:(UserInfo *)userInfo
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    
    [settings setObject:userInfo.access_token forKey:@"access_token"];
    
    [settings setObject:userInfo.expires_in forKey:@"expires_in"];
    
    [settings setObject:userInfo.openid forKey:@"openid"];
    
    
    [settings setObject:userInfo.refresh_token forKey:@"refresh_token"];
    
    [settings setObject:userInfo.scope forKey:@"scope"];
    
    [settings setObject:userInfo.unionid forKey:@"unionid"];
    
    
    [settings setObject:userInfo.city forKey:@"city"];
    
    [settings setObject:userInfo.country forKey:@"country"];
    
    [settings setObject:userInfo.headimgurl forKey:@"headimgurl"];
    
    [settings setObject:userInfo.language forKey:@"language"];
    
    [settings setObject:userInfo.nickname forKey:@"nickname"];
    
    [settings setObject:userInfo.privilege forKey:@"privilege"];
    
    [settings setObject:userInfo.province forKey:@"province"];
    
    [settings setObject:userInfo.sex forKey:@"sex"];

    
    [settings synchronize];
    
    NSLog(@"%@",settings);
}

+(void)logout
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"access_token"];
    [settings removeObjectForKey:@"expires_in"];
    [settings removeObjectForKey:@"openid"];
    [settings removeObjectForKey:@"refresh_token"];
    [settings removeObjectForKey:@"scope"];
    [settings removeObjectForKey:@"unionid"];
    
    
    [settings removeObjectForKey:@"city"];
    [settings removeObjectForKey:@"country"];
    [settings removeObjectForKey:@"headimgurl"];
    [settings removeObjectForKey:@"language"];
    [settings removeObjectForKey:@"nickname"];
    [settings removeObjectForKey:@"privilege"];
    [settings removeObjectForKey:@"province"];
    [settings removeObjectForKey:@"sex"];
    
//    DELETEPHONE;//删除保存的手机号
    [settings synchronize];
}

/////获取手势密码
//+(NSString *)getGesturePw
//{
//    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
//    return [settings objectForKey:@"gesturepw"];//@"12365";//
//}

/////设置手势密码
//+(void)setGesturePw:(NSString *)pw
//{
//    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
//    [settings setObject:pw forKey:@"gesturepw"];
//    [settings synchronize];
//}

/////清除手势密码
//+(void)removeGesturePw
//{
//    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
//    [settings removeObjectForKey:@"gesturepw"];
//    [settings synchronize];
//}
/*
///存储
+(void)setUserDefault:(NSString *) key value:(NSString *) val
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings setObject:val forKey:key];
    [settings synchronize];
}

///读取
+(NSString *)getUserDefault:(NSString *) key
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString *value = [settings objectForKey:key];
    
    return value;
}
*/
@end
