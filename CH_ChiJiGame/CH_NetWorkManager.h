//
//  CH_NetWorkManager.h
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/27.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CH_NetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)requestWithURLString: (NSString *)URLString
                  parameters: (NSDictionary *)parameters
                      method: (NSString *)method
                    callBack: (void (^)(id))callBack;






@end
