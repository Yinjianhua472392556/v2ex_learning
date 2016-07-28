//
//  V2Helper.m
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "V2Helper.h"

@implementation V2Helper

+ (UIImage *)getImageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)size {

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)getImageFromView:(UIView *)orgView {

    if (orgView) {
        
        UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, [UIScreen mainScreen].scale);
        [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
        
    }else {
    
        return nil;
    }
    
}

@end
