//
//  V2CategoriesViewController.h
//  V2ex_learning
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SCPullRefreshViewController.h"

@interface V2CategoriesViewController : SCPullRefreshViewController

@property (nonatomic, assign, getter = isFavorite) BOOL favorite;

@end
