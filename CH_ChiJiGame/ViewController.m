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

@interface ViewController ()<UITextFieldDelegate>
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
    
    [self.img addSubview:self.IDLabel];
    
    [self.img addSubview:self.IDtext];
    
    [self.view addSubview:self.icodeimg];
    
    [self.icodeimg addSubview:self.PassWordtext];
    
    [self.icodeimg addSubview:self.PassWordLabel];
    
    [self.view addSubview:self.buttonimg];
    
    [self.buttonimg addSubview:self.icodeBtn];
    
    [self.view addSubview:self.Loginimg];
    
    [self.Loginimg addSubview:self.LoginBtn];
    
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRtation = YES;//(以上2行代码,可以理解为打开横屏开关)
    
    [self setNewOrientation:YES];//调用转屏代码
    
    
    [self adaptation];
    
    
}
#pragma 背景图
-(UIImageView *)backgroundimg{
    
    if (self==[super init]) {
        _backgroundimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
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

-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.height-300)/2, 170, 300, 50)];
        
        _img.image = [UIImage imageNamed:@"login_phonenum"];
        _img.userInteractionEnabled = YES;
    }
    return _img;
}
//手机号Label
-(UILabel *)IDLabel{
    
    if (self==[super init]) {
        _IDLabel = [[UILabel alloc]init];
        _IDLabel.text = @"     手机号 :";
        _IDLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        _IDLabel.textColor = [UIColor colorWithRed:225/225.0f green:190/225.0f blue:34/225.0f alpha:1];
        _IDLabel.userInteractionEnabled = YES;
    }
    return _IDLabel;
}
//手机号
-(UITextField *)IDtext
{
    if (!_IDtext) {
        _IDtext = [[UITextField alloc]init];
        _IDtext.keyboardType = UIKeyboardTypePhonePad;
        //_IDtext.backgroundColor = [UIColor redColor];
        _IDtext.textColor = [UIColor colorWithRed:225/225.0f green:190/225.0f blue:34/225.0f alpha:1];
        _IDtext.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        _IDtext.userInteractionEnabled = YES;
        _IDtext.delegate = self;
        
        //        if (_IDtext.text.length < 10) {
        //            _IDtext.text = [_IDtext.text substringToIndex:10];
        //        }
        
    }
    return _IDtext;
}

//验证码
-(UIImageView *)icodeimg{
    if (!_icodeimg) {
        _icodeimg = [[UIImageView alloc]init];//WithFrame:CGRectMake((self.view.frame.size.height-200)/2, 225, 200, 50)];
        _icodeimg.image = [UIImage imageNamed:@"login_set_auth_code"];
        _icodeimg.userInteractionEnabled = YES;
        
        
    }
    return _icodeimg;
}

-(UITextField *)PassWordtext{
    if (!_PassWordtext) {
        _PassWordtext = [[UITextField alloc]init];
        _PassWordtext.keyboardType = UIKeyboardTypePhonePad;
        _PassWordtext.textColor = [UIColor colorWithRed:225/225.0f green:190/225.0f blue:34/225.0f alpha:1];
        _PassWordtext.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        _PassWordtext.userInteractionEnabled = YES;
    }
    return _PassWordtext;
}
-(UILabel *)PassWordLabel{
    if (!_PassWordLabel) {
        _PassWordLabel = [[UILabel alloc]init];
        _PassWordLabel.text = @"     验证码 :";
        _PassWordLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        _PassWordLabel.textColor = [UIColor colorWithRed:225/225.0f green:190/225.0f blue:34/225.0f alpha:1];
        _PassWordLabel.userInteractionEnabled = YES;
    }
    return _PassWordLabel;
}


//限制textfelid只允许输入数字
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _IDtext) {
        if (range.length + range.location > textField.text.length) {
            return NO;
        }
        NSUInteger length = _IDtext.text.length + string.length - range.length;
        
        
        
        return length <= 11&&[self validateNumber:string];
    }else{
        
    }
    
    return YES;
    
}


