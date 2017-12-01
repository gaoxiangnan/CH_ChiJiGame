//
//  UserHelper.h
//  jinzhuantou
//
//  Created by jianfengChen on 15/5/6.
//  Copyright (c) 2015年 陈 剑锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserHelper : NSObject
///判断是否登录
+(BOOL)isLogin;
///获取用户信息 uid、token
+(UserInfo *)getUserInfo;
///保存用户信息 uid、token
+(void)saveUserInfo:(UserInfo *)userInfo;
///退出登录
+(void)logout;
/////获取手势密码
//+(NSString *)getGesturePw;
/////设置手势密码
//+(void)setGesturePw:(NSString *)pw;
/////清除手势密码
//+(void)removeGesturePw;

@end
