//
//  HttpUtil.m
//  jinzhuantou
//
//  Created by jianfengChen on 15/5/20.
//  Copyright (c) 2015年 陈 剑锋. All rights reserved.
//

#import "HttpUtil.h"
#import "UserHelper.h"
#import "NSString+URLEncoding.h"
@implementation HttpUtil

///异步get请求
///Url:地址
///Tag:标签、编号 用于回调方法中区分
///CallBack:回调对象 请求完成后会执行对象的httpCallBack方法
///ShowHud:是否显示出来指示层
+(void)AsyncGetRequestWithUrl:(NSString *)url
                          Tag:(int)tag
                     CallBack:(id<HttpDelegate>) callBack
                      ShowHud:(BOOL)showHud
{
    HttpUtil *httpUtil = [[HttpUtil alloc] init];
    httpUtil.httpType = HttpTypeGet;
    httpUtil.url = url;
    httpUtil.tag = tag;
    httpUtil.delegate = callBack;
    httpUtil.showHud = showHud;
    [httpUtil startRequest];
}


///异步post请求
///Url:地址
///Params:参数 例如:uid=1&sign=xxx
///Tag:标签、编号 用于回调方法中区分
///CallBack:回调对象 请求完成后会执行对象的httpCallBack方法
///ShowHud:是否显示出来指示层
+(void)AsyncPostRequestWithUrl:(NSString *)url
                        Params:(NSString *)params
                           Tag:(int)tag
                      CallBack:(id<HttpDelegate>) callBack
                       ShowHud:(BOOL)showHud
{
    HttpUtil *httpUtil = [[HttpUtil alloc] init];
    httpUtil.httpType = HttpTypePost;
    httpUtil.url = url;
    httpUtil.strParams = params;
    httpUtil.tag = tag;
    httpUtil.delegate = callBack;
    httpUtil.showHud = showHud;
    [httpUtil startRequest];
//    NSLog(@"%@",params);
}

///异步post请求 包含文件
///Url:地址
///Params:参数 每个参数是一个NSDictionary @"key" 为参数名 value 为参数值
///Files:文件数组
///FileNames:文件的 name数组
///Tag:标签、编号 用于回调方法中区分
///CallBack:回调对象 请求完成后会执行对象的httpCallBack方法
///ShowHud:是否显示出来指示层
+(void)AsyncPostFormRequestWithUrl:(NSString *)url
                            Params:(NSArray *)params
                             Files:(NSArray *)Files
                         FileNames:(NSArray *)FileNames
                               Tag:(int)tag
                          CallBack:(id<HttpDelegate>) callBack
                           ShowHud:(BOOL)showHud
{
    HttpUtil *httpUtil = [[HttpUtil alloc] init];
    httpUtil.httpType = HttpTypePostFile;
    httpUtil.url = url;
    httpUtil.arrParams = params;
    httpUtil.Files = Files;
    httpUtil.FileNames = FileNames;
    httpUtil.tag = tag;
    httpUtil.delegate = callBack;
    httpUtil.showHud = showHud;
    [httpUtil startRequest];
}

///开始请求
-(void)startRequest
{
    //如果需要弹出指示层
    if(self.showHud){
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
//        [MMProgressHUD showWithTitle:@"努力加载中" status:@"请稍候"];
    }
    //异步请求
    [self performSelectorInBackground:@selector(request) withObject:nil];
}

-(void)request
{
    NSData *responseData;
    switch (self.httpType) {
        case HttpTypeGet:
        {
            //get请求
            responseData = [HttpUtil getRequestWithUrl:self.url];
            break;
        }
        case HttpTypePost:
        {
            //post请求
            responseData = [HttpUtil postRequestWithUrl:self.url params:self.strParams];
            break;
        }
        case HttpTypePostFile:
        {
            //上传文件请求
            responseData = [HttpUtil postFormRequestWithUrl:self.url postParems:self.arrParams Files:self.Files FileNames:self.FileNames];
        }
        default:
            break;
    }
    NSDictionary *dictionary = nil;
//    NSLog(@"response:%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    if(responseData!=nil){
        NSError *error;
        //解析json
        dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        
    }
    [self performSelectorOnMainThread:@selector(httpCallBack:) withObject:dictionary waitUntilDone:NO];
}

