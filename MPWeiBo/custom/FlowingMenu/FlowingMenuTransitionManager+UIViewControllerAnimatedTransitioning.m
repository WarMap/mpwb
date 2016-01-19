
//
//  FlowingMenuTransitionManager+UIViewControllerAnimatedTransitioning.m
//  MPWeiBo
//
//  Created by John on 16/1/19.
//  Copyright © 2016年 John. All rights reserved.
//

#import "FlowingMenuTransitionManager+UIViewControllerAnimatedTransitioning.h"
#import "FlowingMenuTransitionManager.h"
#import "FlowingMenuTransitionStatus.h"

@implementation FlowingMenuTransitionManager (UIViewControllerAnimatedTransitioning)
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)context {
    UIViewController *fromVC = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [context viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [context containerView];
    UIView *menuView = (self.animationMode == Presentation) ? toVC.view : fromVC.view;
    UIView *otherView = (self.animationMode == Presentation) ? fromVC.view : toVC.view;
    FlowingMenuTransitionStatus *status = [[FlowingMenuTransitionStatus alloc] initWithContext:context];
    if (self.animationMode == Presentation) {
        [self presentMenu:menuView otherView:otherView containerView:containerView status:status duration:[self transitionDuration:context] completion:^{
            [context completeTransition:![context transitionWasCancelled]];
        }];
    }else {
        [self dismissMenu:menuView otherView:otherView containerView:containerView status:status duration:[self transitionDuration:context] completion:^{
            [context completeTransition:![context transitionWasCancelled]];
        }];
    }
}

/**
 Asks your animator object for the duration (in seconds) of the transition
 animation.
 
 The context object containing information to use during the transition.
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)context {
    return self.interactive ? 0.5 : 0.2;
}
@end
