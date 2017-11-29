//
//  CH_GameShowViewController.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/21.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "CH_GameShowViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CH_MemberMessView.h"
#import "CH_TeamMesView.h"
#import "LLRadarView.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "CH_VictoryViewController.h"
#import "PointModel.h"
#import "PlayerModel.h"

@interface CH_GameShowViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>
{
    NSInteger _touchCount;
    NSTimer *Timer;
    dispatch_source_t _timer;
}

@property (strong,nonatomic) MAMapView *mapView;

@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,assign) CLLocationCoordinate2D currentCoordinate;

@property (nonatomic, strong) NSMutableArray *regions;

@property (nonatomic, strong) LLRadarView *radarView;

@property (nonatomic,strong) CH_MemberMessView *memberMes;
@property (nonatomic,strong) CH_TeamMesView *teamMes;

@property (nonatomic, strong) NSMutableArray *circleArr;
@property (nonatomic, strong) NSMutableArray *playerArr;
@end

@implementation CH_GameShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _touchCount = 0;
    _circleArr = [[NSMutableArray alloc]initWithCapacity:0];
    _playerArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate  = self;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    //开启持续定位
    [self.locationManager startUpdatingLocation];

    NSString *path = [NSString stringWithFormat:@"%@/mystyle_sdk_1511329093_0100.data", [NSBundle mainBundle].bundlePath];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [_mapView setCustomMapStyleWithWebData:data];
    [_mapView setCustomMapStyleEnabled:YES];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    [self safetyCircleUpdate];
    
    //固定范围
    PointModel *model1 = [[PointModel alloc]initWithDic:@{@"point":@"116.669052,40.28629",@"radius":@"400"}];
    CLLocationCoordinate2D Cllo = CLLocationCoordinate2DMake( [model1.lat floatValue],[model1.lng floatValue]);
    MACircle *circle = [MACircle circleWithCenterCoordinate:Cllo radius:[model1.radius floatValue]];
    [self.mapView setVisibleMapRect:circle.boundingMapRect];
    
//初始化安全区域
    [self safetyCircleArea];
    
//地图上的View
    _memberMes = [[CH_MemberMessView alloc]initWithFrame:CGRectMake(10, 10, kWindowW-20, 75)];
    _memberMes.backgroundColor = [UIColor blackColor];
    _memberMes.alpha = 0.5;
    [self.view addSubview:_memberMes];
//地图下的View
    __weak typeof(self) weakSelf = self;
    _teamMes = [[CH_TeamMesView alloc]initWithFrame:CGRectMake(0, kWindowH - (kWindowH*85/375), kWindowW, (kWindowH*85/375))];
    _teamMes.sleuthBlock = ^(){
        
        UIImageView *img= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shengli"]];
        img.frame = weakSelf.view.frame;
        img.backgroundColor = [UIColor colorWithRed:16/225.0f green:16/225.0f blue:16/225.0f alpha:.6f];
        [weakSelf.view addSubview:img];
        
        Timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(doTimer) userInfo:nil repeats:NO];
        //[[NSRunLoop mainRunLoop] addTimer:Timer forMode:NSDefaultRunLoopMode];
        
    };
    [self.view addSubview:_teamMes];
    
    
    // Do any additional setup after loading the view.
}

//初始化安全区
- (void)safetyCircleArea
{
    PointModel *modelCur = [_pointArr firstObject];
    PointModel *modelFut = [_pointArr lastObject];
    
    
    [self addCircleReionForCoordinateCurrent:modelCur future:modelFut];
    
    [self start];
}
- (void)safetyCircleUpdate
{
    [CH_NetWorkManager getWithURLString:@"plan/lun_suo_circle" parameters:nil success:^(NSDictionary *data) {
        if ([[data objectForKey:@"code"]isEqualToString:@"200"]) {
            [_circleArr removeAllObjects];
            NSArray *circleArr = [[data objectForKey:@"data"] objectForKey:@"circle"];
            
            
            for (NSDictionary *dic in circleArr) {
                PointModel *model = [[PointModel alloc]initWithDic:dic];
                [_circleArr addObject:model];
            }
            
            if (circleArr.count > 1) {
                [self addCircleReionForCoordinateCurrent:[_circleArr firstObject] future:[_circleArr lastObject]];
            }else{
                [self addCircleReionForCoordinateCurrent:[_circleArr firstObject] future:nil];
                dispatch_source_cancel(_timer);
            }
            
        }else if ([[data objectForKey:@"code"]isEqualToString:@"199"]){
            //比赛结束
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)start
{
    // GCD定时器
    //    static dispatch_source_t _timer;
    NSTimeInterval period = 1.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    // 事件回调
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self safetyCircleUpdate];
        });
    });
    
    // 开启定时器
    dispatch_resume(_timer);
}


