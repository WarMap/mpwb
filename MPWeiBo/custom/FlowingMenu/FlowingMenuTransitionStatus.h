//
//  FlowingMenuTransitionStatus.h
//  MPWeiBo
//
//  Created by John on 16/1/18.
//  Copyright © 2016年 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FlowingMenuTransitionStatus : NSObject

- (instancetype)initWithCancelled:(BOOL)cancelled;
- (instancetype)initWithContext:(id<UIViewControllerContextTransitioning>)context;
- (BOOL)transitionWasCancelled;


@end
