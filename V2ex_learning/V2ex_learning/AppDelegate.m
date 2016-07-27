//
//  AppDelegate.m
//  V2ex_learning
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "V2LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.rootViewController = [[V2LoginViewController alloc] init];
    self.window.rootViewController = self.rootViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}




@end
