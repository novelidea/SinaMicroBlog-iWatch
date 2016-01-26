//
//  MBTransformInfo.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/15/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBTransformInfo.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "MBAccount.h"

@interface MBTransformInfo () <WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;

@end

@implementation MBTransformInfo

- (void)initialize{
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
}

- (void)transferAccount:(MBAccount *)account{
    [self.session sendMessage:[MBAccount dicWithAccount:account] replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
}


@end
