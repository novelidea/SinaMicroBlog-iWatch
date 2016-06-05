//
//  MBOAuthController.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBOAuthController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "MBAccount.h"
#import "MBAccountTool.h"
#import "MBMainViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "MBRootTool.h"
#import "MBAccountTransferController.h"

#define XPFBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define XPFClient_id @"1196253863"
#define XPFRedirect_url @"http://www.pengfeixing.com"
#define XPFClient_secrete @"c8d6454613cb54d886e5500c1c35f67d"

#define MBKeyWindow [UIApplication sharedApplication].keyWindow

@interface MBOAuthController () <UIWebViewDelegate, WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;
@property (nonatomic, retain) UIWebView* web;

@end


@implementation MBOAuthController

- (UIWebView *)web{
    if (nil == _web) {
        _web = [[UIWebView alloc] initWithFrame:self.view.frame];
    }
    return _web;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:self.web];
    
    if(self.web == nil){
        NSLog(@"NIL ");
    }
    
    NSLog(@"LOG OUT SUCCESS 2");
    

    
    //weibo
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"1196253863";
    NSString *redirect_uri=@"http://www.pengfeixing.com";
    
    //qq
    //NSString *client_id_qq = @"1104850437";
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [_web loadRequest:request];
    _web.delegate = self;
    
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"started");
    [MBProgressHUD showMessage:@"正在加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"HUD finished");
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"HUD failed");
    [MBProgressHUD hideHUD];
//    [_web setDelegate:nil];
//    [_web stopLoading];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_web setDelegate:nil];
    [_web stopLoading];
}

//- (void)dealloc{
//    [_web setDelegate:nil];
//    [_web stopLoading];
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)accessTokenWithCode:(NSString *)code{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"client_id"]=XPFClient_id;
    parameter[@"client_secret"]=XPFClient_secrete;
    parameter[@"grant_type"]=@"authorization_code";
    parameter[@"code"]=code;
    parameter[@"redirect_uri"]=XPFRedirect_url;
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MBAccount *account = [MBAccount accountWithDict:responseObject];
        
//        NSLog(@"account data is:\n%@\n%@\n%@\n%@\n%@\n", account.access_token, account.expires_in, account.remind_in, account.uid, account.expires_in);

        [MBAccountTool saveAccount:account];
//        MBAccount *accountTest = [MBAccountTool account];
        
//        NSLog(@"file data is:\n%@\n%@\n%@\n%@\n%@\n", accountTest.access_token, accountTest.expires_in, accountTest.remind_in, accountTest.uid, accountTest.expires_date);

        
        [MBRootTool chooseRootViewController:MBKeyWindow];
        
        [self sendInfo:responseObject];
//        MBInfoTranslateController *translateVC = [[MBInfoTranslateController alloc] init];
//        [translateVC sendInfo:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)sendInfo:(NSDictionary *)dic{
    [self.session sendMessage:dic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
//        MBAccount *account = [MBAccount accountWithDict:dic];
//        [MBAccountTool saveAccount:account];
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
}


//- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
//    NSLog(@"receive");
//    if ([MBAccountTool account]) {
//        MBAccount *account = [MBAccountTool account];
//        [self sendInfo:[MBAccount dicWithAccount:account]];
//    }
//    
//}


@end
