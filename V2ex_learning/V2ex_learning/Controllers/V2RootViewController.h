//
//  V2RootViewController.h
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, V2SectionIndex) {
    V2SectionIndexLatest       = 0,
    V2SectionIndexCategories   = 1,
    V2SectionIndexNodes        = 2,
    V2SectionIndexFavorite     = 3,
    V2SectionIndexNotification = 4,
    V2SectionIndexProfile      = 5,
};

@interface V2RootViewController : UIViewController

- (void)showViewControllerAtIndex:(V2SectionIndex)index animated:(BOOL)animated;

@end
