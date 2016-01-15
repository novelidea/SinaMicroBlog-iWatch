//
//  MBLoginController.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/14/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBLoginController.h"
#import "MBWKAccountTool.h"
#import <WatchConnectivity/WatchConnectivity.h>

#import "MBAccount.h"
#import "MBAccountTool.h"

@interface MBLoginController () <WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;
@property (nonatomic, strong) NSTimer *autoTimer;

@end

@implementation MBLoginController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"login controller controller id is: %@", [self valueForKey:@"_viewControllerID"]);
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
//    while (![MBWKAccountTool account]) {
//        
//    }
//    NSMutableArray *controllerName = [NSMutableArray array];
//    [controllerName addObject:@"InterfaceController"];
//    [WKInterfaceController reloadRootControllersWithNames:controllerName contexts:nil];
    self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkAccount) userInfo:nil repeats:YES];
}

- (void)checkAccount{
    NSLog(@"check Account");
    if ([MBWKAccountTool account]) {
        [self.autoTimer invalidate];
        self.autoTimer = nil;
//        [self popToRootController];
        NSMutableArray *controllerName = [NSMutableArray array];
        [controllerName addObject:@"InterfaceController"];
        [WKInterfaceController reloadRootControllersWithNames:controllerName contexts:nil];
    }
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    //    NSLog(@"apple watch data is: \n%@", message);
//    _account = [MBAccount accountWithDict:message];
    
    [MBWKAccountTool saveAccount:[MBAccount accountWithDict:message]];
    
    NSLog(@"now test file account");
//    MBAccount *test = [MBWKAccountTool account];
    //    NSLog(@"result is:\n%@\n%@\n%@\n%@\n%@\n", test.access_token, test.expires_in, test.remind_in, test.uid, test.expires_date);
    NSLog(@"TEST END");
//    [self loadNewStatus];
    //    NSLog(@"result is:\n%@\n%@\n%@\n%@\n%@\n", _account.access_token, _account.expires_in, _account.remind_in, _account.uid, _account.expires_date);
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
//    NSMutableArray *controllerName = [NSMutableArray array];
//    [controllerName addObject:@"MainController"];
//    [WKInterfaceController reloadRootControllersWithNames:controllerName contexts:nil];
}

@end



