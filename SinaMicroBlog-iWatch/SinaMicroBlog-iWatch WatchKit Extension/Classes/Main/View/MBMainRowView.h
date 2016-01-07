//
//  MBMainRowView.h
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WatchKit;

@interface MBMainRowView : NSObject
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *profileImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *username;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *postTime;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *content;

@end
