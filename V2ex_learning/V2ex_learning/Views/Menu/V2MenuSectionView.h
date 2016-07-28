//
//  V2MenuSectionView.h
//  V2ex_learning
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface V2MenuSectionView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^didSelectedIndexBlock)(NSInteger index);

- (void)setDidSelectedIndexBlock:(void (^)(NSInteger index))didSelectedIndexBlock;

@end
