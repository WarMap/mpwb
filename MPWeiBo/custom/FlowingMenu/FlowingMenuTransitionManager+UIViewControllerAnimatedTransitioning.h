//
//  FlowingMenuTransitionManager+UIViewControllerAnimatedTransitioning.h
//  MPWeiBo
//
//  Created by John on 16/1/19.
//  Copyright © 2016年 John. All rights reserved.
//

#import "FlowingMenuTransitionManager.h"
#import <UIKit/UIKit.h>
@interface FlowingMenuTransitionManager (UIViewControllerAnimatedTransitioning)<UIViewControllerAnimatedTransitioning>

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)context;
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)context;


@end
