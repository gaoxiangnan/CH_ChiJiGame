//
//  TeamModel.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/27.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "TeamModel.h"
#import "UserModel.h"

@implementation TeamModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        //创建一个可变数组加载soldarray
        NSMutableArray *soldArray = [NSMutableArray array];
        for (NSDictionary *dic in self.userlist) {
            UserModel *model = [[UserModel alloc]initWithDic:dic];
            [soldArray addObject:model];
        }
        self.userlist = soldArray;
    }
    return self;
}
@end