//只允许输入数字
- (BOOL)validateNumber:(NSString*)number{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


-(UIImageView *)buttonimg{
    if (!_buttonimg) {
        _buttonimg = [[UIImageView alloc]init];//Frame:CGRectMake((self.view.frame.size.height-100)/2, 225, 100, 50)];
        _buttonimg.image = [UIImage imageNamed:@"login_get_auth_code"];
        _buttonimg.userInteractionEnabled = YES;
    }
    return _buttonimg;
}

-(UIButton *)icodeBtn{
    if (!_icodeBtn) {
        _icodeBtn = [[UIButton alloc]init];
        [_icodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_icodeBtn setTitleColor:[UIColor colorWithRed:225/225.0f green:190/225.0f blue:34/225.0f alpha:1] forState:UIControlStateNormal];
        _icodeBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [_icodeBtn addTarget:self action:@selector(icodeBtnAciton) forControlEvents:UIControlEventTouchUpInside];
        _icodeBtn.userInteractionEnabled = YES;
    }
    return _icodeBtn;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)icodeBtnAciton
{
    NSLog(@"获取验证码");
    
    [CH_NetWorkManager getWithURLString:@"sendPhoneMessage" parameters:@{@"phone":_IDtext.text} success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        NSLog(@"%@",[data objectForKey:@"message"]);
        if ([[data objectForKey:@"code"] isEqualToString:@"200"]) {
            
            __block NSInteger time = 59; //倒计时时间
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            
            dispatch_source_set_event_handler(_timer, ^{
                
                if(time <= 0){ //倒计时结束，关闭
                    
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置按钮的样式
                        [self.icodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                        
                        self.icodeBtn.userInteractionEnabled = YES;
                    });
                    
                }else{
                    
                    int seconds = time % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置按钮显示读秒效果
                        [self.icodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                        
                        self.icodeBtn.userInteractionEnabled = NO;
                    });
                    time--;
                }
            });
            dispatch_resume(_timer);
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[data objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            }];
            
            [alert addAction:ac];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
    
    }];
    
  
}

#pragma login
-(UIImageView *)Loginimg{
    if (!_Loginimg) {
        _Loginimg = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.height-200)/2, 283, 200, 50)];
        _Loginimg.image = [UIImage imageNamed:@"login_login"];
        _Loginimg.userInteractionEnabled = YES;
    }
    return _Loginimg;
}

-(UIButton *)LoginBtn{
    if (!_LoginBtn) {
        _LoginBtn = [[UIButton alloc]init];
        [_LoginBtn setTitle:@"登  陆" forState:UIControlStateNormal];
        [_LoginBtn setTitleColor:[UIColor colorWithRed:225/225.0f green:190/225.0f blue:34/225.0f alpha:1] forState:UIControlStateNormal];
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
//        NSString *string = [NSString stringWithFormat:@"miganchuanmei%@",_IDtext.text];
//        [CH_NetWorkManager getWithURLString:@"checkCode" parameters:@{@"token":[NSString md5:string],@"code":_PassWordtext.text} success:^(NSDictionary *data) {
//            if ([[data objectForKey:@"code"]isEqualToString:@"200"]) {
//                CH_TeamCreatViewController *chVC = [[CH_TeamCreatViewController alloc]init];
//                [self.navigationController pushViewController:chVC animated:YES];
//                NSLog(@"%@",[data objectForKey:@"message"]);
//                NSLog(@"%@",data);
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
//    
    CH_TeamCreatViewController *chVC = [[CH_TeamCreatViewController alloc]init];
    [self.navigationController pushViewController:chVC animated:YES];
    
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
    
    _IDtext.sd_layout.rightEqualToView(_img).topSpaceToView(_img,0).heightIs(50).widthIs(220);
    
    _IDLabel.sd_layout.leftEqualToView(_img).topSpaceToView(_img, 0).heightIs(50).widthIs(100);
    
    _icodeimg.sd_layout.leftEqualToView(_img).topSpaceToView(self.view, 227).heightIs(50).widthIs(200);
    
    _PassWordtext.sd_layout.rightEqualToView(_icodeimg).topEqualToView(_icodeimg).heightIs(50).widthIs(120);
    
    _PassWordLabel.sd_layout.leftEqualToView(_icodeimg).topEqualToView(_icodeimg).heightIs(50).widthIs(100);
    
    _buttonimg.sd_layout.rightEqualToView(_img).topEqualToView(_icodeimg).heightIs(50).widthIs(100);
    
    _icodeBtn.sd_layout.rightEqualToView(_buttonimg).topEqualToView(_buttonimg).heightIs(50).widthIs(100);
    
    _LoginBtn.sd_layout.rightEqualToView(_Loginimg).topEqualToView(_Loginimg).heightIs(50).widthIs(200);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
