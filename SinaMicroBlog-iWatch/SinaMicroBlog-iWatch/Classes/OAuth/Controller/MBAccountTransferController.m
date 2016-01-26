//
//  MBAccountTransferController.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/15/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBAccountTransferController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "MBAccount.h"

@interface MBAccountTransferController () <WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;

@end

@implementation MBAccountTransferController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transferAccount:(MBAccount *)account{
    [self.session sendMessage:[MBAccount dicWithAccount:account] replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
}

//- (void)sendInfo:(NSDictionary *)dic{
//    [self.session sendMessage:dic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
//        
//    } errorHandler:^(NSError * _Nonnull error) {
//        
//    }];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
