//
//  InterfaceController.m
//  SinaMicroBlog-iWatch WatchKit Extension
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "InterfaceController.h"
//#import <WatchConnectivity/WatchConnectivity.h>
#import "MBAccount.h"
#import "MBStatus.h"
#import "MJExtension.h"


#import "MBUser.h"
#import "MBMainRowView.h"
#import "MBUser.h"

#import "MBDetailInterfaceController.h"
#import "MBTransferParameter.h"
#import "MBWKAccountTool.h"

@interface InterfaceController()

//@property (nonatomic, strong) WCSession* session;
@property (nonatomic, strong) MBAccount* account;
@property (nonatomic, strong) NSMutableArray* statuses;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *statusTable;
- (IBAction)refresh;
- (IBAction)more;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *refreshButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *moreButton;


@property (nonatomic, assign) int finishCount;

@property (nonatomic, assign) BOOL loadPic;
@end


@implementation InterfaceController

- (MBAccount *)account{
    if(nil == _account){
        _account = [[MBAccount alloc] init];
    }
    if ([MBWKAccountTool account]) {
        _account = [MBWKAccountTool account];
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
    
//    if (context != nil) {
//        self.account = context;
//    }
//    NSLog(@"interface controller controller id is: %@", [self valueForKey:@"_viewControllerID"]);
    
//    if (nil == self.account || nil == self.account.access_token) {
    if (nil == [MBWKAccountTool account]) {
       
//        [self pushControllerWithName:@"LoginController" context:nil];
//
        NSMutableArray *controllerName = [NSMutableArray array];
        [controllerName addObject:@"LoginController"];
        [WKInterfaceController reloadRootControllersWithNames:controllerName contexts:nil];
    }else{
//        [self.statusTable setNumberOfRows:20 withRowType:@"statusRow"];
        [self loadNewStatus];
    }

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}


- (void)loadNewStatus{
    [self.statusTable setNumberOfRows:0 withRowType:@"MainRow"];
    [self.refreshButton setEnabled:false];
    [self.moreButton setEnabled:false];
    
//    NSLog(@"load new status");
//    NSLog(@"load accesstoken is: %@", self.account.access_token);
    NSString *urlStringBase = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", urlStringBase, self.account.access_token];
//    NSLog(@"urlString is: %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    //    NSLog(@"url is:\n %@", url);
    NSURLSession *urlSession = [NSURLSession sharedSession];
    [[urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            NSArray* statusArray = [json objectForKey:@"statuses"];
            [self.statuses removeAllObjects];
                //            NSLog(@"number is: %d", self.statuses.count);
                
            for (NSDictionary *dic in statusArray) {
                MBStatus *status = [MBStatus objectWithKeyValues:dic];
                [self.statuses addObject:status];
            }
            NSLog(@"count: %d", self.statuses.count);
            [self dataDownLoaded];
            
        }else{
            [self.refreshButton setEnabled:true];
            [self.moreButton setEnabled:true];
            NSLog(@"error is: %@", error);
        }
    }] resume];
    
}


- (void)loadMoreStatus{
    [self.statusTable setNumberOfRows:0 withRowType:@"MainRow"];
    [self.refreshButton setEnabled:false];
    [self.moreButton setEnabled:false];
    
//    NSLog(@"begin load more status");
    NSString *maxIdStr = nil;
    if (self.statuses.count) {
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld", maxId];
    }
    
    NSString *urlStringBase = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@&max_id=%@", urlStringBase, _account.access_token, maxIdStr];
//    NSLog(@"load more string is: %@\n", urlString);
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
            
            [self dataDownLoaded];
            
            
        }else{
            [self.refreshButton setEnabled:true];
            [self.moreButton setEnabled:true];
            NSLog(@"error is: %@", error);
        }
    }] resume];

}



- (void)dataDownLoaded{
    NSLog(@"data downloaded");
    [self.statusTable setNumberOfRows:self.statuses.count withRowType:@"MainRow"];
    
    if (self.statuses == nil || self.statuses.count == 0) {
        NSLog(@"no data");
        [self.refreshButton setEnabled:true];
        [self.moreButton setEnabled:true];
    }
    
    self.loadPic = true;
    for(int i = 0; i < self.statuses.count; i ++){
        MBStatus *status = [self.statuses objectAtIndex:i];
        MBMainRowView *mainRow = [self.statusTable rowControllerAtIndex:i];
        [mainRow.username setText:status.user.name];
        [mainRow.postTime setText:status.created_at];
        [mainRow.content setText:status.text];

        if(self.loadPic){
            NSURL *url = [NSURL URLWithString:status.user.profile_image_url];
            
            NSURLSession *session = [NSURLSession sharedSession];
            
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            sessionConfig.timeoutIntervalForRequest = 4.0;
            
            [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSLog(@"%d", data.length);
                if (error != nil) {
                    NSLog(@"error is: %@", error);
                    [self.refreshButton setEnabled:true];
                    [self.moreButton setEnabled:true];
                    self.loadPic = false;
                }else{
                    if ( data == nil ){
                        [self.refreshButton setEnabled:true];
                        [self.moreButton setEnabled:true];
                        self.loadPic = false;
                        return;
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.finishCount ++;
                            if (self.finishCount == self.statuses.count - 1) {
                                [self.refreshButton setEnabled:true];
                                [self.moreButton setEnabled:true];
                            }
                            
                            if (mainRow != nil && data != nil && data.length > 0) {
                                [mainRow.profileImage setImage:[UIImage imageWithData:data]];
                            }
                        });
                    }
                    
                }
            }] resume];

        }
        
    }

}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    MBTransferParameter *parameter = [[MBTransferParameter alloc] init];
    parameter.account = self.account;
    parameter.status = [self.statuses objectAtIndex:rowIndex];
    [self pushControllerWithName:@"MBDetailInterfaceController" context:parameter];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (IBAction)refresh {
    self.finishCount = 0;
    NSLog(@"beging load new");
    [self loadNewStatus];
}

- (IBAction)more {
    self.finishCount = 0;
    NSLog(@"begin load more");
    if (self.statuses == nil || self.statuses.count == 0) {
        [self refresh];
    }else{
        [self loadMoreStatus];
    }
}




@end



