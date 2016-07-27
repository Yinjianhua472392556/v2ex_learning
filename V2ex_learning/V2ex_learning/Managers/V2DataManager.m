//
//  V2DataManager.m
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "V2DataManager.h"

#import <AFNetworking.h>
#import <RegexKitLite.h>
#import "HTMLParser.h"
#import "V2CheckInManager.h"

#import "V2MemberModel.h"

static NSString *const kOnceString = @"once";
static NSString *const kNextString =  @"next";

static NSString *const kUsername = @"username";
static NSString *const kUserid = @"userid";
static NSString *const kAvatarURL = @"avatarURL";
static NSString *const kUserIsLogin = @"userIsLogin";

static NSString *const kLoginPassword = @"p";
static NSString *const kLoginUsername = @"u";


typedef NS_ENUM(NSUInteger, V2RequestMethod) {
    V2RequestMethodJSONGET = 1,
    V2RequestMethodHTTPPOST = 2,
    V2RequestMethodHTTPGET = 3,
    V2RequestMethodHTTPGETPC = 4,
};


@interface V2DataManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, copy) NSString *userAgentMobile;
@property (nonatomic, copy) NSString *userAgentPC;

@end

@implementation V2DataManager

- (instancetype)init {

    self = [super init];
    if (self) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        self.userAgentMobile = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        self.userAgentPC = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/537.75.14";

        self.preferHttps = kSetting.preferHttps;
        
        BOOL isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:kUserIsLogin] boolValue];
        if (isLogin) {
            V2UserModel *user = [[V2UserModel alloc] init];
            user.login = YES;
            V2MemberModel *member = [[V2MemberModel alloc] init];
            user.member = member;
            user.member.memberName = [[NSUserDefaults standardUserDefaults] objectForKey:kUsername];
            user.member.memberId = [[NSUserDefaults standardUserDefaults] objectForKey:kUserid];
            user.member.memberAvatarLarge = [[NSUserDefaults standardUserDefaults] objectForKey:kAvatarURL];
            _user = user;
        }
    }
    return self;
}

- (void)setPreferHttps:(BOOL)preferHttps {

    _preferHttps = preferHttps;
    
    NSURL *baseUrl;
    
    baseUrl = [NSURL URLWithString:@"https://www.v2ex.com"];

    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    self.manager.requestSerializer = serializer;
}


- (void)setUser:(V2UserModel *)user {

    _user = user;
    
    if (user) {
        self.user.login = YES;
        
        [[NSUserDefaults standardUserDefaults] setObject:user.member.memberName forKey:kUsername];
        [[NSUserDefaults standardUserDefaults] setObject:user.member.memberId forKey:kUserid];
        [[NSUserDefaults standardUserDefaults] setObject:user.member.memberAvatarLarge forKey:kAvatarURL];
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:kUserIsLogin];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUsername];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserid];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAvatarURL];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserIsLogin];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


+ (instancetype)manager {
    
    static V2DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[V2DataManager alloc] init];
    });
    return manager;
    
}


- (NSURLSessionDataTask *)requestWithMethod:(V2RequestMethod)method
                                  URLString:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSError *error))failure {

    // stateBar
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // Handle Common Mission, Cache, Data Reading & etc.
    void (^responseHandleBlock)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Any common handler for Response

        
        success(task, responseObject);
    };
    
    // Create HTTPSession
    NSURLSessionDataTask *task = nil;
    
    [self.manager.requestSerializer setValue:self.userAgentMobile forHTTPHeaderField:@"User-Agent"];
    
    if (method == V2RequestMethodJSONGET) {
        AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer = responseSerializer;
        task = [self.manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            V2Log(@"Error: \n%@", [error description]);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }
    
    if (method == V2RequestMethodHTTPGET) {
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer = responseSerializer;
        task = [self.manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }
    
    if (method == V2RequestMethodHTTPPOST) {
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer = responseSerializer;
        task = [self.manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }

    if (method == V2RequestMethodHTTPGETPC) {
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer = responseSerializer;
        [self.manager.requestSerializer setValue:self.userAgentPC forHTTPHeaderField:@"User-Agent"];

        task = [self.manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            responseHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(error);
        }];
    }

    return task;
}

#pragma mark - Public Request Methods - Login & Profile

- (NSURLSessionDataTask *)UserLoginWithUsername:(NSString *)username password:(NSString *)password success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    [self requestOnceWithURLString:@"/signin" success:^(NSString *onceString, id responseObject) {
        
        NSDictionary *loginDict = [self getLoginDictFromHtmlResponseObject:responseObject];
        
        NSDictionary *parameters = @{
                                     kOnceString: onceString,
                                     kNextString: @"/",
                                     loginDict[kLoginPassword] ?: @"p": password,
                                     loginDict[kLoginUsername] ?: @"u": username,
                                     };
        [self.manager.requestSerializer setValue:@"https://v2ex.com/signin" forHTTPHeaderField:@"Referer"];
        
        [self requestWithMethod:V2RequestMethodHTTPPOST URLString:@"/signin"  parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            if ([htmlString rangeOfString:@"/notifications"].location != NSNotFound) {
                [[V2CheckInManager manager] resetStatus];
                success(username);
            }else {
                NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:V2ErrorTypeLoginFailure userInfo:nil];
                failure(error);
            }

            
        } failure:^(NSError *error) {
            failure(error);
        }];
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
    return nil;
}


#pragma mark - Notifications

