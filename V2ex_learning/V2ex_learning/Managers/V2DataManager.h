//
//  V2DataManager.h
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface V2DataManager : NSObject

+ (instancetype)manager;

@property (nonatomic, assign) BOOL preferHttps;

@end
