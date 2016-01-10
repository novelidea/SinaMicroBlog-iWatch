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


#define XPFBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define XPFClient_id @"1196253863"
#define XPFRedirect_url @"http://www.pengfeixing.com"
#define XPFClient_secrete @"c8d6454613cb54d886e5500c1c35f67d"

#define MBKeyWindow [UIApplication sharedApplication].keyWindow

@interface MBOAuthController () <UIWebViewDelegate, WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;

@end


@implementation MBOAuthController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:web];
    
    
    //weibo
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"1196253863";
    NSString *redirect_uri=@"http://www.pengfeixing.com";
    
    //qq
    //NSString *client_id_qq = @"1104850437";
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [web loadRequest:request];
    web.delegate = self;
    
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
}

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
/**
 请求参数
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 **/
- (void)accessTokenWithCode:(NSString *)code{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"client_id"]=XPFClient_id;
    parameter[@"client_secret"]=XPFClient_secrete;
    parameter[@"grant_type"]=@"authorization_code";
    parameter[@"code"]=code;
    parameter[@"redirect_uri"]=XPFRedirect_url;
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"iphone data is: \n%@",responseObject);
        
        MBAccount *account = [MBAccount accountWithDict:responseObject];

        [MBAccountTool saveAccount:account];
        
//        MBMainViewController *mainVC = [[MBMainViewController alloc] init];
//        MBKeyWindow.rootViewController = mainVC;
        
        
        [MBRootTool chooseRootViewController:MBKeyWindow];
        
        [self sendInfo:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)sendInfo:(NSDictionary *)dic{
    [self.session sendMessage:dic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
}

@end
