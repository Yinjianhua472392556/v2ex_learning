//
//  NSDictionary+NotNullKey.h
//  V2ex_learning
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define NILORSLASH(obj) (obj != nil) ? obj : @"/"
#define NILORDASH(obj)  (obj != nil) ? obj : @"-"

@interface NSDictionary (NotNullKey)

+ (NSDictionary *)dictionaryWithPropertiesOfObject:(id)obj;

- (id)objectForSafeKey:(id)key;

@end
