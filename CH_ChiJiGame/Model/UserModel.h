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


- (instancetype)initWithDic:(NSDictionary *)dic;
@end
