//
//  MPProfileViewController.m
//  MPWeiBo
//
//  Created by John on 16/1/14.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPProfileViewController.h"
#import "UIViewController+Utils.h"

@implementation MPProfileViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"我"];
//    [self rightBarButtonItemWithTitle:@"设置" image:nil highImage:nil target:self action:@selector(settting) forControlEvents:UIControlEventTouchUpInside];
    [self rightBarButtonItemWithTitle:@"设置" image:nil highImage:nil target:self action:@selector(settting) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *chat = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:;
//    self.navigationItem.rightBarButtonItem = chat;
}

#pragma mark - 点击设置的时候调用
- (void)settting
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
