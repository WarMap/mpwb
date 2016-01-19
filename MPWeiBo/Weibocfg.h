//
//  Weibocfg.h

//
//  Created by  on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//
#import <Foundation/Foundation.h>
// extern声明一个变量，就会自动去查找，对应的只读变量的值
extern NSString *const MPAppKey;
extern NSString *const MPAppSecret;
extern NSString *const MPRedirectUrl;

extern NSString *const MPAccessTokenUrl;

/**
 *  登录网页URL
 *
 */
#define MPResquestTokeURLStr  [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",MPAppKey,MPRedirectUrl]
