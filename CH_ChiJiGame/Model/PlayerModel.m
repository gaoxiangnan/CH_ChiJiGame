//
//  PlayerModel.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/30.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        NSArray *lnglat = [self.lnglat componentsSeparatedByString:@","];
        self.lng = [lnglat firstObject];
        self.lat = [lnglat lastObject];
    }
    return self;
}
@end
