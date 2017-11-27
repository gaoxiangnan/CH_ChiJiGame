//
//  NSString+Option.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/27.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "NSString+Option.h"

@implementation NSString (Option)
+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
