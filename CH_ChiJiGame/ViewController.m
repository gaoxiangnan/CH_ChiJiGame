//
//  ViewController.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/17.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "ViewController.h"
#import "CH_TeamCreatViewController.h"
#import "UIView+SDAutoLayout.h"
#import "AppDelegate.h"
#import "MyManager.h"

@interface ViewController ()<UITextFieldDelegate>
{
    NSInteger seconds;
}
#pragma 背景图
@property(nonatomic,strong)UIImageView *backgroundimg,*backGround;
#pragma 图标
@property(nonatomic,strong)UIImageView *iconimg;
#pragma 注册
@property(nonatomic,strong)UITextField *IDtext,*PassWordtext;

@property(nonatomic,strong)UILabel *IDLabel,*PassWordLabel;
#pragma 注册背景
@property(nonatomic,strong)UIImageView *img,*icodeimg,*buttonimg,*Loginimg;
#pragma 注册按钮
@property(nonatomic,strong)UIButton *icodeBtn,*LoginBtn;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"123123123123123123");
    self.IDtext.delegate = self;
    self.PassWordtext.delegate = self;
    
    [self.view addSubview:self.backgroundimg];
    
    [self.view addSubview:self.backGround];
    
    [self.view addSubview:self.iconimg];
    
    [self.view addSubview:self.img];
    
    
    
    [self.view addSubview:self.icodeimg];
    
    
    
    
    
    
    [self.view addSubview:self.LoginBtn];
    
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRtation = YES;//(以上2行代码,可以理解为打开横屏开关)
    
    [self setNewOrientation:YES];//调用转屏代码
    
    
    [self adaptation];
    
    
}
#pragma 背景图
-(UIImageView *)backgroundimg{
    
    if (self==[super init]) {
        _backgroundimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _backgroundimg.image = [UIImage imageNamed:@"login_background"];
        _backgroundimg.userInteractionEnabled = YES;
    }
    return _backgroundimg;
}
-(UIImageView *)backGround
{
    if (!_backGround) {
        _backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
        _backGround.image = [UIImage imageNamed:@"login_spe1"];
    }
    return _backGround;
}

#pragma 绝地求生图标
-(UIImageView *)iconimg{
    if (self==[super init]) {
        _iconimg = [[UIImageView alloc]init];
        _iconimg.image = [UIImage imageNamed:@"login_logo"];
        
    }
    return _iconimg;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



//#pragma login
//-(UIImageView *)Loginimg{
//    if (!_Loginimg) {
//        _Loginimg = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.height-200)/2, 283, 200, 50)];
//        _Loginimg.image = [UIImage imageNamed:@"login_login"];
//        _Loginimg.userInteractionEnabled = YES;
//    }
//    return _Loginimg;
//}

-(UIButton *)LoginBtn{
    if (!_LoginBtn) {
        _LoginBtn = [[UIButton alloc]init];
        [_LoginBtn setBackgroundImage:[UIImage imageNamed:@"login_login"]  forState:UIControlStateNormal];
        _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:5];
        _LoginBtn.userInteractionEnabled = YES;
        [_LoginBtn addTarget:self action:@selector(LoginBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _LoginBtn;
}

-(void)LoginBtnAction
{
//    if (_IDtext.text.length ==0) {
//        [self creatAlert:@"登录失败，输入手机号"];
//    }else
//    {
////        NSString *string = [NSString stringWithFormat:@"miganchuanmei%@",_IDtext.text];
////
////        [[NSUserDefaults standardUserDefaults] setObject:string forKey:Token];
//
//        [CH_NetWorkManager getWithURLString:@"checkCode" parameters:@{@"token":[NSString md5:[NSString stringWithFormat:@"miganchuanmei%@",_IDtext.text]],@"code":_PassWordtext.text} success:^(NSDictionary *data) {
//            if ([[data objectForKey:@"code"]isEqualToString:@"200"]) {
//
//
//                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"miganchuanmei%@",_IDtext.text] forKey:@"token"];
//
//                //获取当前时间戳
//                NSDate *date = [NSDate date];
//                NSString *string = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
//                NSString *endTimestamp = [NSString stringWithFormat:@"%@",[[data objectForKey:@"data"]objectForKey:@"match_start_time"]];
//
//
//                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//                [formatter setDateStyle:NSDateFormatterMediumStyle];
//                [formatter setTimeStyle:NSDateFormatterShortStyle];
//                [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];//@"yyyy-MM-dd-HHMMss"
//
//                NSDate* beginDate = [NSDate dateWithTimeIntervalSince1970:[string doubleValue]];
//                NSString *dateString = [formatter stringFromDate:beginDate];
//                NSLog(@"开始时间: %@", dateString);
//
//                NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[endTimestamp doubleValue]];
//                NSString *dateString2 = [formatter stringFromDate:endDate];
//                NSLog(@"结束时间: %@", dateString2);
//
//                seconds = [endDate timeIntervalSinceDate:date];
//                NSLog(@"两个时间相隔：%ld", (long)seconds);
//
//                CH_TeamCreatViewController *chVC = [[CH_TeamCreatViewController alloc]init];
//                chVC.piontSecond = seconds;
//                [self.navigationController pushViewController:chVC animated:YES];
//
//                NSLog(@"%@",[data objectForKey:@"message"]);
//                NSLog(@"%@",Token);
//            }else
//            {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[data objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                }];
//                [alert addAction:action];
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//        } failure:^(NSError *error) {
//
//        }];
//    }
    [MyManager sendAuthRequest];
//    CH_TeamCreatViewController *chVC = [[CH_TeamCreatViewController alloc]init];
//    [self.navigationController pushViewController:chVC animated:YES];
    
}
-(void)creatAlert:(NSString *)string{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:string preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
    }];
    
    [alert addAction:ac];
    [self presentViewController:alert animated:YES completion:nil];
    
}



#pragma 旋转屏幕
- (void)setNewOrientation:(BOOL)fullscreen
{
    if (fullscreen) {
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }else{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
    
}

#pragma 适配
-(void)adaptation
{
    _iconimg.sd_layout.leftSpaceToView(self.view, 35).rightSpaceToView(self.view, 35).topSpaceToView(self.view, 20).heightIs(210);
    _LoginBtn.sd_layout.rightSpaceToView(self.view, 200).leftSpaceToView(self.view, 200).topSpaceToView(self.view, 230  ).heightIs(50);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