- (NSURLSessionDataTask *)getCheckInCountSuccess:(void (^)(NSInteger count))success failure:(void (^)(NSError *error))failure {
    
    return [self requestWithMethod:V2RequestMethodHTTPGET URLString:@"/mission/daily" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *checkInCountString = [self getCheckInCountStringFromHtmlResponseObject:responseObject];
        if (checkInCountString) {
            success([checkInCountString integerValue]);
        }else {
        
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:V2ErrorTypeGetCheckInURLFailure userInfo:nil];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


- (NSURLSessionDataTask *)getCheckInURLSuccess:(void (^)(NSURL *URL))success failure:(void (^)(NSError *error))failure {

    return [self requestWithMethod:V2RequestMethodHTTPGET URLString:@"/mission/daily" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *checkInString = [self getCheckInUrlStringFromHtmlResponseObject:responseObject];
        if (checkInString) {
        
            NSURL *checkInURL = [NSURL URLWithString:checkInString];
            success(checkInURL);
            
        }else {
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:V2ErrorTypeGetCheckInURLFailure userInfo:nil];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


#pragma mark - Public Request Methods - GET

- (NSURLSessionDataTask *)getMemberProfileWithUserId:(NSString *)userid username:(NSString *)username success:(void (^)(V2MemberModel *member))success failure:(void (^)(NSError *error))failure {

    NSDictionary *parameters;
    if (userid) {
        parameters = @{@"id" : userid};
    }
    
    if (username) {
        parameters = @{@"username" : username};
    }
    
    return [self requestWithMethod:V2RequestMethodJSONGET URLString:@"/api/members/show.json" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            V2MemberModel *member = [[V2MemberModel alloc] initWithDictionary:responseObject];
            success(member);
        }else {
        
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - Private Methods

- (NSURLSessionDataTask *)requestOnceWithURLString:(NSString *)urlString
                                           success:(void (^)(NSString *onceString, id responseObject))success
                                           failure:(void (^)(NSError *error))failure {
    
    return [self requestWithMethod:V2RequestMethodHTTPGET URLString:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *onceString = [self getOnceStringFromHtmlResponseObject:responseObject];
        if (onceString) {
            success(onceString, responseObject);
        }else {
        
            NSError *error = [[NSError alloc] initWithDomain:self.manager.baseURL.absoluteString code:V2ErrorTypeNoOnceAndNext userInfo:nil];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (NSString *)getOnceStringFromHtmlResponseObject:(id)responseObject {

    __block NSString *onceString;
    
    @autoreleasepool {
        NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
        if (error) {
            NSLog(@"Error: %@", error);
        }
        
        HTMLNode *bodyNode = [parser body];
        
        NSArray *inputNodes = [bodyNode findChildTags:@"input"];
        
        [inputNodes enumerateObjectsUsingBlock:^(HTMLNode *aNode, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[aNode getAttributeNamed:@"name"] isEqualToString:@"once"]) {
                onceString = [aNode getAttributeNamed:@"value"];
            }
        }];

    }
    
    
    return onceString;
}


- (NSString *)getCheckInCountStringFromHtmlResponseObject:(id)responseObject {
    
    __block NSString *checkInCountString;

    @autoreleasepool {
        
        NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *regex = @"已连续登录(.*?)天";
        NSString *countString = [htmlString stringByMatching:regex];
        countString = [countString stringByReplacingOccurrencesOfString:@"已连续登录" withString:@""];
        countString = [countString stringByReplacingOccurrencesOfString:@"天" withString:@""];
        countString = [countString stringByReplacingOccurrencesOfString:@" " withString:@""];

        if (countString.length > 0) {
            checkInCountString = countString;
        }
    }
    
    return checkInCountString;
    
}

- (NSString *)getCheckInUrlStringFromHtmlResponseObject:(id)responseObject {

    __block NSString *checkInUrlString;

    @autoreleasepool {
        
        NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        __block NSString *onceToken;
        
        NSError *error = nil;
        HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
        
        if (error) {
            NSLog(@"Error: %@", error);
        }
        
        HTMLNode *bodyNode = [parser body];

        NSArray *inputNodes = [bodyNode findChildTags:@"input"];

        [inputNodes enumerateObjectsUsingBlock:^(HTMLNode *aNode, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *hrefString = [aNode getAttributeNamed:@"onclick"];

            if (hrefString) {
                onceToken = [hrefString stringByReplacingOccurrencesOfString:@"location.href = '" withString:@""];
                onceToken = [onceToken stringByReplacingOccurrencesOfString:@"';" withString:@""];
                *stop = YES;
            }

        }];

        if (onceToken) {
            checkInUrlString = onceToken;
        }
    }
    
    return checkInUrlString;
}

/**
 *  @{
 *     p: passwordKey
 *     n: usernameKey
 *   }
 */

- (NSDictionary *)getLoginDictFromHtmlResponseObject:(id)responseObject {

    __block NSMutableDictionary *loginDict = [NSMutableDictionary new];
    
    @autoreleasepool {
        
        NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
        
        if (error) {
            NSLog(@"Error: %@", error);
        }
        
        HTMLNode *bodyNode = [parser body];

        NSArray *inputNodes = [bodyNode findChildTags:@"input"];

        [inputNodes enumerateObjectsUsingBlock:^(HTMLNode *aNode, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[aNode getAttributeNamed:@"type"] isEqualToString:@"text"]) {
                NSString *textName = [aNode getAttributeNamed:@"name"];
                if (textName) {
                    loginDict[kLoginUsername] = textName;
                }
            }
            
            if ([[aNode getAttributeNamed:@"type"] isEqualToString:@"password"]) {
                NSString *passwordName = [aNode getAttributeNamed:@"name"];
                if (passwordName) {
                    loginDict[kLoginPassword] = passwordName;
                }
            }
        }];
    }
    
    return loginDict;
}

@end
