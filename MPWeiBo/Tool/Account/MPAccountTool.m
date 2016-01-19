//
//  MPAccountTool.m
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPAccountTool.h"
#import "MPAccount.h"
#import "MPAccountParam.h"
#import "Weibocfg.h"
#import "MPHttpTool.h"
#import <MJExtension/MJExtension.h>

#define MPAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"account.data"]

@implementation MPAccountTool

+ (void)saveAccount:(MPAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:MPAccountFile];
}

+ (MPAccount *)account
{
    MPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:MPAccountFile];
    
    // 判断是否过期，过期就返回nil
    if ([account.expires_time compare:[NSDate date]] != NSOrderedDescending) { // 过期
        return nil;
    }
    
    return account;
}

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)(MPAccount *account))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    MPAccountParam *param = [[MPAccountParam alloc] init];
    param.client_id = MPAppKey;
    param.client_secret = MPAppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = MPRedirectUrl;
     
    // 发送请求
    [MPHttpTool post:MPAccessTokenUrl parameters:param.mj_keyValues success:^(id responseObject) {
        MPAccount *account = [MPAccount accountWithDict:responseObject];
        if (success) {
            success(account);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}


@end
