//
//  UIImage+Cache.m
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+Cache.h"

@implementation UIImage (Cache)
@dynamic cached;

- (BOOL)cached {

    return [objc_getAssociatedObject(self, @selector(cached)) boolValue];
}

- (void)setCached:(BOOL)cached {

    objc_setAssociatedObject(self, @selector(cached), @(cached), OBJC_ASSOCIATION_ASSIGN);
}

- (UIImage *)imageWithCornerRadius:(CGFloat)cornerRadius {

    UIImage *imageNew;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    const CGRect RECT = CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:RECT cornerRadius:cornerRadius] addClip];
    [self drawInRect:RECT];
    imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageNew;
}

@end
