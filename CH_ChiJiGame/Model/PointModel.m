//
//  PointModel.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/29.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "PointModel.h"

@implementation PointModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        NSArray *lnglat = [self.point componentsSeparatedByString:@","];
        self.lng = [lnglat firstObject];
        self.lat = [lnglat lastObject];
    }
    return self;
}
@end
