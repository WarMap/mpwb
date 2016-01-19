//
//  MPChoiceViewController.m
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPChoiceViewController.h"
@interface MPChoiceViewController()

@property (nonatomic, strong) NSArray *datas;

@end

@implementation MPChoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _datas = @[@"好友圈",@"我的微博",@"周边微博"];
    self.view.backgroundColor = [UIColor redColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = _datas[indexPath.row];
    
    return cell;
}

@end
