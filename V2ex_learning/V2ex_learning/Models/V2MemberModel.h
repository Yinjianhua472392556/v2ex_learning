//
//  V2MemberModel.h
//  V2ex_learning
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "V2BaseModel.h"

@interface V2MemberModel : V2BaseModel

@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *memberName;
@property (nonatomic, copy) NSString *memberAvatarMini;
@property (nonatomic, copy) NSString *memberAvatarNormal;
@property (nonatomic, copy) NSString *memberAvatarLarge;
@property (nonatomic, copy) NSString *memberTagline;

@property (nonatomic, copy) NSString *memberBio;
@property (nonatomic, copy) NSString *memberCreated;
@property (nonatomic, copy) NSString *memberLocation;
@property (nonatomic, copy) NSString *memberStatus;
@property (nonatomic, copy) NSString *memberTwitter;
@property (nonatomic, copy) NSString *memberUrl;
@property (nonatomic, copy) NSString *memberWebsite;

@end
