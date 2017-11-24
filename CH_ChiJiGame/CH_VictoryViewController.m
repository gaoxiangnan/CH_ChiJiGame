//
//  CH_VictoryViewController.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/23.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "CH_VictoryViewController.h"

@interface CH_VictoryViewController ()
@property(nonatomic,strong)UIImageView *BackImg;
@property(nonatomic,strong)UIImageView  *VicBack;
@property(nonatomic,strong)UILabel *VicLabel,*NameLabel;
@property(nonatomic,strong)UIButton *btnF,*btn;
@property(nonatomic,strong)UIButton *HeadBtn;
@property(nonatomic,strong)UILabel *NameL,*TeamName;
@property(nonatomic,strong)UILabel *BlodLabel,*shareLabel;
@property(nonatomic,strong)UIImageView *Blodimg,*shareimg,*shareHeadImg;
@property(nonatomic,strong)UIView *Blodvww;
@property(nonatomic,strong)UIButton *sharebtn;
@property(nonatomic,strong)UIControl *ShareControl;
@property(nonatomic,strong)UIButton *WEIXINBtn,*PYQBtn,*QQBtn,*WEIBOBtn;
@property(nonatomic,strong)UILabel *WEIXINL,*PYQL,*QQL,*WEIBOL;
@property(nonatomic,strong)UIView  *vww;
@end

@implementation CH_VictoryViewController

-(UIImageView *)BackImg
{
    
    if (!_BackImg) {
        _BackImg = [[UIImageView alloc]initWithFrame:self.view.frame];
        _BackImg.image = [UIImage imageNamed:@"join_team_background"];
    }
    return _BackImg;
}

-(UIImageView *)VicBack
{
    if (!_VicBack) {
        _VicBack = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"组 5@1x"]];
    }
    return _VicBack;
}

-(UILabel *)VicLabel
{
    if (!_VicLabel) {
        _VicLabel = [[UILabel alloc]init];
        _VicLabel.text = @"胜利团队";
        _VicLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:16.0f];
        _VicLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _VicLabel.textAlignment = NSTextAlignmentCenter;
        _VicLabel.textColor = [UIColor colorWithRed:215/225.0f green:193/225.0f blue:105/225.0f alpha:.8f];
    }
    return _VicLabel;
}

-(UIButton *)btnF
{
    if (!_btnF) {
        _btnF = [[UIButton alloc]init];
        [_btnF setImage:[UIImage imageNamed:@"head_paint"] forState:UIControlStateNormal];
        
    }
    return _btnF;
}

-(UIButton *)HeadBtn
{
    if (!_HeadBtn) {
        _HeadBtn = [[UIButton alloc]init];
        [_HeadBtn setImage:[UIImage imageNamed:@"hander_gold"] forState:UIControlStateNormal];
    }
    return _HeadBtn;
}

-(UILabel *)NameL
{
    if (!_NameL) {
        _NameL = [[UILabel alloc]init];
        _NameL.text = @"猎鹰007";
        _NameL.textColor = [UIColor whiteColor];
        _NameL.font = [UIFont boldSystemFontOfSize:20.0f];
    }
    return _NameL;
}

-(UILabel *)TeamName
{
    if (!_TeamName) {
        _TeamName  = [[UILabel alloc]init];
        _TeamName.text = @"猎鹰小分队";
        _TeamName.font = [UIFont boldSystemFontOfSize:20.0f];
        _TeamName.textColor = [UIColor colorWithRed:214/225.0f  green:193/225.0f blue:99/25.0f alpha:1];
    }
    return _TeamName;
}

-(UILabel *)BlodLabel
{
    if (!_BlodLabel) {
        _BlodLabel  = [[UILabel alloc]init];
        _BlodLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        _BlodLabel.text = @"血量   50/100";
        _BlodLabel.textColor = [UIColor colorWithRed:214/225.0f  green:193/225.0f blue:99/25.0f alpha:1];
    }
    return _BlodLabel;
}

