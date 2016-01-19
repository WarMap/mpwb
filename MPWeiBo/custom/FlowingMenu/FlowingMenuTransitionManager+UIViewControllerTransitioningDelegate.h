//
//  FlowingMenuTransitionManager+UIViewControllerTransitioningDelegate.h
//  MPWeiBo
//
//  Created by John on 16/1/19.
//  Copyright © 2016年 John. All rights reserved.
//

#import "FlowingMenuTransitionManager.h"

@interface FlowingMenuTransitionManager (UIViewControllerTransitioningDelegate)<UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
- (id<UIViewControllerAnimatedTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator;
- (id<UIViewControllerAnimatedTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator;
@end
