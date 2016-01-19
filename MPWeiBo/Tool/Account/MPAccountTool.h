//
//  MPAccountTool.h
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPAccount;
@interface MPAccountTool : NSObject

+ (void)saveAccount:(MPAccount *)account;

+ (MPAccount *)account;

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)(MPAccount *account))success failure:(void (^)(NSError *))failure;
@end
