//
//  CH_MemberMessView.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/22.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "CH_MemberMessView.h"
@interface CH_MemberMessView()
@property (nonatomic, strong) UIImageView *headerBgImgV;
@property (nonatomic, strong) UIButton *headerImgBtn;
@property (nonatomic, strong) UILabel *memberNameLb;
@property (nonatomic, strong) UILabel *teamNameLb;
@property (nonatomic, strong) UILabel *timeCountDownLb;
@property (nonatomic, strong) UILabel *livesNumLb;
@property (nonatomic, strong) UILabel *bloodNumLb;
@end
@implementation CH_MemberMessView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        [self updateViews];
    }
    return self;
}
- (void)updateViews
{
    [self addSubview:self.headerBgImgV];
    [_headerBgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(5);
    }];
    
    [self addSubview:self.headerImgBtn];
    [_headerImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_headerBgImgV);
        make.width.height.mas_equalTo(_headerBgImgV).mas_offset(-2);
    }];
    
    [self addSubview:self.memberNameLb];
    [_memberNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headerBgImgV.mas_right).mas_offset(10);
        make.top.mas_equalTo(_headerBgImgV).mas_offset(3);
        
    }];
    
    [self addSubview:self.teamNameLb];
    [_teamNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_memberNameLb);
        make.top.mas_equalTo(_memberNameLb.mas_bottom).offset(10);
    }];
    
    [self addSubview:self.timeCountDownLb];
    [_timeCountDownLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).mas_offset(50);
        make.top.mas_equalTo(self).mas_offset(20);
    }];
    
    [self addSubview:self.livesNumLb];
    [_livesNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_timeCountDownLb.mas_right).mas_offset(10);
        make.top.mas_equalTo(_timeCountDownLb);
    }];
    
    [self addSubview:self.bloodNumLb];
    [_bloodNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_timeCountDownLb);
        make.top.mas_equalTo(_timeCountDownLb.mas_bottom).offset(10);
    }];
}
- (UIImageView *)headerBgImgV
{
    if (!_headerBgImgV) {
        _headerBgImgV = [UIImageView new];
        _headerBgImgV.image = [UIImage imageNamed:@"ch_header_bg"];
    }
    return _headerBgImgV;
}
- (UIButton *)headerImgBtn
{
    if (!_headerImgBtn) {
        _headerImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headerImgBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _headerImgBtn;
}
- (UILabel *)memberNameLb
{
    if (!_memberNameLb) {
        _memberNameLb = [UILabel new];
        _memberNameLb.text = @"猎鹰007";
        _memberNameLb.textColor = [UIColor whiteColor];
        _memberNameLb.textAlignment = NSTextAlignmentLeft;
        _memberNameLb.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    }
    return _memberNameLb;
}
- (UILabel *)teamNameLb
{
    if (!_teamNameLb) {
        _teamNameLb = [UILabel new];
        _teamNameLb.text = @"猎鹰突击小分队";
        _teamNameLb.textColor = [UIColor yellowColor];
        _teamNameLb.textAlignment = NSTextAlignmentLeft;
        _teamNameLb.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    }
    return _teamNameLb;
}
- (UILabel *)timeCountDownLb
{
    if (!_timeCountDownLb) {
        _timeCountDownLb = [UILabel new];
        _timeCountDownLb.text = @"倒计时：05:00";
        _timeCountDownLb.textColor = [UIColor yellowColor];
        _timeCountDownLb.textAlignment = NSTextAlignmentLeft;
        _timeCountDownLb.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    }
    return _timeCountDownLb;
}
- (UILabel *)livesNumLb
{
    if (!_livesNumLb) {
        _livesNumLb = [UILabel new];
//        _livesNumLb.text = @"场内存活：59";
        _livesNumLb.textColor = [UIColor yellowColor];
        _livesNumLb.textAlignment = NSTextAlignmentLeft;
//        _livesNumLb.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        
        NSString *livesNumStr = @"场内存活：59";
        
        NSMutableAttributedString *attrS = [[NSMutableAttributedString alloc]initWithString:livesNumStr];
        [attrS addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightSemibold] range:NSMakeRange(5, 2)];
        [attrS addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold] range:NSMakeRange(0, 4)];
        _livesNumLb.attributedText = attrS;
    }
    return _livesNumLb;
}
- (UILabel *)bloodNumLb
{
    if (!_bloodNumLb) {
        _bloodNumLb = [UILabel new];
        _bloodNumLb.text = @"场内存活：59";
        _bloodNumLb.textColor = [UIColor yellowColor];
        _bloodNumLb.textAlignment = NSTextAlignmentLeft;
        _bloodNumLb.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    }
    return _bloodNumLb;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
