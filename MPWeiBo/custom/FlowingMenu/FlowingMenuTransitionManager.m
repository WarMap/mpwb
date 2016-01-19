//
//  FlowingMenuTransitionManager.m
//  MPWeiBo
//
//  Created by John on 16/1/18.
//  Copyright © 2016年 John. All rights reserved.
//

#import "FlowingMenuTransitionManager.h"
#import "FlowingMenuTransitionStatus.h"
#import "FlowingMenuDelegate.h"
#import "FlowingMenuTransitionManager+UIGestureRecognizer.h"
#import "UIView+Frame.h"


@interface FlowingMenuTransitionManager ()



@end

@implementation FlowingMenuTransitionManager

- (instancetype)init {
    if (self =  [super init]) {
        self.animationMode = Presentation;
        self.interactive = false;
        self.controlViews = @[[UIView new], [UIView new], [UIView new], [UIView new], [UIView new], [UIView new], [UIView new], [UIView new]];
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeMaskLayer = [CAShapeLayer layer];
        self.animating = false;
    }
    return self;
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateShapeLayer)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}

- (void)setAnimating:(BOOL)animating {
    _animating = animating;
    self.displayLink.paused = !animating;
}

- (void)presentMenu:(UIView *)menuView otherView:(UIView *)otherView containerView:(UIView *)containerView status:(FlowingMenuTransitionStatus *)status duration:(NSTimeInterval)duration completion:(void (^)())completion {

    UIView *ov = [otherView snapshotViewAfterScreenUpdates:YES];
    ov.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [containerView addSubview:ov];
    [containerView addSubview:menuView];
    
    [self addTapGesture:containerView];
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    menuView.layer.mask = maskLayer;
    
   id<FlowingMenuDelegate> source = self.delegate;
    CGFloat menuWidth = [source flowingMenu:self widthOfMenuView:menuView];
    CGFloat maxSideSize = MAX(menuView.bounds.size.width, menuView.bounds.size.height);
    
    CGRect beginRect   = CGRectMake(1, menuView.bounds.size.height / 2 - 1, 2, 2);
    CGRect middleRect  = CGRectMake(-menuWidth, 0, menuWidth * 2, menuView.bounds.size.height);
    CGRect endRect     = CGRectMake(-maxSideSize, menuView.bounds.size.height / 2 - maxSideSize, maxSideSize * 2, maxSideSize * 2);
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:menuView.bounds];
    [beginPath appendPath:[[UIBezierPath bezierPathWithOvalInRect:beginRect] bezierPathByReversingPath]];
    
    UIBezierPath *middlePath = [UIBezierPath bezierPathWithRect:menuView.bounds];
    [middlePath appendPath:[[UIBezierPath bezierPathWithOvalInRect:middleRect] bezierPathByReversingPath]];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:menuView.bounds];
    [endPath appendPath:[[UIBezierPath bezierPathWithOvalInRect:endRect] bezierPathByReversingPath]];
    
    // Defining the menu frame
    CGRect __block menuFrame =menuView.frame;

    menuFrame.size.width = menuWidth;
    menuView.frame       = menuFrame;
    
    // Start the animations
    if (!self.interactive) {
        CAKeyframeAnimation *bubbleAnim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
        bubbleAnim.values = @[[UIBezierPath bezierPathWithOvalInRect:beginRect],[UIBezierPath bezierPathWithOvalInRect:middleRect],[UIBezierPath bezierPathWithOvalInRect:endRect]];
        bubbleAnim.keyTimes            = @[@(0), @(0.4), @(1)];
        bubbleAnim.duration            = duration;
        bubbleAnim.removedOnCompletion = false;
        bubbleAnim.fillMode            = kCAFillModeForwards;
        [maskLayer addAnimation:bubbleAnim forKey:@"bubbleAnim"];
    }else {
        self.controlViews[7].center = CGPointMake(0, menuView.bounds.size.height);
        [self.shapeMaskLayer removeAllAnimations];
        UIColor *shapeColor;
        
        if ([source colorOfElasticShapeInFlowingMenu:self] != nil) {
            shapeColor = [source colorOfElasticShapeInFlowingMenu:self];
        }else if (menuView.backgroundColor != nil) {
            shapeColor = menuView.backgroundColor;
        }else {
            shapeColor = [UIColor blackColor];
        }
        self.shapeMaskLayer.path = [UIBezierPath bezierPathWithRect:ov.bounds].CGPath;
    
        self.shapeLayer.actions = @{@"position":[NSNull null], @"bounds":[NSNull null], @"path":[NSNull null]};
        self.shapeLayer.backgroundColor = shapeColor.CGColor;
        self.shapeLayer.fillColor = shapeColor.CGColor;
        
        self.shapeLayer.mask = self.shapeMaskLayer;
        
        [containerView.layer addSublayer:self.shapeLayer];
        
        for (UIView *view in self.controlViews) {
            [view removeFromSuperview];
            [containerView addSubview:view];
        }
    }
    containerView.userInteractionEnabled = false;
    
    [UIView animateWithDuration:duration animations:^{
        menuFrame = CGRectMake(menuFrame.origin.x, 0, menuFrame.size.width, menuFrame.size.height);
        menuView.frame = menuFrame;
        otherView.alpha = 0;
        ov.alpha = 0.4;
    } completion:^(BOOL finished) {
        if (self.interactive && ![status transitionWasCancelled]) {
            self.interactive = false;
            CAKeyframeAnimation *bubbleAnim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
            bubbleAnim.values = @[[UIBezierPath bezierPathWithOvalInRect:beginRect],[UIBezierPath bezierPathWithOvalInRect:middleRect],[UIBezierPath bezierPathWithOvalInRect:endRect]];
            bubbleAnim.keyTimes            = @[@(0), @(0.4), @(1)];
            bubbleAnim.duration            = duration;
            bubbleAnim.removedOnCompletion = false;
            bubbleAnim.fillMode            = kCAFillModeForwards;
            [maskLayer addAnimation:bubbleAnim forKey:@"bubbleAnim"];
            
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
            anim.values = @[beginPath,middlePath,endPath];
            anim.keyTimes            = @[@(0), @(0.4), @(1)];
            anim.duration            = duration;
            anim.removedOnCompletion = false;
            anim.fillMode            = kCAFillModeForwards;
            [self.shapeMaskLayer addAnimation:anim forKey:@"bubbleAnim"];
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
                for (UIView *view in self.controlViews) {
                    view.centerX = menuWidth;
                }
            } completion:^(BOOL finished) {
                [self.shapeLayer removeFromSuperlayer];
                containerView.userInteractionEnabled = YES;
                menuView.layer.mask = nil;
                self.animating = false;
                completion();
            }];
        }else {
            menuView.layer.mask = nil;
            self.animating = false;
            containerView.userInteractionEnabled = true;
            completion();
        }
    }];
}

