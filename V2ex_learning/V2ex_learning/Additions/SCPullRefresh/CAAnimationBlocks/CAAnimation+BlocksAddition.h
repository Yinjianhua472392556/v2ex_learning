//
//  CAAnimation+BlocksAddition.h
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (BlocksAddition)

@property (nonatomic, copy) void (^completion)(BOOL finished, CALayer *layer);
@property (nonatomic, copy) void (^start)(void);

- (void)setCompletion:(void (^)(BOOL finished, CALayer *))completion; // Forces auto-complete of setCompletion: to add the name 'finished' in the block parameter
@end
