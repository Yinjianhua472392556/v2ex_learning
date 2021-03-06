//
//  UIImage+Tint.h
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

@property (nonatomic, strong) UIImage *imageForCurrentTheme;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (CGSize)fitWidth:(CGFloat)fitWidth;

@end
