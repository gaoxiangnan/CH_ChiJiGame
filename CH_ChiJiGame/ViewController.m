//
//  ViewController.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/17.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "ViewController.h"
#import "CH_TeamCreatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [textBtn setTitle:@"next" forState:UIControlStateNormal];
    textBtn.frame = CGRectMake(100, 100, 100, 100);
    textBtn.backgroundColor = [UIColor redColor];
    [textBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:textBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)onNextClick
{
    CH_TeamCreatViewController *chVC = [[CH_TeamCreatViewController alloc]init];
    [self.navigationController pushViewController:chVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
