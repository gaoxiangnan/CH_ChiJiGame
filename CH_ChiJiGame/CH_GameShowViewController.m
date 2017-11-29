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

@interface CH_GameShowViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>
{
    NSInteger _touchCount;
    NSTimer *Timer;
}

@property (strong,nonatomic) MAMapView *mapView;

@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,assign) CLLocationCoordinate2D currentCoordinate;

@property (nonatomic, strong) NSMutableArray *regions;

@property (nonatomic, strong) LLRadarView *radarView;

@property (nonatomic,strong) CH_MemberMessView *memberMes;
@property (nonatomic,strong) CH_TeamMesView *teamMes;
@end

@implementation CH_GameShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _touchCount = 0;
    
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
    
    
    
    
//    mystyle_sdk_1511329093_0100
    NSString *path = [NSString stringWithFormat:@"%@/mystyle_sdk_1511329093_0100.data", [NSBundle mainBundle].bundlePath];
    NSLog(@"%@",[NSBundle mainBundle].bundlePath);
    NSData *data = [NSData dataWithContentsOfFile:path];
    [_mapView setCustomMapStyleWithWebData:data];
    [_mapView setCustomMapStyleEnabled:YES];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    
    
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
- (void)addCircleReionForCoordinate:(CLLocationCoordinate2D)coordinate
{
    //创建圆形地理围栏
    AMapLocationCircleRegion *cirRegion200 = [[AMapLocationCircleRegion alloc] initWithCenter:coordinate
                                                                                       radius:200.0
                                                                                   identifier:@"circleRegion200"];
    
    AMapLocationCircleRegion *cirRegion300 = [[AMapLocationCircleRegion alloc] initWithCenter:coordinate
                                                                                       radius:300.0
                                                                                   identifier:@"circleRegion300"];
    
    //添加地理围栏
    [self.locationManager startMonitoringForRegion:cirRegion200];
    [self.locationManager startMonitoringForRegion:cirRegion300];
    
    //保存地理围栏
    [self.regions addObject:cirRegion200];
    [self.regions addObject:cirRegion300];
    
    //添加地理围栏对应的Overlay，方便查看
    MACircle *circle200 = [MACircle circleWithCenterCoordinate:coordinate radius:200.0];
    circle200.title = @"currentSafety";
    MACircle *circle300 = [MACircle circleWithCenterCoordinate:coordinate radius:300.0];
    circle300.title = @"futureSafety";
    [self.mapView addOverlay:circle200];
    [self.mapView addOverlay:circle300];
    
    [self.mapView setVisibleMapRect:circle300.boundingMapRect];
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
        
        CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        _currentCoordinate = coordinate2D;
//        [self addCircleReionForCoordinate:coordinate2D];
        NPrintLog(@"%@",[data objectForKey:@"data"]);
        NPrintLog(@"%@",[data objectForKey:@"message"]);
    } failure:^(NSError *error) {
        
    }];
    
//    _mapView.centerCoordinate = coordinate2D;
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
            circleRenderer.strokeColor  = [UIColor redColor];//圈的颜色
            circleRenderer.fillColor    = [UIColor colorWithRed:0 green:0 blue:0.0 alpha:0.3];//填充颜色
        }else{
            circleRenderer.strokeColor  = [UIColor blueColor];//圈的颜色
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
    NSLog(@"我点击了地图 %ld",_touchCount);
}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
//    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
//    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
//    int x = point.x;
//    int y = point.y;
//    NSLog(@"touch (x, y) is (%d, %d)", x, y);
//    self.radarView.center = point;
//}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
//    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
//    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
//    int x = point.x;
//    int y = point.y;
//    NSLog(@"touch (x, y) is (%d, %d)", x, y);
//    self.radarView.center = point;
//}


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
