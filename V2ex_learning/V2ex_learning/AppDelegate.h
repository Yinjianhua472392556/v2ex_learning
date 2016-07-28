//
//  AppDelegate.h
//  V2ex_learning
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SCNavigationController.h"
#import "V2RootViewController.h"
#import "V2LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) V2RootViewController *rootViewController;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) SCNavigationController *currentNavigationController;

@end