-(void)httpCallBack:(NSDictionary *)response
{
    if(self.showHud){
        //如果请求正常返回(http请求未出错) 并且status为1(执行操作成功)
        if(response && [@"1" compare:[NSString stringWithFormat:@"%@",[response objectForKey:@"status"]]] == NSOrderedSame){
//            [MMProgressHUD dismissWithSuccess:@"Success!"];
            
        }else{
            
            if ([response[@"data"] isKindOfClass:[NSString class]]) {
                if ([response[@"data"] isEqualToString:@"login"]) {//登录失效
//                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"登录失效,请重新登录" leftButtonTitle:nil rightButtonTitle:@"ok"];
//                    [alert show];
                    
                    [UserHelper logout];
                }
            }
            
            NSString *str = [NSString stringWithFormat:@"%@",response[@"msg"]];
            
            if ([str isEqualToString:@"UID错误"] || [str isEqualToString:@"SIGN错误"] || [str isEqualToString:@"TOKEN错误"] || [str isEqualToString:@"TOKEN超时"]) {
                [MMProgressHUD dismissWithError:@"登录信息错误!"];
                [UserHelper logout];

            } else {
                
                [MMProgressHUD dismissWithError:@"Error!"];
            }
            
        }
    }
    //执行回调
    if(self.delegate){
        [self.delegate httpCallBack:self.tag Response:response];
    }
}


+ (NSData *)postFormRequestWithUrl: (NSString *)url
                    postParems: (NSArray *)postParems
                         Files: (NSArray *)Files
                     FileNames: (NSArray *)FileNames
{
    NSString *hyphens = @"--";
    NSString *boundary = @"*****";
    NSString *end = @"\r\n";
    NSMutableData *myRequestData1=[NSMutableData data];
    //遍历数组，添加多张图片
    for (int i = 0; i < Files.count; i ++) {
        NSData* data;
        UIImage *image=[Files objectAtIndex:i];
        //返回为JPEG图像。  压缩比例加大 减轻服务端压力
        data = UIImageJPEGRepresentation(image, 0.1);
        /*
         //判断图片是不是png格式的文件
         if (UIImagePNGRepresentation(image)) {
         //返回为png图像。
         data = UIImagePNGRepresentation(image);
         }else {
         
         }
         */
        //所有字段的拼接都不能缺少，要保证格式正确
        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableString *fileTitle=[[NSMutableString alloc]init];
        //要上传的文件名和key，服务器端用file接收
        [fileTitle appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"",[FileNames objectAtIndex:i],[NSString stringWithFormat:@"image%d.png",i+1]];
        [fileTitle appendString:end];
        [fileTitle appendString:[NSString stringWithFormat:@"Content-Type:application/octet-stream%@",end]];
        [fileTitle appendString:end];
        [myRequestData1 appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:data];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //添加其他参数
    for(int i=0;i<postParems.count;i++)
    {
        NSMutableString *body=[[NSMutableString alloc]init];
        [body appendString:hyphens];
        [body appendString:boundary];
        [body appendString:end];
        //得到当前key
        NSString *key=[[postParems objectAtIndex:i] objectForKey:@"key"];
        //添加字段名称
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"",key];
        [body appendString:end];
        [body appendString:end];
        //添加字段的值
        [body appendFormat:@"%@",[[postParems objectAtIndex:i] objectForKey:@"value"]];
        [body appendString:end];
        [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:20];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (long)[myRequestData1 length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData1];
    //http method
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponese = nil;
    NSError *error = [[NSError alloc]init];
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponese error:&error];
}


+(NSData *)getRequestWithUrl:(NSString *)urlString
{
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    /*
     其中缓存协议是个枚举类型包含：
     NSURLRequestUseProtocolCachePolicy（基础策略）
     NSURLRequestReloadIgnoringLocalCacheData（忽略本地缓存）
     NSURLRequestReturnCacheDataElseLoad（首先使用缓存，如果没有本地缓存，才从原地址下载）
     NSURLRequestReturnCacheDataDontLoad（使用本地缓存，从不下载，如果本地没有缓存，则请求失败，此策略多用于离线操作）
     NSURLRequestReloadIgnoringLocalAndRemoteCacheData（无视任何缓存策略，无论是本地的还是远程的，总是从原地址重新下载）
     NSURLRequestReloadRevalidatingCacheData（如果本地缓存是有效的则不下载，其他任何情况都从原地址重新下载）
     */
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    return received;
}

+(NSData *)postRequestWithUrl:(NSString *)urlString params:(NSString *) params
{
    //第一步，创建URL
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //第二步，创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    //NSString *params = @"type=focus-c";//设置参数
    if(params){
        NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    /*
     NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
     NSLog(@"%@",str1);
     */
    return received;
}
/*
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    
    if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        // 告诉服务器，客户端信任证书
        // 创建凭据对象
        NSURLCredential *credntial = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        // 告诉服务器信任证书
        [challenge.sender useCredential:credntial forAuthenticationChallenge:challenge];
    }
}
*/
@end
