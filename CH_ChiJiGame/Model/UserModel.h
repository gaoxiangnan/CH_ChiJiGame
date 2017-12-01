//
//  UserModel.h
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/27.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *picurl;
@property (nonatomic, copy) NSString *team;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *is_you;
@property (nonatomic, copy) NSString *is_cai;
@property (nonatomic, copy) NSString *is_person;
@property (nonatomic, copy) NSString *health;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *ctime;


- (instancetype)initWithDic:(NSDictionary *)dic;
@end
