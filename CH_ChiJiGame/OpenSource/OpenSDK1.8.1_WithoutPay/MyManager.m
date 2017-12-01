//
//  MyManager.m
//  zhuawawa
//
//  Created by caishangcai on 2017/11/23.
//  Copyright © 2017年 caishangcai. All rights reserved.
//

#import "MyManager.h"
//#import "MainViewController.h"
#import "AppDelegate.h"
#import "UserInfo.h"
#import "UserHelper.h"
@implementation MyManager
#pragma mark - LifeCycle

/*微信*/
#define K_WX_AppID       @"wxcb29b0e6880c62fa"
#define K_WX_AppSecret   @"badb0ae932cc9549c22480c69111636c"

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static MyManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[MyManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {

    if ([resp isKindOfClass:[SendAuthResp class]]) {
        
        SendAuthResp *res = (SendAuthResp *)resp;
        [self loginSuccessByCode:res.code];
    }
    
    
}


+ (void)sendAuthRequest{
    
    //    //构造SendAuthReq结构体
        SendAuthReq* req =[[SendAuthReq alloc ] init] ;
        req.scope = @"snsapi_userinfo";
        req.state = K_WX_AppID;
        //第三方向微信终端发送一个SendAuthReq消息结构
      BOOL islogin =  [WXApi sendReq:req];
     NSLog(@"islogin:%d",islogin);
}

- (void)loginSuccessByCode:(NSString *)code{
    
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",K_WX_AppID,K_WX_AppSecret,code];
    
//https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code

    
    [HttpUtil AsyncGetRequestWithUrl:url Tag:1 CallBack:self ShowHud:NO];

    
}


///http回调方法
-(void)httpCallBack:(int)tag Response:(NSDictionary *)response
{
    
    
    if(tag == 1){
        
        if(response){
       
            //登录成功
            UserInfo *userInfo = [[UserInfo alloc] init];
            
            userInfo.access_token=[NSString stringWithFormat:@"%@",[response objectForKey:@"access_token"]];
            
            userInfo.expires_in=[NSString stringWithFormat:@"%@",[response objectForKey:@"expires_in"]];
            userInfo.openid=[NSString stringWithFormat:@"%@",[response objectForKey:@"openid"]];
            userInfo.refresh_token=[NSString stringWithFormat:@"%@",[response objectForKey:@"refresh_token"]];
            userInfo.scope=[NSString stringWithFormat:@"%@",[response objectForKey:@"scope"]];
            userInfo.unionid=[NSString stringWithFormat:@"%@",[response objectForKey:@"unionid"]];
            
            [UserHelper saveUserInfo:userInfo];
            
            
            NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=zh_CN",userInfo.access_token,userInfo.openid];
            
            
            
            [HttpUtil AsyncGetRequestWithUrl:url Tag:2 CallBack:self ShowHud:NO];
            
            
            
        }
        
        
    }else if (tag == 2){
        
        
        UserInfo *userInfo = [[UserInfo alloc] init];
        
        userInfo.country=[NSString stringWithFormat:@"%@",[response objectForKey:@"country"]];
        userInfo.headimgurl=[NSString stringWithFormat:@"%@",[response objectForKey:@"headimgurl"]];
        userInfo.language=[NSString stringWithFormat:@"%@",[response objectForKey:@"language"]];
        userInfo.nickname=[NSString stringWithFormat:@"%@",[response objectForKey:@"nickname"]];
        userInfo.privilege=[response objectForKey:@"privilege"];
        userInfo.province=[NSString stringWithFormat:@"%@",[response objectForKey:@"province"]];
        userInfo.sex=[NSString stringWithFormat:@"%@",[response objectForKey:@"sex"]];
        userInfo.openid=[NSString stringWithFormat:@"%@",[response objectForKey:@"openid"]];
        userInfo.unionid=[NSString stringWithFormat:@"%@",[response objectForKey:@"unionid"]];

        [UserHelper saveUserInfo:userInfo];
        
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
//
//        MainViewController *mainVC = [[MainViewController alloc] init];
//
//        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainVC];
//
//        delegate.window.rootViewController = navi;

        
    }

    
    
}

@end
