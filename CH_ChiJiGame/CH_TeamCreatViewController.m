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
#import<libkern/OSAtomic.h>
#import "PointModel.h"

@interface CH_TeamCreatViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger CountDown;
    NSTimer *CountDownTimer;
//    dispatch_source_t _timer;
}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *CountDowLabel;
@property(nonatomic,strong)UIImageView  *CountDimg,*CountDowimg;
@property (nonatomic, strong) NSMutableArray *teamArr;
@property (nonatomic, strong) NSMutableArray *circleArr;


@end
static NSString * const reuseIdentifier = @"cell";
@implementation CH_TeamCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self start];
    [self updateNetData];
    
    _teamArr = [[NSMutableArray alloc]initWithCapacity:0];
    _circleArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"ch_backGroud.png"];
    [self.view addSubview:bgImageView];
    
    
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
    
    [_collectionView registerClass:[CH_TeamCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collectionView];
    
    [self.view addSubview:self.CountDimg];
    [self.view addSubview:self.CountDowimg];
    [self.view addSubview:self.CountDowLabel];
    [self adap];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)start
{
    // GCD定时器
    static dispatch_source_t _timer;
    NSTimeInterval period = 4.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    // 事件回调
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateNetData];
            NSLog(@"Count");
        });
    });
    
    // 开启定时器
//    dispatch_resume(_timer);
}

- (void)updateNetData
{
    
    //    [CH_NetWorkManager getWithURLString:@"waitRoomList" parameters:@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:Token] } success:^(NSDictionary *data) {
    [CH_NetWorkManager getWithURLString:@"waitRoomList" parameters:@{@"token":[NSString md5:Token]} success:^(NSDictionary *data) {
        [self relodDataUpdate:data];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(UILabel *)CountDowLabel
{
    if (!_CountDowLabel) {
        _CountDowLabel = [[UILabel alloc]init];
        CountDown = _piontSecond;// 倒计时秒数
//        CountDown = 5;
        
        
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
    if (CountDown == 0) {
        
    [CountDownTimer invalidate];
        
        [CH_NetWorkManager getWithURLString:@"plan/lun_match_start" parameters:nil success:^(NSDictionary *data) {
            if ([[data objectForKey:@"code"] isEqualToString:@"200"]) {
                
                UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"start_game"]];
                img.frame = self.view.frame;
                img.backgroundColor = [UIColor colorWithRed:16/225.0f green:16/225.0f blue:16/225.0f alpha:.6f];
                [self.view addSubview:img];
                
                for (NSDictionary *dic in [[data objectForKey:@"data"] objectForKey:@"circle"]) {
                    PointModel *model = [[PointModel alloc]initWithDic:dic];
                    [_circleArr addObject:model];
                }
                [self doTimer];
            }else if ([[data objectForKey:@"code"] isEqualToString:@"201"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[data objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        } failure:^(NSError *error) {
            
        }];
    
    
    }
    
}

-(void)doTimer
{
//    dispatch_source_cancel(_timer);
    
    CH_GameShowViewController *vc = [[CH_GameShowViewController alloc]init];
    vc.pointArr = [NSArray arrayWithArray:_circleArr];
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
    cell.changeTeam = ^(NSString *teamId) {
//        dispatch_source_cancel(_timer);
        [CH_NetWorkManager getWithURLString:@"changeTeam" parameters:@{@"token":[NSString md5:Token],@"team":teamId} success:^(NSDictionary *data) {
//            dispatch_resume(_timer);
            [self relodDataUpdate:data];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    };
    if (indexPath.row == _teamArr.count - 1) {
        [cell translateData:[_teamArr objectAtIndex:indexPath.row] changeCellOutView:YES];
    }else{
        [cell translateData:[_teamArr objectAtIndex:indexPath.row] changeCellOutView:NO];
    }
    [cell teamNum:indexPath.row];
    
    
    return cell;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _teamArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    if ((indexPath.row == _teamArr.count - 1)) {
        NPrintLog(@"点击最后一个cell，执行添加操作");
        
//        //初始化一个新的cell模型；
//        TeamModel *model = [[TeamModel alloc] init];
//        model.name = @"林更新";
//        model.id = [NSString stringWithFormat:@"%ld",_teamArr.count - 1];
//        model.userlist = [NSArray array];
//        
//        
//        //把新创建的cell插入到最后一个之前；
//        [_teamArr insertObject:model atIndex:_teamArr.count - 1];
//        
//        
//        //更新UI；
//        [_collectionView reloadData];
        
        [self setRoom];
        
        
        
    }else{
//        NSLog(@"第%ld个section,点击图片%ld",indexPath.section,indexPath.row);
    }  
    
}
- (void)setRoom
{
//    dispatch_source_cancel(_timer);
    [CH_NetWorkManager getWithURLString:@"setRoom" parameters:@{@"token":[NSString md5:Token]} success:^(NSDictionary *data) {
//        dispatch_resume(_timer);
        [self relodDataUpdate:data];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)relodDataUpdate:(NSDictionary *)dic
{
    NPrintLog(@"%@",dic);
    if ([[dic objectForKey:@"code"] isEqualToString:@"200"]) {
        [_teamArr removeAllObjects];
        NSArray *dataArr = [dic objectForKey:@"data"];
        for (NSDictionary *dic in dataArr) {
            TeamModel *teamModel = [[TeamModel alloc]initWithDic:dic];
            [_teamArr addObject:teamModel];
        }
        TeamModel *teamModel = [[TeamModel alloc]init];
        NSInteger index = _teamArr.count;
        [_teamArr insertObject:teamModel atIndex:index];
        
        [_collectionView reloadData];
        
    }
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
