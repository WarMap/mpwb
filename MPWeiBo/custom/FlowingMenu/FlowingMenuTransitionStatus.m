//
//  FlowingMenuTransitionStatus.m
//  MPWeiBo
//
//  Created by John on 16/1/18.
//  Copyright © 2016年 John. All rights reserved.
//

#import "FlowingMenuTransitionStatus.h"

@interface FlowingMenuTransitionStatus()

@property (nonatomic, assign) BOOL cancelled;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> context;

@end

@implementation FlowingMenuTransitionStatus

// MARK: - Initializing a TransitionStatus Object

/// Initializer for testing purpose.
- (instancetype)initWithCancelled:(BOOL)cancelled {
    if (self = [super init]) {
        self.context = nil;
        self.cancelled = cancelled;
    }
    return self;
}


/// Initializer for running purpose.
- (instancetype)initWithContext:(id<UIViewControllerContextTransitioning>)context {
    if (self = [super init]) {
        self.context = context;
        self.cancelled = false;
    }
    return self;
}

// MARK: - Reporting the Transition Progress

/**
 Returns a Boolean value indicating whether the transition was canceled.
 
 true if the transition was canceled or false if it is ongoing or finished
 normally.
 
 - returns: true if the transition was canceled or NO if it is ongoing or
 finished normally.
 */
- (BOOL)transitionWasCancelled {
    if (self.context) {
        return [self.context transitionWasCancelled];
    }else {
        return self.cancelled;
    }
}
@end
