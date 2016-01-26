//
//  MBMainViewController.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBMainViewController.h"
#import "MBNewFeatureController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "MBAccountTool.h"
#import "MBAccount.h"
#import "MBOAuthController.h"

#import "MBRootTool.h"

#define MBKeyWindow [UIApplication sharedApplication].keyWindow


@interface MBMainViewController () <WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;

@end

@implementation MBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 3, self.view.frame.size.width, 50)];
    label.text = @"请打开Apple Watch开启微博之旅";
    label.font = [UIFont systemFontOfSize:24];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    UIButton *newFeatureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newFeatureBtn setTitle:@"查看新特性" forState:UIControlStateNormal];
    [newFeatureBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [newFeatureBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [newFeatureBtn sizeToFit];
    [newFeatureBtn addTarget:self action:@selector(backToNewFeature) forControlEvents:UIControlEventTouchUpInside];
//    newFeatureBtn.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.675);
    newFeatureBtn.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.8);
    [self.view addSubview:newFeatureBtn];
    
    
//    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [logOutBtn setTitle:@"退出" forState:UIControlStateNormal];
//    [logOutBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
//    [logOutBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
//    [logOutBtn sizeToFit];
//    [logOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
//    logOutBtn.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.80);
//    [self.view addSubview:logOutBtn];

    
}

//- (void)logOut{
//    
//    NSString *baseUrlString = @"https://api.weibo.com/oauth2/revokeoauth2";
//    
//    MBAccount *account = [MBAccountTool account];
//    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", baseUrlString, account.access_token];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"LOG OUT");
//    NSURLSession *urlSession = [NSURLSession sharedSession];
//    [[urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
////        MBOAuthController *oauthVC = [[MBOAuthController alloc] init];
////        MBKeyWindow.rootViewController = oauthVC;
////        [MBRootTool chooseRootViewController:MBKeyWindow];
//
//        NSLog(@"LOG OUT SUCCESS");
//    }] resume];
//    NSLog(@"LOG OUT 2");
//}




- (void)backToNewFeature{
     MBNewFeatureController *nfVC = [[MBNewFeatureController alloc] init];
     MBKeyWindow.rootViewController = nfVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    NSLog(@"receive");
    if ([MBAccountTool account]) {
        MBAccount *account = [MBAccountTool account];
        NSDictionary *dic = [[NSDictionary alloc] init];
        dic = [MBAccount dicWithAccount:account];
        NSLog(@"%@",dic);
        [self sendInfo:dic];
    }

}

- (void)sendInfo:(NSDictionary *)dic{
    [self.session sendMessage:dic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
//                MBAccount *account = [MBAccount accountWithDict:dic];
        //        [MBAccountTool saveAccount:account];
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
