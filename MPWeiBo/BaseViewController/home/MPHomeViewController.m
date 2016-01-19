//
//  MPHomeViewController.m
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPHomeViewController.h"
#import "UIViewController+Utils.h"
#import "MPTittleButton.h"
#import "MPChoiceViewController.h"
#import "MPCover.h"
#import "UIView+Frame.h"
#import <AFNetworking/AFNetworking.h>
#import "MPAccountTool.h"
#import "MPAccount.h"
#import "MPPopView.h"
#import "MJRefresh.h"
#import "MPStatusFrame.h"
#import "MPStatus.h"
#import "Macro.h"
#import "MPStatusTool.h"
#import "MPStatusCell.h"
#import "MPUserTool.h"
#import "MPUser.h"
//#import <FlowingMenuDelegate>
//#import "FlowingMenu-Swift.h"
//@import FlowingMenu;
#import "FlowingMenuTransitionManager.h"
#import "FlowingMenuTransitionManager+UIViewControllerTransitioningDelegate.h"
#import "FlowingMenuTransitionManager+UIViewControllerAnimatedTransitioning.h"
#import "FlowingMenuTransitionManager+UIGestureRecognizer.h"
#import "FlowingMenuDelegate.h"

const int navHeight = 64;

@interface MPHomeViewController ()<MPPopViewDelegate>

@property (nonatomic, strong) NSMutableArray *statusFrameArr;
@property (nonatomic, strong) MPPopView *popView;
@property (nonatomic, weak) MPTittleButton *titleButton;
@property (nonatomic, strong, nonnull) FlowingMenuTransitionManager *flowingMenuTransitionManager;

@property (nonatomic, strong) MPChoiceViewController *popVc;


@end

@implementation MPHomeViewController
- (NSMutableArray *)statusFrameArr
{
    if (_statusFrameArr == nil) {
        _statusFrameArr = [NSMutableArray array];
    }
    return _statusFrameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航条的内容
    [self setUpNavBar];
    
    // 添加刷新控件
    [self setUpRefreshView];
    
    // 开始刷新
    [[self.tableView mj_header] beginRefreshing];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.flowingMenuTransitionManager = [[FlowingMenuTransitionManager alloc] init];
    [self.flowingMenuTransitionManager setInteractivePresentationView:self.view];
    self.flowingMenuTransitionManager.delegate = self;
}

- (void)flowingMenuNeedsPresentMenu:(FlowingMenuTransitionManager *)flowingMenu {
    self.popVc  = [[MPChoiceViewController  alloc] init];
    self.popVc .transitioningDelegate = self.flowingMenuTransitionManager;
    [self.flowingMenuTransitionManager setInteractiveDismissView:self.popVc.view];
    [self presentViewController:self.popVc  animated:YES completion:nil];
}

/// You should implement this method to dismiss the menu. By default nothing happens.
- (void)flowingMenuNeedsDismissMenu:(FlowingMenuTransitionManager *)flowingMenu {
    if (self.popVc) {
        [self.popVc dismissViewControllerAnimated:YES completion:nil];
    }
}

- (CGFloat)flowingMenu:(FlowingMenuTransitionManager *)flowingMenu widthOfMenuView:(UIView *)menuView {
    return menuView.bounds.size.width * 2 / 3;
}

/// Use the menu background by default.
- (UIColor *)colorOfElasticShapeInFlowingMenu:(FlowingMenuTransitionManager *)flowingMenu {
    return [UIColor blueColor];
}



// prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    let vc                   = segue.destinationViewController
//    vc.transitioningDelegate = flowingMenuTransitionManager
//}

- (void)setUpRefreshView
{
    // 添加下拉刷新控件
    typeof(self) homeVc = self;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [homeVc loadNewStatuses];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [homeVc loadMoreStatuses];
    }];
}

