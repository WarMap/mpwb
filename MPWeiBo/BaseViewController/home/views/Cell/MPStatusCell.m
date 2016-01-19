//
//  MPStatusCell.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "MPStatusCell.h"

#import "MPOriginalView.h"
#import "MPRetweetedView.h"
#import "MPToolBarView.h"

#import "MPStatus.h"
#import "MPStatusFrame.h"

@interface MPStatusCell ()

@property (nonatomic, weak) MPOriginalView *originalView;
@property (nonatomic, weak) MPRetweetedView *retweetedView;
@property (nonatomic, weak) MPToolBarView *toolBar;
@end

@implementation MPStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllSubviews];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setUpAllSubviews
{
    // 添加原创微博
    MPOriginalView *originalView = [[MPOriginalView alloc] init];
    [self.contentView addSubview:originalView];
    _originalView = originalView;
    
    // 添加转发微博
    MPRetweetedView *retweetedView = [[MPRetweetedView alloc] init];
    [self.contentView addSubview:retweetedView];
    _retweetedView = retweetedView;
    
    // 添加工具条
    MPToolBarView *toolBar = [[MPToolBarView alloc] init];
    
    [self.contentView addSubview:toolBar];
    _toolBar = toolBar;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    MPStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[MPStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setStatusF:(MPStatusFrame *)statusF
{
    _statusF = statusF;
    
    MPStatus *status = statusF.status;
    
    // 设置原创微博
    _originalView.statusF = statusF;
    
    if (status.retweeted_status) {
        
        // 设置转发微博
        _retweetedView.statusF = statusF;
        _retweetedView.hidden = NO;
    }else{
        _retweetedView.hidden = YES;
    }
    
    // 设置工具条的位置
    _toolBar.status = status;
    _toolBar.frame = statusF.toolBarViewF;
    
    
}

@end
