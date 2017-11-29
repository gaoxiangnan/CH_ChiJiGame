//
//  CH_TeamCollectionViewCell.h
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/20.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamModel.h"
typedef void (^ChangeTeamBlock)(NSString *);
@interface CH_TeamCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) ChangeTeamBlock changeTeam;
- (void)translateData:(TeamModel *)teamModel changeCellOutView:(BOOL)last;
- (void)teamNum:(NSInteger)index;
@end
