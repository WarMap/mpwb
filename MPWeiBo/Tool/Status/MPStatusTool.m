//
//  MPStatusTool.m
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPStatusTool.h"
#import "MPStatusParam.h"
#import "MPAccountTool.h"
#import "MPAccount.h"
#import "MPStatusCacheTool.h"
#import "MPStatus.h"
#import "MPStatusFrame.h"
#import "MPHttpTool.h"
#import "MJExtension.h"
#import "MPStatusResult.h"

@implementation MPStatusTool
+ (void)moreStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    MPStatusParam *param = [[MPStatusParam alloc] init];
    param.access_token = [MPAccountTool account].access_token;
    param.max_id = ID;
    
    // 加载缓存数据
    NSArray *statuses =  [MPStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (MPStatus *status in statuses) {
            MPStatusFrame *statusF = [[MPStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
        // 不需要在发送请求
        return;
    }
    
    
    // 发送请求
    [MPHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
        // 存储数据
        [MPStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        MPStatusResult *result = [MPStatusResult mj_objectWithKeyValues:responseObject];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (MPStatus *status in result.statuses) {
            MPStatusFrame *statusF = [[MPStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)newStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    MPStatusParam *param = [[MPStatusParam alloc] init];
    param.access_token = [MPAccountTool account].access_token;
    param.since_id = ID;
    
#warning  先从缓存中获取数据
    //    NSArray *statuses =  [MPStatusCacheTool statusesWithParam:param];
    //    if (statuses.count) {
    //
    //        NSMutableArray *arrM = [NSMutableArray array];
    //        for (MPStatus *status in statuses) {
    //            MPStatusFrame *statusF = [[MPStatusFrame alloc] init];
    //            statusF.status = status;
    //            [arrM addObject:statusF];
    //        }
    //        if (success) {
    //            success(arrM);
    //        }
    //
    //        // 不需要在发送请求
    //        return;
    //    }
    
    
    // 发送请求
    [MPHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
#warning  存储数据
        [MPStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        MPStatusResult *result = [MPStatusResult mj_objectWithKeyValues:responseObject];
        
        NSDictionary *plist = result.mj_keyValues;
        [plist writeToFile:@"/Users/yuanzheng/Desktop/status.plist" atomically:YES];
        
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in result.statuses) {
            MPStatus *status = [MPStatus mj_objectWithKeyValues:dic];
            MPStatusFrame *statusF = [[MPStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