- (void)loadMoreStatuses
{
    MPStatusFrame *statusF = [self.statusFrameArr lastObject];
    id maxID = nil;
    if (statusF.status.idstr) {
        maxID = @([statusF.status.idstr longLongValue] - 1);
    }
    
    [MPStatusTool moreStatusesWithID:maxID success:^(NSArray *statusFrameArr) {
        
        [self.statusFrameArr addObjectsFromArray:statusFrameArr];
        
        [self.tableView reloadData];
        [[self.tableView mj_footer] beginRefreshing];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)refresh
{
    [[self.tableView mj_header] beginRefreshing];
//    [self.tableView headerBeginRefreshing];
}


- (void)loadNewStatuses
{
    MPStatusFrame *statusF = [self.statusFrameArr firstObject];
    id sinceID = nil;
    if (statusF.status.idstr) {
        sinceID = statusF.status.idstr;
    }
    [MPStatusTool newStatusesWithID:sinceID success:^(NSArray *statusFrameArr) {
        
        // 提示最新微博数据
        NSInteger count = statusFrameArr.count;
        [self showNewStatusesCount:count];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, count)];
        [self.statusFrameArr insertObjects:statusFrameArr atIndexes:indexSet];
        
        [self.tableView reloadData];
        [[self.tableView mj_header] endRefreshing];
    } failure:^(NSError *error) {
        
    }];
    
}

// 显示最新微博数
- (void)showNewStatusesCount:(NSInteger)count
{
    if (count == 0) return;
    CGFloat labelH = 35;
    CGFloat labelW = self.view.width;
    CGFloat labelY = navHeight - labelH;
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, labelY, labelW, labelH)];
    
    statusLabel.text = [NSString stringWithFormat:@"%ld条新微博",count];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    [self.navigationController.view insertSubview:statusLabel belowSubview:self.navigationController.navigationBar];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        statusLabel.transform = CGAffineTransformMakeTranslation(0, labelY);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            statusLabel.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [statusLabel removeFromSuperview];
        }];
        
    }];
    
}


#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 创建cell
    MPStatusCell *cell = [MPStatusCell cellWithTableView:tableView];
    
    MPStatusFrame *statusF =  self.statusFrameArr[indexPath.row];
    
    cell.statusF = statusF;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MPOneViewController *one = [[MPOneViewController alloc] init];
//    one.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:one animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPStatusFrame *statusF =  self.statusFrameArr[indexPath.row];
    
    return statusF.cellHeight;
}

- (MPChoiceViewController *)popVc
{
    if (_popVc == nil) {
        MPChoiceViewController *pop = [[MPChoiceViewController alloc] init];
        _popVc = pop;
        
    }
    return _popVc;
}
- (MPPopView *)popView
{
    if (_popView == nil) {
        
        MPPopView *v = [MPPopView popView];
        v.delegate = self;
        _popView = v;
    }
    return _popView;
}

#pragma mark - 搭建界面
// 设置导航条
- (void)setUpNavBar
{
    [self leftBarButtonItemWithTitle:nil image:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self rightBarButtonItemWithTitle:nil image:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 设置titleView
    MPTittleButton *titleButton = [MPTittleButton buttonWithType:UIButtonTypeCustom];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleButton = titleButton;
    
    self.navigationItem.titleView = titleButton;
    
    // 获取标题
    NSString *screenName = [MPAccountTool account].name;
    [titleButton setTitle:@"warmap" forState:UIControlStateNormal];

    if (screenName == nil) { // 没有标题
        // 获取微博昵称
        [MPUserTool userInfoDidsuccess:^(MPUser *user) {
            
            // 保存标题昵称
            MPAccount *account = [MPAccountTool account];
            account.name = user.name;
            [MPAccountTool saveAccount:account];
            
            // 设置标题按钮
            [titleButton setTitle:user.name forState:UIControlStateNormal];
            
        } failure:^(NSError *error) {
            
        }];
        
    }else{ // 有标题
        [titleButton setTitle:screenName forState:UIControlStateNormal];
    }
}

// 点击标题的时候调用
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    //  显示菜单
    CGFloat x = (self.view.width - 200) * 0.5;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - 9;
    
    self.popView.contentView = self.popVc.view;
    
    [self.popView showInRect:CGRectMake(x, y, 200, 200)];
    
}
// popView代理
- (void)popViewDidDismiss:(MPPopView *)popView
{
    _titleButton.selected = NO;
    _popView = nil;
}

- (void)friendsearch {
    
}

- (void)pop {
    
}


@end
