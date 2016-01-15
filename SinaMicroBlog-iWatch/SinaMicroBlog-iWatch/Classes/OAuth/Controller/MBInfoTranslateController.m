//
//  MBInfoTranslateController.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/10/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBInfoTranslateController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface MBInfoTranslateController ()<WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;

@end

@implementation MBInfoTranslateController

- (void)viewDidLoad {
    [super viewDidLoad];
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
}


- (void)sendInfo:(NSDictionary *)dic{
    [self.session sendMessage:dic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
