//
//  UserInfo.h
//  jinzhuantou
//
//  Created by jianfengChen on 15/5/6.
//  Copyright (c) 2015年 陈 剑锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject



//token
@property(nonatomic,strong)NSString *access_token;
//expires_in
@property(nonatomic,strong)NSString *expires_in;
//openid
@property(nonatomic,strong)NSString *openid;
//refresh_token
@property(nonatomic,strong)NSString *refresh_token;
//scope
@property(nonatomic,strong)NSString *scope;
//unionid
@property(nonatomic,strong)NSString *unionid;



//用户信息

//城市
@property(nonatomic,strong)NSString *city;
//国家
@property(nonatomic,strong)NSString *country;
//头像url
@property(nonatomic,strong)NSString *headimgurl;
//语言
@property(nonatomic,strong)NSString *language;
//昵称
@property(nonatomic,strong)NSString *nickname;
//特权
@property(nonatomic,strong)NSArray *privilege;
//省份
@property(nonatomic,strong)NSString *province;
//性别
@property(nonatomic,strong)NSString *sex;
//





@end

