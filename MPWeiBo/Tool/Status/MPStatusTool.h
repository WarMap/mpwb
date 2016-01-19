//
//  MPStatusTool.h
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPStatusTool : NSObject
+ (void)newStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *error))failure;

+ (void)moreStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *error))failure;

@end
