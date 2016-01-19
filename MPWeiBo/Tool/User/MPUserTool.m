//
//  MPUserTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "MPUserTool.h"
#import "MPHttpTool.h"
#import "MPUserParam.h"

#import "MPAccountTool.h"
#import "MPAccount.h"
#import "MJExtension.h"
#import "MPUser.h"
#import "MPUserUnreadResult.h"
@implementation MPUserTool

+ (void)userInfoDidsuccess:(void (^)(MPUser *))success failure:(void (^)(NSError *))failure
{
    
    // 拼接参数
    MPUserParam *param = [[MPUserParam alloc] init];
    param.access_token = [MPAccountTool account].access_token;
    param.uid = [MPAccountTool account].uid;
    
    [MPHttpTool get:@"https://api.weibo.com/2/users/show.json" parameters:param.mj_keyValues success:^(id responseObject) {
        MPUser *user = [MPUser mj_objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)unreadCountDidsuccess:(void (^)(MPUserUnreadResult *))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    MPUserParam *param = [[MPUserParam alloc] init];
    param.access_token = [MPAccountTool account].access_token;
    param.uid = [MPAccountTool account].uid;
    
    [MPHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.mj_keyValues success:^(id responseObject) {
        MPUserUnreadResult *userUnread = [MPUserUnreadResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(userUnread);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
