//
//  MPOAuthViewController.m
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPOAuthViewController.h"
#import "Weibocfg.h"
#import "MPAccount.h"
#import "UIViewController+Utils.h"
#import "MPAccountTool.h"
#import "MPGuideTool.h"
#import "Macro.h"

@interface MPOAuthViewController()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end
@implementation MPOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:MPResquestTokeURLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
}

#pragma mark - webViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlStr = request.URL.absoluteString;
    
    
    // 获取requestToken
   NSRange range = [urlStr rangeOfString:@"code="];
   if (range.length > 0) {
       NSString *code = [urlStr substringFromIndex:range.location + range.length];
       [self accessTokenWithCode:code];
       return NO;
   }
    
    return YES;
    
}

/*
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 
 */

- (void)accessTokenWithCode:(NSString *)code
{
    // 获取accessToken
    [MPAccountTool accessTokenWithCode:code success:^(MPAccount *account) {
        // 保存账号
        [MPAccountTool saveAccount:account];
        
        // 选择跟控制器
        [MPGuideTool guideRootViewController:MPKeyWindow];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHud:@"正在登录ing....."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self dismiss];
    NSLog(@"%@",error);
}

@end
