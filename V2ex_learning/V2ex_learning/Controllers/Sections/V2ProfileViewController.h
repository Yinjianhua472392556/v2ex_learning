//
//  V2ProfileViewController.h
//  V2ex_learning
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SCPullRefreshViewController.h"
#import "V2MemberModel.h"

@interface V2ProfileViewController : SCPullRefreshViewController

@property (nonatomic, assign) BOOL isSelf;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) V2MemberModel *member;

@end
