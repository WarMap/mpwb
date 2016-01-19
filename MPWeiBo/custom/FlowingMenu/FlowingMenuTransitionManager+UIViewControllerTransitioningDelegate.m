//
//  FlowingMenuTransitionManager+UIViewControllerTransitioningDelegate.m
//  MPWeiBo
//
//  Created by John on 16/1/19.
//  Copyright © 2016年 John. All rights reserved.
//

#import "FlowingMenuTransitionManager+UIViewControllerTransitioningDelegate.h"
#import "FlowingMenuTransitionManager+UIViewControllerAnimatedTransitioning.h"

@implementation FlowingMenuTransitionManager (UIViewControllerTransitioningDelegate)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animationMode = Presentation;
    return self;
}

/**
 Asks the flowing menu transition manager for the transition animator object to
 use when dismissing a view controller.
 
 It returns itself.
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animationMode = Dismissal;
    return self;
}

/**
 Asks the flowing menu transition manager for the interactive animator object to
 use when presenting a view controller.
 */
- (id<UIViewControllerAnimatedTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    self.animationMode = Presentation;
    return self.interactive ? self : nil;
}

/**
 Asks the flowing menu transition manager for the interactive animator object to
 use when dismissing a view controller.
 */
- (id<UIViewControllerAnimatedTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    self.animationMode = Dismissal;
    return self.interactive ? self : nil;
}

@end
