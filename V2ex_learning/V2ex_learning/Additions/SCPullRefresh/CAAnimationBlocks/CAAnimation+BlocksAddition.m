//
//  CAAnimation+BlocksAddition.m
//  V2ex_learning
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CAAnimation+BlocksAddition.h"


@interface CAAnimationDelegate : NSObject

@property (nonatomic, copy) void (^completion)(BOOL, CALayer *);
@property (nonatomic, copy) void (^start)(void);

- (void)animationDidStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end


@implementation CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {

    if (self.start != nil) {
        self.start();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if (self.completion != nil) {
        CALayer *layer = [anim valueForKey:@"layer"];
        self.completion(flag,layer);
    }
}


@end

@implementation CAAnimation (BlocksAddition)

- (void)setCompletion:(void (^)(BOOL, CALayer *))completion {

    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]]) {
        ((CAAnimationDelegate *)self.delegate).completion = completion;
    }else {
    
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.completion = completion;
        self.delegate = delegate;
    }
}

- (void (^)(BOOL, CALayer *))completion {

    return [self.delegate isKindOfClass:[CAAnimationDelegate class]]? ((CAAnimationDelegate *)self.delegate).completion : nil;
}


- (void)setStart:(void (^)(void))start {

    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]]) {
        ((CAAnimationDelegate *)self.delegate).start = start;
    }else {
    
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.start = start;
        self.delegate = delegate;
    }
}

- (void (^)(void))start {
    return [self.delegate isKindOfClass:[CAAnimationDelegate class]]? ((CAAnimationDelegate *)self.delegate).start: nil;
}

@end