- (void)addCircleReionForCoordinateCurrent:(PointModel *)CurModel future:(PointModel *)FutModel
{
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    
    CLLocationCoordinate2D currentCllo = CLLocationCoordinate2DMake( [CurModel.lat floatValue],[CurModel.lng floatValue]);
    CLLocationCoordinate2D futureCllo = CLLocationCoordinate2DMake( [FutModel.lat floatValue],[FutModel.lng floatValue]);
    
    //创建圆形地理围栏
    AMapLocationCircleRegion *currentCirRegion = [[AMapLocationCircleRegion alloc] initWithCenter:currentCllo radius:[CurModel.radius floatValue] identifier:@"circleRegion200"];
    
    AMapLocationCircleRegion *futureCirRegion = [[AMapLocationCircleRegion alloc] initWithCenter:futureCllo radius:[FutModel.radius floatValue] identifier:@"circleRegion300"];
    
    
    //添加地理围栏
    [self.locationManager startMonitoringForRegion:currentCirRegion];
    [self.locationManager startMonitoringForRegion:futureCirRegion];
    
    //保存地理围栏
    [self.regions addObject:currentCirRegion];
    [self.regions addObject:futureCirRegion];
    
    //添加地理围栏对应的Overlay，方便查看
    MACircle *circle200 = [MACircle circleWithCenterCoordinate:currentCllo radius:[CurModel.radius floatValue]];
    circle200.title = @"currentSafety";
    MACircle *circle300 = [MACircle circleWithCenterCoordinate:futureCllo radius:[FutModel.radius floatValue]];
    circle300.title = @"futureSafety";
    [self.mapView addOverlay:circle200];
    [self.mapView addOverlay:circle300];
    

}

-(void)doTimer
{
    CH_VictoryViewController *vc = [[CH_VictoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [Timer invalidate];
}
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //输出的是模拟器的坐标
    
    [CH_NetWorkManager postWithURLString:@"plan/setCoordinate" parameters:@{@"token":[NSString md5:[NSString stringWithFormat:@"miganchuanmei%@",@"18210238706"]],@"lng":[NSString stringWithFormat:@"%f",location.coordinate.longitude],@"lat":[NSString stringWithFormat:@"%f",location.coordinate.latitude]} success:^(NSDictionary *data) {
        [_memberMes updateMemberData:data];
        CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        _currentCoordinate = coordinate2D;
        NPrintLog(@"%@",data);
        
        NSArray *playerArr = [[data objectForKey:@"data"] objectForKey:@"list"];
        NSMutableArray *coordinates = [NSMutableArray array];
        
        [_playerArr removeAllObjects];
        for (NSDictionary *dic in playerArr) {
            
            PlayerModel *model = [[PlayerModel alloc] initWithDic:dic];
            [_playerArr addObject:model];
            CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([model.lat doubleValue], [model.lng doubleValue]);
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = coor;
        
            [pointAnnotation setTitle:[NSString stringWithFormat:@"%@", @"1"]];
            [pointAnnotation setSubtitle:[NSString stringWithFormat:@"%@", @"2"]];
            
            [coordinates addObject:pointAnnotation];
        
        //将大头针添加到地图中
//        [self.mapView addAnnotation:pointAnnotation];
        
        //默认选中气泡
//        [self.mapView selectAnnotation:pointAnnotation animated:YES];
            
        }
        [self.mapView addAnnotations:coordinates];
        
        [_teamMes updatePlayerLives:_playerArr];
    } failure:^(NSError *error) {
        
    }];
    
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = NO;
        annotationView.draggable        = NO;
        annotationView.pinColor         = MAPinAnnotationColorPurple;
        
        return annotationView;
    }
    
    return nil;
    
    
    
}



- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    //定位错误
    NSLog(@"定位失败");
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

//围栏颜色和围栏填充颜色
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        circleRenderer.lineWidth    = 5.f;
        if ([overlay.title isEqualToString:@"currentSafety"]) {
            circleRenderer.strokeColor  = [UIColor blueColor];//圈的颜色
            circleRenderer.fillColor    = [UIColor colorWithRed:0 green:0 blue:0.0 alpha:0.3];//填充颜色
        }else{
            circleRenderer.strokeColor  = [UIColor redColor];//圈的颜色
            circleRenderer.fillColor    = [UIColor colorWithRed:0 green:0 blue:0.0 alpha:0.3];//填充颜色
        }
        return circleRenderer;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    _touchCount += 1;
    if (_touchCount%2 == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            _memberMes.frame = CGRectMake(10, -75, kWindowW-20, 75);
            _teamMes.frame = CGRectMake(0, kWindowH, kWindowW, (kWindowH*85/375));
        }];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _memberMes.frame = CGRectMake(10, 10, kWindowW-20, 75);
            _teamMes.frame = CGRectMake(0, kWindowH - (kWindowH*85/375), kWindowW, (kWindowH*85/375));
        }];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didEnterRegion:(AMapLocationRegion *)region
{
    NSLog(@"进入围栏:%@", region);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didExitRegion:(AMapLocationRegion *)region
{
    if ([region.identifier isEqualToString:@"circleRegion200"]) {
        [CH_NetWorkManager getWithURLString:@"/admin/match/endGame" parameters:@{@"token":[NSString md5:[NSString stringWithFormat:@"miganchuanmei%@",@"18210238706"]]} success:^(NSDictionary *data) {
            if ([[data objectForKey:@"code"] isEqualToString:@"200"]) {
                //出圈死亡
            }
        } failure:^(NSError *error) {
            
        }];
    }
    NSLog(@"走出围栏:%@", region);
}
- (void)amapLocationManager:(AMapLocationManager *)manager didStartMonitoringForRegion:(AMapLocationRegion *)region
{
    NSLog(@"didStartMonitoringForRegion:%@", region);
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
