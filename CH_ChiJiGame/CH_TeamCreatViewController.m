//
//  CH_TeamCreatViewController.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/20.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "CH_TeamCreatViewController.h"
#import "CH_TeamCollectionViewCell.h"
#import "CH_GameShowViewController.h"

@interface CH_TeamCreatViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger CountDown;
    NSTimer *CountDownTimer;
}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *CountDowLabel;
@property(nonatomic,strong)UIImageView  *CountDimg,*CountDowimg;


@end
static NSString * const reuseIdentifier = @"cell";
@implementation CH_TeamCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"ch_backGroud.png"];
    [self.view addSubview:bgImageView];
    
//测试
    
    
    
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.CountDimg];
    [self.view addSubview:self.CountDowimg];
    [self.view addSubview:self.CountDowLabel];
    [self adap];
    
    
    // Do any additional setup after loading the view.
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        flowLayout.itemSize = CGSizeMake(240, 250);
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        flowLayout.minimumLineSpacing = 10;
        
        flowLayout.minimumInteritemSpacing = 0;
        
//        flowLayout.footerReferenceSize = CGSizeMake(240, 250);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 270) collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [self.collectionView registerClass:[CH_TeamCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        
        
    }
    return _collectionView;
}
-(UILabel *)CountDowLabel
{
    if (!_CountDowLabel) {
        _CountDowLabel = [[UILabel alloc]init];
        CountDown = 5;// 倒计时秒数
        CountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerAction:) userInfo:nil repeats:YES];
        NSString *str_hour = [NSString stringWithFormat:@"%02ld",CountDown/3600];//时
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(CountDown%3600)/60];//分
        NSString *str_second = [NSString stringWithFormat:@"%02ld",CountDown%60];//秒
        NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
        NSLog(@"time:%@",format_time);
        _CountDowLabel.text = [NSString stringWithFormat:@"倒计时  %@",format_time];
        _CountDowLabel.font = [UIFont boldSystemFontOfSize:20];
        _CountDowLabel.textAlignment = NSTextAlignmentCenter;
        _CountDowLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:16.0f];
        _CountDowLabel.textColor = [UIColor whiteColor];
    }
    return _CountDowLabel;
}
-(UIImageView *)CountDimg
{
    if (!_CountDimg) {
        _CountDimg = [[UIImageView alloc]init];
        _CountDimg.image = [UIImage imageNamed:@"time_spe"];
    }
    return _CountDimg;
}
-(UIImageView *)CountDowimg
{
    if (!_CountDowimg) {
        _CountDowimg = [[UIImageView alloc]init];
        _CountDowimg.image = [UIImage imageNamed:@"time_spe2"];
    }
    return _CountDowimg;
}
//倒计时
-(void) TimerAction:(id)sender
{
    //倒计时-1
    CountDown--;
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",CountDown/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(CountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",CountDown%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    //修改倒计时标签现实内容
    
    _CountDowLabel.text=[NSString stringWithFormat:@"倒计时   %@",format_time];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kaishiyouxi"]];
    img.frame = self.view.frame;
    img.backgroundColor = [UIColor colorWithRed:16/225.0f green:16/225.0f blue:16/225.0f alpha:.6f];
    [self.view addSubview:img];
    [CountDownTimer invalidate];
    //中断后重新开始计时
    CountDownTimer = nil;//实际测试中，不置nil也正常运行，还是保持规范性
    CountDownTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(doTimer) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:CountDownTimer forMode:NSDefaultRunLoopMode];
}
-(void)doTimer
{
    CH_GameShowViewController *vc = [[CH_GameShowViewController alloc]init];
    //        [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [CountDownTimer invalidate];
}
-(void)adap
{
    _CountDowimg.sd_layout.topSpaceToView(self.view, 20).rightSpaceToView(self.view, 110).heightIs(3.8f).widthIs(112);
    _CountDimg.sd_layout.topEqualToView(_CountDowimg).leftSpaceToView(self.view, 110).heightIs(3.8f).widthIs(112);
    _CountDowLabel.sd_layout.topSpaceToView(self.view, 16).leftSpaceToView(self.view, 270).heightIs(10).widthIs(200);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CH_TeamCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == 3) {
        [cell changeCellOutView:YES];
    }else{
        [cell changeCellOutView:NO];
    }
    
    
    return cell;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}


- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    return CGSizeMake(240, 220);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 0, 5, 0);
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
