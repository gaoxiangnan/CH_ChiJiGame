//
//  CH_TeamCreatViewController.m
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/20.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import "CH_TeamCreatViewController.h"
#import "CH_TeamCollectionViewCell.h"

@interface CH_TeamCreatViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;


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
// 设置headerView和footerView的
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableView = nil;
//    if (kind == UICollectionElementKindSectionFooter)
//    {
//        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
//        footerview.backgroundColor = [UIColor purpleColor];
//        footerview.alpha = 0.3;
//        reusableView = footerview;
//    }
//    return reusableView;
//}

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
