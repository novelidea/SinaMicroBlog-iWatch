//
//  InterfaceController.m
//  SinaMicroBlog-iWatch WatchKit Extension
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "MBAccount.h"

@interface InterfaceController() <WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
    

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

//@property (nonatomic, copy) NSString *access_token;
//@property (nonatomic, copy) NSString *expires_in;
//@property (nonatomic, copy) NSString *remind_in;
//@property (nonatomic, copy) NSString *uid;
//@property (nonatomic, strong) NSDate *expires_date;

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    NSLog(@"apple watch data is: \n%@", message);
    MBAccount *account = [[MBAccount alloc] init];
    account = [MBAccount accountWithDict:message];
    NSLog(@"result is:\n%@\n%@\n%@\n%@\n%@\n", account.access_token, account.expires_in, account.remind_in, account.uid, account.expires_date);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


@end



