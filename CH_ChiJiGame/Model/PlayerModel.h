//
//  PlayerModel.h
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/30.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerModel : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *picurl;

@property (nonatomic, copy) NSString *health;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *lnglat;

@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *lat;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
