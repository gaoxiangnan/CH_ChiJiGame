//
//  MyManager.h
//  zhuawawa
//
//  Created by caishangcai on 2017/11/23.
//  Copyright © 2017年 caishangcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "HttpUtil.h"
@interface MyManager : NSObject<WXApiDelegate,HttpDelegate>

+ (instancetype)sharedManager;

+ (void)sendAuthRequest;

@end
