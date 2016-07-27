//
//  V2UserModel.h
//  V2ex_learning
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "V2MemberModel.h"

@interface V2UserModel : NSObject

@property (nonatomic, strong) V2MemberModel *member;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *feedURL;

@property (nonatomic, assign, getter = isLogin) BOOL login;

@end