-(UIImageView *)Blodimg
{
    if (!_Blodimg) {
        _Blodimg = [[UIImageView alloc]init];
        _Blodimg.image = [UIImage imageNamed:@"boole_donthave"];
    }
    return _Blodimg;
}

-(UIView *)Blodvww
{
    if (!_Blodvww) {
        _Blodvww = [[UIView alloc]init];
        _Blodvww.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"boole_have"]];
    }
    return _Blodvww;
}

-(UIButton *)sharebtn
{
    if (!_sharebtn) {
        _sharebtn = [[UIButton alloc]init];
        [_sharebtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        [_sharebtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _sharebtn;
}
-(UIControl *)ShareControl
{
    if (!_ShareControl) {
        _ShareControl = [[UIControl alloc]initWithFrame:self.view.frame];
        _ShareControl.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        //_ShareControl.userInteractionEnabled = NO;
        [_ShareControl addTarget:self action:@selector(ShareControlAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ShareControl;
}
-(void)ShareControlAction
{
    //移除
    [self.ShareControl removeFromSuperview];
    
}
//微信
-(UIButton *)WEIXINBtn
{
    if (!_WEIXINBtn) {
        _WEIXINBtn = [[UIButton alloc]init];
        [_WEIXINBtn setImage:[UIImage imageNamed:@"weuixin"] forState:UIControlStateNormal];
        _WEIBOBtn.userInteractionEnabled = YES;
        [_WEIXINBtn addTarget:self action:@selector(WEIXINACTION) forControlEvents:UIControlEventTouchUpInside];
    }
    return _WEIXINBtn;
}

-(void)WEIXINACTION
{
    NSLog(@"weixin");
    
}
-(UILabel *)WEIXINL
{
    if (!_WEIXINL) {
        _WEIXINL = [[UILabel alloc]init];
        _WEIXINL.text = @"微信";
        _WEIXINL.font = [UIFont boldSystemFontOfSize:20.0f];
        _WEIXINL.textColor = [UIColor colorWithRed:229/225.0f green:182/225.0f blue:103/225.0f alpha:0.8f];
    }
    return _WEIXINL;
}
//朋友圈
-(UIButton *)PYQBtn
{
    if (!_PYQBtn) {
        _PYQBtn = [[UIButton alloc]init];
        [_PYQBtn setImage:[UIImage imageNamed:@"pengyouquan"] forState:UIControlStateNormal];
        [_PYQBtn addTarget:self action:@selector(PYQACTION) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PYQBtn;
}
-(void)PYQACTION
{
    NSLog(@"pengyouquan");
}
-(UILabel *)PYQL
{
    if (!_PYQL) {
        _PYQL = [[UILabel alloc]init];
        _PYQL.text = @"朋友圈";
        _PYQL.font = [UIFont boldSystemFontOfSize:20.0f];
        _PYQL.textColor = [UIColor colorWithRed:229/225.0f green:182/225.0f blue:103/225.0f alpha:0.8f];
    }
    return _PYQL;
}
//QQ
-(UIButton *)QQBtn
{
    if (!_QQBtn) {
        _QQBtn = [[UIButton alloc]init];
        [_QQBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [_QQBtn addTarget:self action:@selector(QQACTION) forControlEvents:UIControlEventTouchUpInside];
    }
    return _QQBtn;
}
-(void)QQACTION
{
    NSLog(@"QQ");
}
-(UILabel *)QQL
{
    if (!_QQL) {
        _QQL = [[UILabel alloc]init];
        _QQL.text = @"QQ";
        _QQL.font = [UIFont boldSystemFontOfSize:20.0f];
        _QQL.textColor = [UIColor colorWithRed:229/225.0f green:182/225.0f blue:103/225.0f alpha:0.8f];
    }
    return _QQL;
}
//微博
-(UIButton *)WEIBOBtn
{
    if (!_WEIBOBtn) {
        _WEIBOBtn = [[UIButton alloc]init];
        [_WEIBOBtn setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
        [_WEIBOBtn addTarget:self action:@selector(WEIBOACTION) forControlEvents:UIControlEventTouchUpInside];
    }
    return _WEIBOBtn;
}
-(void)WEIBOACTION
{
    NSLog(@"weibo");
}
-(UILabel *)WEIBOL
{
    if (!_WEIBOL) {
        _WEIBOL = [[UILabel alloc]init];
        _WEIBOL.text = @"微博";
        _WEIBOL.font = [UIFont boldSystemFontOfSize:20.0f];
        _WEIBOL.textColor = [UIColor colorWithRed:229/225.0f green:182/225.0f blue:103/225.0f alpha:0.8f];
    }
    return _WEIBOL;
}
-(UIView *)vww
{
    if (!_vww) {
        _vww = [[UIView alloc]init];
        //        _vww.userInteractionEnabled = NO;
        // _vww.backgroundColor = [UIColor redColor];
    }
    return _vww;
}
//分享背景
-(UIImageView *)shareimg
{
    if (!_shareimg) {
        _shareimg = [[UIImageView alloc]init];
        _shareimg.image = [UIImage imageNamed:@"beijing"];
        _shareimg.userInteractionEnabled= NO;
    }
    return _shareimg;
}
//分享背景Head
-(UIImageView *)shareHeadImg
{
    if (!_shareHeadImg) {
        _shareHeadImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tiexiu"]];
    }
    return _shareHeadImg;
}

-(void)shareBtnAction
{
    [self.view addSubview:self.ShareControl];
    
    
    NSLog(@"分享");
}
-(UILabel *)shareLabel
{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.text = @"分  享";
        _shareLabel.textAlignment = NSTextAlignmentCenter;
        _shareLabel.textColor = [UIColor whiteColor];
        _shareLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    }
    return _shareLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 10; i++)
    {
        int a = i/5;   //取余
        int b = i%5;   //取整
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(60+(40+(kWindowW-500)/5)*b, 50+(50+20)*a, 60, 60)];
        _btn.tag = i;
        [_btn setImage:[UIImage imageNamed:@"head_paint"] forState:UIControlStateNormal];
        [self.VicBack addSubview:_btn];
        _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50+(40+(kWindowW-500)/5)*b, 106+(53+20)*a, (kWindowW-310)/5, 13)];
        _NameLabel.text = @"中国人民广播电台";
        _NameLabel.adjustsFontSizeToFitWidth = YES;
        _NameLabel.textColor = [UIColor colorWithRed:229/225.0f green:182/225.0f blue:103/225.0f alpha:0.8f];
        //_NameLabel.backgroundColor = [UIColor whiteColor];
        [self.VicBack addSubview:_NameLabel];
        
    }
    
    
    [self.view addSubview:self.BackImg];
    [self.view addSubview:self.VicBack];
    [self.VicBack addSubview:self.VicLabel];
    [self.view addSubview:self.HeadBtn];
    [self.view addSubview:self.NameL];
    [self.view addSubview:self.TeamName];
    [self.view addSubview:self.BlodLabel];
    [self.view addSubview:self.Blodimg];
    [self.view addSubview:self.Blodvww];
    [self.view addSubview:self.sharebtn];
    
    
    [self.ShareControl addSubview:self.vww];
    
    [self.vww addSubview:self.shareimg];
    
    [self.vww addSubview:self.shareHeadImg];
    
    [self.shareHeadImg addSubview:self.shareLabel];
    
    [self.vww addSubview:self.WEIXINBtn];
    [self.vww addSubview:self.PYQBtn];
    [self.vww addSubview:self.QQBtn];
    [self.vww addSubview:self.WEIBOBtn];
    [self.vww addSubview:self.WEIXINL];
    [self.vww addSubview:self.PYQL];
    [self.vww addSubview:self.QQL];
    [self.vww addSubview:self.WEIBOL];
    
    
    
    [self adap];
}

-(void)adap
{
    _VicBack.sd_layout.topSpaceToView(self.view, 110).leftSpaceToView(self.view, 100).rightSpaceToView(self.view, 100).bottomSpaceToView(self.view, 30);
    _VicLabel.sd_layout.topSpaceToView(_VicBack, 8).leftSpaceToView(_VicBack, 100).rightSpaceToView(_VicBack, 100).heightIs(40);
    _HeadBtn.sd_layout.topSpaceToView(self.view, 30).leftSpaceToView(self.view, 100).widthIs(80).heightIs(80);
    _NameL.sd_layout.topSpaceToView(self.view, 33).leftSpaceToView(self.view, 180).widthIs(150).heightIs(50);
    _TeamName.sd_layout.topSpaceToView(self.view, 57).leftSpaceToView(self.view, 180).widthIs(200).heightIs(50);
    _BlodLabel.sd_layout.topSpaceToView(self.view, 58).leftSpaceToView(self.view, 500).widthIs(130).heightIs(10);
    _Blodimg.sd_layout.topSpaceToView(self.view, 77).rightSpaceToView(self.view, 100).widthIs(130).heightIs(15);
    _Blodvww.sd_layout.topEqualToView(_Blodimg).rightEqualToView(_Blodimg).widthIs(65).heightIs(15);
    _sharebtn.sd_layout.topSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).heightIs(50).widthIs(60);
    _vww.sd_layout.topSpaceToView(_ShareControl, 80).leftSpaceToView(_ShareControl, 130).rightSpaceToView(_ShareControl, 130).bottomSpaceToView(_ShareControl, 60);
    
    _shareimg.sd_layout.topSpaceToView(_vww, 0).leftSpaceToView(_vww, 0).rightSpaceToView(_vww  , 0).bottomSpaceToView(_vww, 0);
    // _shareimg.sd_layout.topEqualToView(_vww).leftEqualToView(_vww).rightEqualToView(_vww).rightEqualToView(_vww);
    
    _shareHeadImg.sd_layout.topSpaceToView(_vww, 5).leftSpaceToView(_vww, 5).rightSpaceToView(_vww, 5).heightIs(80);
    
    _shareLabel.sd_layout.topSpaceToView(_shareHeadImg, 0).leftSpaceToView(_shareHeadImg, 0).rightSpaceToView(_shareHeadImg, 0).bottomSpaceToView(_shareHeadImg, 0);
    
    
    
    
    _WEIXINBtn.sd_layout.topSpaceToView(_vww, 115).heightIs(50).leftSpaceToView(_vww, 40).widthIs(50);
    
    _PYQBtn.sd_layout.topEqualToView(_WEIXINBtn).heightIs(50).leftSpaceToView(_WEIXINBtn,40).widthIs(50);
    
    _QQBtn.sd_layout.topEqualToView(_WEIXINBtn).heightIs(50).leftSpaceToView(_PYQBtn, 40).widthIs(50);
    
    _WEIBOBtn.sd_layout.topEqualToView(_WEIXINBtn).heightIs(50).leftSpaceToView(_QQBtn, 40).widthIs(50);
    
    
    
    
    //
    
    _WEIXINL.sd_layout.topSpaceToView(_vww, 115+50+14).leftEqualToView(_WEIXINBtn).heightIs(50).widthIs(50);
    _PYQL.sd_layout.topEqualToView(_WEIXINL).leftEqualToView(_PYQBtn).heightIs(50).widthIs(80);
    _QQL.sd_layout.topEqualToView(_WEIXINL).rightSpaceToView(_WEIBOL, 40).heightIs(50).widthIs(50);
    _WEIBOL.sd_layout.topEqualToView(_WEIXINL).rightSpaceToView(_vww, 40).heightIs(50).widthIs(50);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
