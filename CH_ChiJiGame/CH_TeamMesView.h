//
//  CH_TeamMesView.h
//  CH_ChiJiGame
//
//  Created by 高向楠 on 2017/11/22.
//  Copyright © 2017年 高向楠. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SleuthBlock)();
@interface CH_TeamMesView : UIView
@property (nonatomic, copy)SleuthBlock sleuthBlock;

@end
