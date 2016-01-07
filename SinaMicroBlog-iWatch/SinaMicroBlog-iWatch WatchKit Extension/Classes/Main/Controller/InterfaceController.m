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
#import "MBStatus.h"
#import "MJExtension.h"


#import "MBUser.h"
#import "MBMainRowView.h"
#import "MBUser.h"

@interface InterfaceController() <WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;
@property (nonatomic, strong) MBAccount* account;
@property (nonatomic, strong) NSMutableArray* statuses;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *statusTable;
- (IBAction)refresh;
- (IBAction)loadMoreStatus;

@end


@implementation InterfaceController

- (MBAccount *)account{
    if(nil == _account){
        _account = [[MBAccount alloc] init];
    }
    return _account;
}

- (NSMutableArray *)statuses{
    if (nil == _statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
    

    [self.statusTable setNumberOfRows:20 withRowType:@"statusRow"];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}


- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    NSLog(@"apple watch data is: \n%@", message);
    _account = [MBAccount accountWithDict:message];
    [self loadNewStatus];
//    NSLog(@"result is:\n%@\n%@\n%@\n%@\n%@\n", _account.access_token, _account.expires_in, _account.remind_in, _account.uid, _account.expires_date);
}

- (void)loadNewStatus{
    NSString *urlStringBase = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", urlStringBase, _account.access_token];
//    NSLog(@"accesstoken is: %@", _account.access_token);
    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"url is:\n %@", url);
    NSURLSession *urlSession = [NSURLSession sharedSession];
    [[urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            NSArray* statusArray = [json objectForKey:@"statuses"];
//            NSLog(@"apple watch result is:\n%@", statusArray);
            [self.statuses removeAllObjects];
//            NSLog(@"number is: %d", self.statuses.count);
            
            for (NSDictionary *dic in statusArray) {
                MBStatus *status = [MBStatus objectWithKeyValues:dic];
                [self.statuses addObject:status];
            }
            
//            NSLog(@"number is: %d", self.statuses.count);
            
//            int statusCount = 0;
//            for (MBStatus* status in self.statuses) {
//                if (statusCount ++ >= 20) {
//                    break;
//                }
//                MBUser* user = status.user;
//                NSLog(@"%@\n", user.name);
//            }
            
            [self dataDownLoaded];
            
//            [self.tableView reloadData];
        }else{
            NSLog(@"error is: %@", error);
        }
    }] resume];
    
}

- (void)dataDownLoaded{
    [self.statusTable setNumberOfRows:0 withRowType:@"MainRow"];
    [self.statusTable setNumberOfRows:self.statuses.count withRowType:@"MainRow"];
    
    for(int i = 0; i < self.statuses.count; i ++){
        MBStatus *status = [self.statuses objectAtIndex:i];
        MBMainRowView *mainRow = [self.statusTable rowControllerAtIndex:i];
        [mainRow.username setText:status.user.name];
        [mainRow.postTime setText:status.created_at];
        [mainRow.content setText:status.text];
//        [mainRow.profileImage setImage:[UIImage imageNamed:@"avatar_default"]];

        NSURL *url = [NSURL URLWithString:status.user.profile_image_url];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if ( data == nil ){
                //                NSLog(@"pic data is nil");
                NSLog(@"error is: %@", error);
                return;
            }
//            NSLog(@"data is: %@", data);
            //            NSLog(@"%@", status.user.profile_image_url);
            dispatch_async(dispatch_get_main_queue(), ^{
                [mainRow.profileImage setImage:[UIImage imageWithData:data]];
            });
        }] resume];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
//            NSURL *url = [NSURL URLWithString:status.user.profile_image_url];
//            
//            NSURLSession *session = [NSURLSession sharedSession];
//            [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                if ( data == nil ){
//                    //                NSLog(@"pic data is nil");
//                    NSLog(@"error is: %@", error);
//                    return;
//                }
//                NSLog(@"data is: %@", data);
//                UIImage *image = [UIImage imageWithData:data];
//                [mainRow.profileImage setImage:image];
//                //            NSLog(@"%@", status.user.profile_image_url);
////                dispatch_async(dispatch_get_main_queue(), ^{
////                    [mainRow.profileImage setImage:[UIImage imageWithData:data]];
////                });
//            }];
        
//            NSError *error = nil;
//            NSData * data = [[NSData alloc] initWithContentsOfURL:url options:0 error:&error];
////            NSData *data = [NSData dataWithContentsOfURL:url];
//            if ( data == nil ){
////                NSLog(@"pic data is nil");
//                NSLog(@"error is: %@", error);
//                return;
//            }
////            NSLog(@"%@", status.user.profile_image_url);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [mainRow.profileImage setImage:[UIImage imageWithData:data]];
//            });
//        });
        
    }

}

//UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 80, 100, 100)];
//NSURL *url = [NSURL URLWithString:@"http://cc.cocimg.com/bbs/3g/img/ccicon.png"];
//NSData *data = [NSData dataWithContentsOfURL:url];
//UIImage *image = [[UIImage alloc] initWithData:data];
//imageView.image = image;
//[self.view addSubview:imageView];
//

//- (void)loadNewStatus2{
//    
//    NSString *urlStringBase = @"https://api.weibo.com/2/statuses/friends_timeline.json";
//    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", urlStringBase, _account.access_token];
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (data != nil) {
//            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
//                                                                 options:kNilOptions
//                                                                   error:&error];
//            NSArray* statusArray = [json objectForKey:@"statuses"];
//            NSLog(@"apple watch result is:\n%@", statusArray);
//            //        for (NSDictionary *dic in statusArray) {
//            //                XPFStatus *status = [XPFStatus objectWithKeyValues:dic];
//            //                [self.statuses addObject:status];
//            //        }
//            //                [self.tableView reloadData];
//        }else{
//            NSLog(@"data is nil");
//        }
//    }] resume];
//    
//    
//    
//
//}
//
- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (IBAction)refresh {
    [self loadNewStatus];
}

- (IBAction)loadMoreStatus {
}
@end



