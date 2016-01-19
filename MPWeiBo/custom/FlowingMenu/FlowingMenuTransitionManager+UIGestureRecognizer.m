
//
//  FlowingMenuTransitionManager+UIGestureRecognizer.m
//  MPWeiBo
//
//  Created by John on 16/1/18.
//  Copyright © 2016年 John. All rights reserved.
//

#import "FlowingMenuTransitionManager+UIGestureRecognizer.h"
#import "FlowingMenuDelegate.h"
#import "FlowingMenuTransitionManager.h"
#import <CoreGraphics/CoreGraphics.h>
#import "UIView+Utils.h"
@implementation FlowingMenuTransitionManager (UIGestureRecognizer)
/**
 Defines the given view as interactive to present the menu.
 
 - parameter view: The view used to respond to the gesture events.
 */
- (void)setInteractivePresentationView:(UIView *)view {
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] init];
    screenEdgePanGesture.edges = UIRectEdgeLeft;
    [screenEdgePanGesture addTarget:self action:@selector(panToPresentAction:)];
    [view addGestureRecognizer:screenEdgePanGesture];
}

/**
 Defines the given view as interactive to dismiss the menu.
 
 - parameter view: The view used to respond to the gesture events.
 */
- (void)setInteractiveDismissView:(UIView *)view {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
    panGesture.maximumNumberOfTouches = 1;
    [panGesture addTarget:self action:@selector(panToDismissAction:)];
    [view addGestureRecognizer:panGesture];
}

/**
 Add the tap gesture to the given view to dismiss it when a tap occurred.
 
 - parameter view: The view used to respond to the gesture events.
 */
- (void)addTapGesture:(UIView *)view {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.numberOfTapsRequired = 1;
    [tapGesture addTarget:self action:@selector(tapToDismissAction:)];
    [view addGestureRecognizer:tapGesture];
}

// MARK: - Responding to Gesture Events

/**
 The screen edge pan gesture recognizer action methods. It is used to
 present the menu.
 
 - parameter panGesture: The `UIScreenEdgePanGestureRecognizer` sender
 object.
 */
- (void)panToPresentAction:(UIScreenEdgePanGestureRecognizer *)panGesture {
    UIView *view = panGesture.view;
    CGPoint translation = [panGesture translationInView:view];
    CGFloat menuWidth;
    if (self.delegate) {
        menuWidth = [self.delegate flowingMenu:self widthOfMenuView:view];
    }else {
        menuWidth = [self flowingMenu:self widthOfMenuView:view];
    }
    
    CGFloat yLocation= [panGesture locationInView:view].y;
    CGFloat percentage = MIN(MAX(translation.x / (menuWidth / 2), 0), 1);
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactive = YES;
            [self.delegate flowingMenuNeedsPresentMenu:self];
        }
        case UIGestureRecognizerStateChanged: {
            [self updateInteractiveTransition:percentage];
            CGFloat waveWidth = translation.x * 0.9;
            CGFloat left      = waveWidth * 0.1;
            [self moveControlViewsToPoint:CGPointMake(left, yLocation) waveWidth:waveWidth];
            [self updateShapeLayer];
            break;
        }
        default:
            self.animating = true;
            if (percentage < 1) {
                [self moveControlViewsToPoint:CGPointMake(0, yLocation) waveWidth:0];
                [self cancelInteractiveTransition];
            }else {
                [self finishInteractiveTransition];
            }
    }
}

/**
 The pan gesture recognizer action methods. It is used to dismiss the
 menu.
 
 - parameter panGesture: The `UIPanGestureRecognizer` sender object.
 */

- (void)panToDismissAction:(UIPanGestureRecognizer *)panGesture {
    UIView *view = panGesture.view;
    CGPoint translation = [panGesture translationInView:view];
    CGFloat menuWidth = [self.delegate flowingMenu:self widthOfMenuView:view];
    CGFloat percentage = MIN(MAX(translation.x / menuWidth * -1, 0), 1);
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactive = true;
            [self.delegate flowingMenuNeedsDismissMenu:self];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self updateInteractiveTransition:percentage];
            break;
        }
            default:
            self.interactive = false;
            if (percentage > 0.2) {
                [self finishInteractiveTransition];
            }else {
                [self cancelInteractiveTransition];
            }
    }
}

/**
 The tap gesture recognizer action methods. It is used to dismiss the
 menu.
 
 - parameter tapGesture: The `UITapGestureRecognizer` sender object.
 */
- (void)tapToDismissAction:(UITapGestureRecognizer *)tapGesture {
    if (self.delegate) {
        [self.delegate flowingMenuNeedsDismissMenu:self];
    }
}

// MARK: - Building Paths

/**
 Returns a bezier path using the control view positions.
 
 - returns: A bezier path.
 */
- (CGPathRef)currentPath {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake([self.controlViews[0] center:self.animating].x, 0)];
    [bezierPath addCurveToPoint:[self.controlViews[2] center:self.animating] controlPoint1:[self.controlViews[0] center:self.animating] controlPoint2:[self.controlViews[1] center:self.animating]];
    [bezierPath addCurveToPoint:[self.controlViews[4] center:self.animating] controlPoint1:[self.controlViews[3] center:self.animating] controlPoint2:[self.controlViews[4] center:self.animating]];
    [bezierPath addCurveToPoint:[self.controlViews[6] center:self.animating] controlPoint1:[self.controlViews[4] center:self.animating] controlPoint2:[self.controlViews[5] center:self.animating]];
    [bezierPath addLineToPoint:CGPointMake(0, self.controlViews[7].center.y)];
    [bezierPath closePath];
    
    return bezierPath.CGPath;
}

// MARK: - Updating Shapes

/// Update the shape layer using the current control view positions.
- (void)updateShapeLayer {
    self.shapeLayer.path = [self currentPath];
}

/**
 Move the control view positions using a position and a wave width.
 
 - parameter position: The target position.
 - parameter waveWidth: The wave width in point.
 */
- (void)moveControlViewsToPoint:(CGPoint)position waveWidth:(CGFloat)waveWidth {

    CGFloat height = self.controlViews[7].center.y;
    CGFloat minTopY = MIN((position.y - height / 2) * 0.28, 0);
    CGFloat maxBottomY = MAX(height + (position.y - height / 2) * 0.28, height);
    
    CGFloat leftPartWidth  = position.y - minTopY;
    CGFloat rightPartWidth = maxBottomY - position.y;
    
    self.controlViews[0].center = CGPointMake(position.x, minTopY);
    self.controlViews[1].center = CGPointMake(position.x, minTopY + leftPartWidth * 0.44);
    self.controlViews[2].center = CGPointMake(position.x + waveWidth * 0.64, minTopY + leftPartWidth * 0.71);
    self.controlViews[3].center = CGPointMake(position.x + waveWidth * 1.36, position.y);
    self.controlViews[4].center = CGPointMake(position.x + waveWidth * 0.64, maxBottomY - rightPartWidth * 0.71);
    self.controlViews[5].center = CGPointMake(position.x,maxBottomY - (rightPartWidth * 0.44));
    self.controlViews[6].center = CGPointMake(position.x,height);
}
@end
