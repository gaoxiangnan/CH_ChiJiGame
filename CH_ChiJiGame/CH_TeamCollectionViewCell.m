//
//  CH_TeamCollectionViewCell.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/20.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "CH_TeamCollectionViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "UserModel.h"

@interface CH_TeamCollectionViewCell()
@property (nonatomic, strong) UIImageView * imgBgV;
@property(nonatomic,strong)UIImageView *imgNumV;

@property (nonatomic, strong) UILabel *teamTitleLb;
@property (nonatomic, strong) UIButton *teamCreateBtn;
@property (nonatomic, strong) UIView *memberViewBg;

@property (nonatomic, strong) UIButton *teamAddBtn;


@property (nonatomic, strong) NSArray *teamArr;

@end
@implementation CH_TeamCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgBgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 240, 220)];
        _imgBgV.image = [UIImage imageNamed:@"ch_team_bg"];
        [self addSubview:_imgBgV];
        
        CGFloat hei = 70.0;
        UIImage *img = [UIImage imageNamed:@"ch_img_1"];
        _imgNumV = [[UIImageView alloc]init];
        _imgNumV.image = img;
        [self addSubview:self.imgNumV];
        [_imgNumV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(img.size.height/hei*img.size.width);
            make.height.mas_equalTo(hei);
        }];
        
        
    }
    return self;
}
- (void)lastCellViewUpdata
{
    _teamAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImg = [UIImage imageNamed:@"ch_teamAdd_btn"];
    [_teamAddBtn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [_teamAddBtn addTarget:self action:@selector(onTeamAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_teamAddBtn];
    [_teamAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_imgBgV);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *teamCreatLb = [[UILabel alloc]init];
    teamCreatLb.text = @"创建组队";
    teamCreatLb.textColor = [UIColor yellowColor];
    teamCreatLb.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    teamCreatLb.textAlignment = NSTextAlignmentLeft;
    [self addSubview:teamCreatLb];
    [teamCreatLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_teamAddBtn);
        make.top.mas_equalTo(_teamAddBtn.mas_bottom).mas_offset(10);
    }];
    
    
}
- (void)translateData:(TeamModel *)teamModel changeCellOutView:(BOOL)last
{
    if (last == YES) {
        [self lastCellViewUpdata];
    }else{
        [self createTeamPlaceHoldView:teamModel];
    }
}
- (void)createTeamPlaceHoldView:(TeamModel *)teamModel
{
    NSLog(@"teamModel.team_user is %@",teamModel.userlist);
    
    _teamArr = teamModel.userlist;
    
    
    _teamTitleLb = [[UILabel alloc]init];
    _teamTitleLb.text = teamModel.name;
    _teamTitleLb.textColor = [UIColor yellowColor];
    _teamTitleLb.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    _teamTitleLb.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_teamTitleLb];
    [_teamTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imgNumV.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(_imgNumV.mas_bottom);
    }];
    
    _teamCreateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImg = [UIImage imageNamed:@"ch_teamJoinBtn"];
    [_teamCreateBtn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [_teamCreateBtn addTarget:self action:@selector(onCreateTeamClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_teamCreateBtn];
    [_teamCreateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_imgBgV);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
    }];
    
    _memberViewBg = [[UIView alloc] init];
    _memberViewBg.alpha = 0.3;
    [self addSubview:_memberViewBg];
    [_memberViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self).mas_offset(15);
        make.top.mas_equalTo(_imgNumV.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(85);
        
    }];
    
    for (int i = 0; i < 10; i++) {
        UIImageView *bgMember = [[UIImageView alloc]init];
        bgMember.image = [UIImage imageNamed:@"ch_member_content"];
        bgMember.frame = CGRectMake(5+45*(i%5), 0+(i/5)*45, 40, 40);
        [_memberViewBg addSubview:bgMember];
    }

    [self createTeamView:_teamArr];
    
}
- (void)createTeamView:(NSArray *)arr
{
    for (int i = 0; i < arr.count; i++) {
        UserModel *model = [arr objectAtIndex:i];
        UIButton *memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [memberBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseURL,model.picurl]] forState:UIControlStateNormal];
        memberBtn.frame = CGRectMake(5+45*(i%5), 0+(i/5)*45, 40, 40);
        [_memberViewBg addSubview:memberBtn];
    }
    
    
}
- (void)onCreateTeamClick
{
    if (_teamArr.count > 9) {
        return;
    }
    [self createTeamView:_teamArr];
    
}
- (void)onTeamAddClick
{
    
}
@end
