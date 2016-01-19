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
//func flowingMenu(flowingMenu: FlowingMenuTransitionManager, widthOfMenuView menuView: UIView) -> CGFloat

- (UIColor *)colorOfElasticShapeInFlowingMenu:(FlowingMenuTransitionManager *)flowingMenu;
//func colorOfElasticShapeInFlowingMenu(flowingMenu: FlowingMenuTransitionManager) -> UIColor?

- (void)flowingMenuNeedsPresentMenu:(FlowingMenuTransitionManager *)flowingMenu;
//func flowingMenuNeedsPresentMenu(flowingMenu: FlowingMenuTransitionManager)

- (void)flowingMenuNeedsDismissMenu:(FlowingMenuTransitionManager *)flowingMenu;
//func flowingMenuNeedsDismissMenu(flowingMenu: FlowingMenuTransitionManager)
@end

