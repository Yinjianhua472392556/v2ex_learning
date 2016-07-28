//
//  V2DataManager.h
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "V2UserModel.h"

typedef NS_ENUM(NSInteger, V2ErrorType) {
    
    V2ErrorTypeNoOnceAndNext          = 700,
    V2ErrorTypeLoginFailure           = 701,
    V2ErrorTypeRequestFailure         = 702,
    V2ErrorTypeGetFeedURLFailure      = 703,
    V2ErrorTypeGetTopicListFailure    = 704,
    V2ErrorTypeGetNotificationFailure = 705,
    V2ErrorTypeGetFavUrlFailure       = 706,
    V2ErrorTypeGetMemberReplyFailure  = 707,
    V2ErrorTypeGetTopicTokenFailure   = 708,
    V2ErrorTypeGetCheckInURLFailure   = 709,
    
};


typedef NS_ENUM (NSInteger, V2HotNodesType) {
    
    V2HotNodesTypeTech,
    V2HotNodesTypeCreative,
    V2HotNodesTypePlay,
    V2HotNodesTypeApple,
    V2HotNodesTypeJobs,
    V2HotNodesTypeDeals,
    V2HotNodesTypeCity,
    V2HotNodesTypeQna,
    V2HotNodesTypeHot,
    V2HotNodesTypeAll,
    V2HotNodesTypeR2,
    V2HotNodesTypeNodes,
    V2HotNodesTypeMembers,
    V2HotNodesTypeFav,
    
};

@interface V2DataManager : NSObject

+ (instancetype)manager;

@property (nonatomic, strong) V2UserModel *user;


@property (nonatomic, assign) BOOL preferHttps;


#pragma mark - Login & Profile

- (NSURLSessionDataTask *)UserLoginWithUsername:(NSString *)username
                                       password:(NSString *)password
                                        success:(void (^)(NSString *message))success
                                        failure:(void (^)(NSError *error))failure;
- (void)UserLogout;

#pragma mark - Notifications

- (NSURLSessionDataTask *)getCheckInCountSuccess:(void (^)(NSInteger count))success
                                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getCheckInURLSuccess:(void (^)(NSURL *URL))success
                                       failure:(void (^)(NSError *error))failure;

#pragma mark - GET

- (NSURLSessionDataTask *)getMemberProfileWithUserId:(NSString *)userid
                                            username:(NSString *)username
                                             success:(void (^)(V2MemberModel *member))success
                                             failure:(void (^)(NSError *error))failure;
@end
