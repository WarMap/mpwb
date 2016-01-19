//
//  FlowingMenuTransitionManager+UIGestureRecognizer.h
//  MPWeiBo
//
//  Created by John on 16/1/18.
//  Copyright © 2016年 John. All rights reserved.
//

#import "FlowingMenuTransitionManager.h"

@interface FlowingMenuTransitionManager (UIGestureRecognizer)


- (void)moveControlViewsToPoint:(CGPoint)position waveWidth:(CGFloat)waveWidth ;

- (void)updateShapeLayer;
- (CGPathRef)currentPath;
- (void)tapToDismissAction:(UITapGestureRecognizer *)tapGesture;
- (void)panToDismissAction:(UIPanGestureRecognizer *)panGesture;
- (void)panToPresentAction:(UIScreenEdgePanGestureRecognizer *)panGesture;
- (void)addTapGesture:(UIView *)view;
- (void)setInteractiveDismissView:(UIView *)view;
- (void)setInteractivePresentationView:(UIView *)view;
@end
