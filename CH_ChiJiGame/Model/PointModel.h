//
//  PointModel.h
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/29.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointModel : NSObject
@property (nonatomic, copy) NSString *point;
@property (nonatomic, copy) NSString *radius;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *lat;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
