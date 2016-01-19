//
//  MPHomeViewController.h
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowingMenuDelegate.h"

@interface MPHomeViewController : UITableViewController<FlowingMenuDelegate>

- (void)refresh;

@end
