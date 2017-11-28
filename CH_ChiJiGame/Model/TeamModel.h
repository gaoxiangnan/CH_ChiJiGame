//
//  TeamModel.h
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/27.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface TeamModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSArray *userlist;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
