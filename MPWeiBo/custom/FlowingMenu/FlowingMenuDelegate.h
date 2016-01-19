//
//  FlowingMenuDelegate.h
//  MPWeiBo
//
//  Created by John on 16/1/18.
//  Copyright © 2016年 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FlowingMenuTransitionManager;

@protocol FlowingMenuDelegate <NSObject>

- (CGFloat)flowingMenu:(FlowingMenuTransitionManager *)flowingMenu widthOfMenuView:(UIView *)menuView;

- (UIColor *)colorOfElasticShapeInFlowingMenu:(FlowingMenuTransitionManager *)flowingMenu;

- (void)flowingMenuNeedsPresentMenu:(FlowingMenuTransitionManager *)flowingMenu;

- (void)flowingMenuNeedsDismissMenu:(FlowingMenuTransitionManager *)flowingMenu;

@end

