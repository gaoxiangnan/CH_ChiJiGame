//
//  CH_TeamMesView.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/22.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "CH_TeamMesView.h"
@interface CH_TeamMesView()
@property (nonatomic, strong) UIImageView *bgImgV;
@property (nonatomic, strong) UIImageView *numImgV;
@property (nonatomic, strong) UILabel *teamNameLb;
@property (nonatomic, strong) UIView *memberView;
@property (nonatomic, strong) UIButton *sleuthBtn;//侦查
@end
@implementation CH_TeamMesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateViews];
    }
    return self;
}
- (void)updateViews
{
    [self addSubview:self.bgImgV];
    [_bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.mas_equalTo(self);
    }];
    
    [self addSubview:self.numImgV];
    [_numImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(20);
        make.top.mas_equalTo(self).mas_offset(10);
    }];
    
    [self addSubview:self.teamNameLb];
    [_teamNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_numImgV.mas_right).mas_equalTo(20);
        make.top.mas_equalTo(self).offset(8);
    }];
    
    [self addSubview:self.sleuthBtn];
    UIImage *btnImg = [UIImage imageNamed:@"ch_teamView_sleuth_btn"];
    [_sleuthBtn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [_sleuthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(btnImg.size.width);
        make.height.mas_equalTo(btnImg.size.height);
        
    }];
    
    [self addSubview:self.memberView];
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_teamNameLb);
        make.top.mas_equalTo(_teamNameLb.mas_bottom).offset(2);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.right.mas_equalTo(_sleuthBtn.mas_left).mas_offset(-10);
    }];
    
}
- (UIImageView *)bgImgV
{
    if (!_bgImgV) {
        _bgImgV = [UIImageView new];
        _bgImgV.image = [UIImage imageNamed:@"ch_teamView_bg_img"];
    }
    return _bgImgV;
}
- (UIImageView *)numImgV
{
    if (!_numImgV) {
        _numImgV = [UIImageView new];
        _numImgV.image = [UIImage imageNamed:@"ch_img_1"];
    }
    return _numImgV;
}
- (UIButton *)sleuthBtn
{
    if (!_sleuthBtn) {
        _sleuthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sleuthBtn addTarget:self action:@selector(onSleuthClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sleuthBtn;
}
- (UILabel *)teamNameLb
{
    if (!_teamNameLb) {
        _teamNameLb = [UILabel new];
        _teamNameLb.text = @"猎鹰突击小队";
        _teamNameLb.textColor = [UIColor yellowColor];
        _teamNameLb.textAlignment = NSTextAlignmentLeft;
        _teamNameLb.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    }
    return _teamNameLb;
}
- (UIView *)memberView
{
    if (!_memberView) {
        _memberView = [UIView new];
        _memberView.backgroundColor = [UIColor clearColor];
        UIImage *img = [UIImage imageNamed:@"Image-1"];
        UIImage *placeImg = [UIImage imageNamed:@"ch_teamView_memberClose_img"];
        NSLog(@"%f",(kWindowW));
        for (int i = 0; i < 10; i++) {
            UIButton *memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [memberBtn setBackgroundImage:img forState:UIControlStateNormal];
            memberBtn.frame = CGRectMake(0+i*(img.size.width+(5*kWindowW/667)), (7*kWindowH/375), img.size.width, img.size.height);
            [_memberView addSubview:memberBtn];
            
            UIImageView *placeImgV = [[UIImageView alloc]init];
            placeImgV.frame = CGRectMake(0+i*(img.size.width+(5*kWindowW/667)), 0, img.size.width, placeImg.size.height);
            placeImgV.image = placeImg;
            [_memberView addSubview:placeImgV];
            
            
        }
    }
    return _memberView;
}
- (void)onSleuthClick
{
    if (_sleuthBlock) {
        _sleuthBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
