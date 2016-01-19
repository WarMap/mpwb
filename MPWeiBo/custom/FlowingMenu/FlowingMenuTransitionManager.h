//
//  FlowingMenuTransitionManager.h
//  MPWeiBo
//
//  Created by John on 16/1/18.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "FlowingMenuDelegate.h"
@class FlowingMenuTransitionStatus;

typedef NS_ENUM(NSInteger, AnimationMode) {
    Presentation,    //Present the menu mode.
    Dismissal        //Dismiss the menu mode.
};


@interface FlowingMenuTransitionManager : UIPercentDrivenInteractiveTransition<FlowingMenuDelegate>
@property (nonatomic, weak) id<FlowingMenuDelegate> delegate;
@property (nonatomic, assign) AnimationMode animationMode;
@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, strong) NSArray<UIView *> *controlViews;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *shapeMaskLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL animating;
- (void)presentMenu:(UIView *)menuView otherView:(UIView *)otherView containerView:(UIView *)containerView status:(FlowingMenuTransitionStatus *)status duration:(NSTimeInterval)duration completion:(void (^)())completion ;
- (void)dismissMenu:(UIView *)menuView otherView:(UIView *)otherView containerView:(UIView *)containerView status:(FlowingMenuTransitionStatus *)status duration:(NSTimeInterval )duration completion:(void (^)())completion ;

- (CGFloat)flowingMenu:(FlowingMenuTransitionManager *)flowingMenu widthOfMenuView:(UIView *)menuView;

/// Use the menu background by default.
- (UIColor *)colorOfElasticShapeInFlowingMenu:(FlowingMenuTransitionManager *)flowingMenu;

/// You should implement this method to display the menu. By default nothing happens.
- (void)flowingMenuNeedsPresentMenu:(FlowingMenuTransitionManager *)flowingMenu;

/// You should implement this method to dismiss the menu. By default nothing happens.
- (void)flowingMenuNeedsDismissMenu:(FlowingMenuTransitionManager *)flowingMenu;
@end
