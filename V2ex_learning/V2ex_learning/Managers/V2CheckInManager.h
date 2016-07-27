//
//  V2CheckInManager.h
//  V2ex_learning
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface V2CheckInManager : NSObject

@property (nonatomic, assign) NSInteger checkInCount;
@property (nonatomic, assign,getter=isExpired) BOOL expired;

+ (instancetype)manager;

- (void)resetStatus;

- (void)updateStatus;

- (void)removeStatus;

- (NSURLSessionDataTask *)checkInSuccess:(void (^)(NSInteger count))success
                                 failure:(void (^)(NSError *error))failure;

@end
