//
//  MBTransferParameter.h
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/7/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBAccount.h"
#import "MBStatus.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface MBTransferParameter : NSObject

@property (nonatomic, strong) MBAccount* account;
@property (nonatomic, strong) MBStatus* status;
//@property (nonatomic, strong) WCSession* session;

@end
