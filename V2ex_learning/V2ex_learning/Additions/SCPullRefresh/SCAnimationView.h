//
//  SCAnimationView.h
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCAnimationView : UIView

@property (nonatomic, assign) CGFloat timeOffset; // 0.0 ~ 1.0

- (void)beginRefreshing;
- (void)endRefreshing;
@end
