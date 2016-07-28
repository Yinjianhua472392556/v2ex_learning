//
//  V2MenuView.h
//  V2ex_learning
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface V2MenuView : UIView

@property (nonatomic, copy) void (^didSelectedIndexBlock)(NSInteger index);

- (void)setDidSelectedIndexBlock:(void (^)(NSInteger index))didSelectedIndexBlock;
- (void)selectIndex:(NSUInteger)index;

@property (nonatomic, strong) UIImage *blurredImage;

- (void)setOffsetProgress:(CGFloat)progress;

@end