- (void)dismissMenu:(UIView *)menuView otherView:(UIView *)otherView containerView:(UIView *)containerView status:(FlowingMenuTransitionStatus *)status duration:(NSTimeInterval )duration completion:(void (^)())completion {
    otherView.frame = containerView.bounds;
    UIView *ov = [otherView snapshotViewAfterScreenUpdates:true];
    CGRect __block menuFrame = menuView.frame;
    [containerView addSubview:otherView];
    [containerView addSubview:ov];
    [containerView addSubview:menuView];
    otherView.alpha = 0;
    ov.alpha = 0.4;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        menuFrame = CGRectMake(-menuFrame.size.width, menuFrame.origin.y, menuFrame.size.width, menuFrame.size.height);
        menuView.frame = menuFrame;
        otherView.alpha = 1;
        ov.alpha = 1;
    } completion:^(BOOL finished) {
        completion();
    }];
}
/// Returns the 2/3 menu view width.
- (CGFloat)flowingMenu:(FlowingMenuTransitionManager *)flowingMenu widthOfMenuView:(UIView *)menuView {
    return menuView.bounds.size.width * 2 / 3;
}

/// Use the menu background by default.
- (UIColor *)colorOfElasticShapeInFlowingMenu:(FlowingMenuTransitionManager *)flowingMenu {
    return [UIColor redColor];
}

/// You should implement this method to display the menu. By default nothing happens.
- (void)flowingMenuNeedsPresentMenu:(FlowingMenuTransitionManager *)flowingMenu {

}

/// You should implement this method to dismiss the menu. By default nothing happens.
- (void)flowingMenuNeedsDismissMenu:(FlowingMenuTransitionManager *)flowingMenu {

}

@end
