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
@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) UIImageView * imgBgV;
@property(nonatomic,strong)UIImageView *imgNumV;

@property (nonatomic, strong) UILabel *teamTitleLb;
@property (nonatomic, strong) UIButton *teamCreateBtn;
@property (nonatomic, strong) UIView *memberViewBg;

@property (nonatomic, strong) UIButton *teamAddBtn;
@property (nonatomic, strong) UILabel *teamCreatLb;


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
        
        _imgArr = [NSArray arrayWithObjects:@"ch_img_1",@"ch_img_2",@"ch_img_3",@"ch_img_4",@"ch_img_5",@"ch_img_6",@"ch_img_7",@"ch_img_8",@"ch_img_9", nil];
        
        CGFloat hei = 70.0;
        UIImage *img = [UIImage imageNamed:@"ch_img_1"];
        _imgNumV = [[UIImageView alloc]init];
        [self addSubview:self.imgNumV];
        [_imgNumV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(img.size.height/hei*img.size.width);
            make.height.mas_equalTo(hei);
        }];
        
        [self createTeamPlaceHoldView];
        [self lastCellViewUpdata];
        
    }
    return self;
}
- (void)lastCellViewUpdata
{
    _teamAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImg = [UIImage imageNamed:@"ch_teamAdd_btn"];
    [_teamAddBtn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [_teamAddBtn addTarget:self action:@selector(onTeamAddClick) forControlEvents:UIControlEventTouchUpInside];
    _teamAddBtn.hidden = YES;
    [self addSubview:_teamAddBtn];
    [_teamAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_imgBgV);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    _teamCreatLb = [[UILabel alloc]init];
    _teamAddBtn.hidden = YES;
    _teamCreatLb.text = @"创建组队";
    _teamCreatLb.textColor = [UIColor yellowColor];
    _teamCreatLb.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    _teamCreatLb.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_teamCreatLb];
    [_teamCreatLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_teamAddBtn);
        make.top.mas_equalTo(_teamAddBtn.mas_bottom).mas_offset(10);
    }];
    
    
}
- (void)translateData:(TeamModel *)teamModel changeCellOutView:(BOOL)last
{
    if (last == YES) {
        _teamAddBtn.hidden = NO;
        _teamCreatLb.hidden = NO;
        _teamCreateBtn.hidden = YES;
        _memberViewBg.hidden = YES;
        _teamTitleLb.hidden = YES;
        
    }else{
        _teamAddBtn.hidden = YES;
        _teamCreatLb.hidden = YES;
        _teamCreateBtn.hidden = NO;
        _memberViewBg.hidden = NO;
        _teamTitleLb.hidden = NO;
        _teamTitleLb.text = teamModel.name;
        [self createTeamView:teamModel.userlist];
        
    }
}
- (void)teamNum:(NSInteger)index
{
    _imgNumV.image = [UIImage imageNamed:[_imgArr objectAtIndex:index]];
}
- (void)createTeamPlaceHoldView
{

    _teamTitleLb = [[UILabel alloc]init];
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
    _teamCreateBtn.hidden = NO;
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
    _memberViewBg.hidden = NO;
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

    
    
}
- (void)createTeamView:(NSArray *)arr
{
    if (arr.count > 0) {
        for (int i = 0; i < arr.count; i++) {
            UserModel *model = [arr objectAtIndex:i];
            
            UIButton *memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [memberBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseURL,model.picurl]] forState:UIControlStateNormal];
            memberBtn.frame = CGRectMake(5+45*(i%5), 0+(i/5)*45, 40, 40);
            [_memberViewBg addSubview:memberBtn];
        }
    }else{
        [_memberViewBg.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int i = 0; i < 10; i++) {
            UIImageView *bgMember = [[UIImageView alloc]init];
            bgMember.image = [UIImage imageNamed:@"ch_member_content"];
            bgMember.frame = CGRectMake(5+45*(i%5), 0+(i/5)*45, 40, 40);
            [_memberViewBg addSubview:bgMember];
        }
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
