//
//  MPUserTool.h
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MPUser,MPUserUnreadResult;
@interface MPUserTool : NSObject

+ (void)userInfoDidsuccess:(void (^)(MPUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)unreadCountDidsuccess:(void (^)(MPUserUnreadResult *user))success failure:(void (^)(NSError *error))failure;

@end
