//
//  MBDetailInterfaceController.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/7/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBDetailInterfaceController.h"
#import "MBStatus.h"
#import "MBPhoto.h"
#import "MBTransferParameter.h"
#import "MBAccount.h"
#import "MBUser.h"
//#import <WatchKit/WatchKit.h>

@interface MBDetailInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *content;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *firstImage;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *secondImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *thirdImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *fourthImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *fifthImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *sixthImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *seventhImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *eighthImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *ninthImage;



@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *retweeted_name;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *retweeted_text;

@property (nonatomic, strong) MBStatus *status;
@property (nonatomic, strong) MBAccount *account;

@property (nonatomic, strong) MBStatus *retweeted_status;

- (IBAction)Share;
//- (IBAction)Like;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *shareBtn;
//@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *likeBtn;

@end

@implementation MBDetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    MBTransferParameter *parameter = context;
    self.status = parameter.status;
    self.account = parameter.account;
    self.retweeted_status = parameter.status.retweeted_status;
    
    NSLog(@"retweeted_status username is: %@", self.retweeted_status.user.name);
    
    [self initWithModel:self.status];
    // Configure interface objects here.
}

- (void)initWithModel: (MBStatus *)status{
    [self.content setText:status.text];
    if (self.retweeted_status != nil) {
        [self.retweeted_name setText:[NSString stringWithFormat:@"@%@", self.retweeted_status.user.name]];
        [self.retweeted_text setText:self.retweeted_status.text];
        [self.retweeted_text setTextColor:[UIColor grayColor]];
        [self loadImages:status.retweeted_status.pic_urls];
    }else{
        [self loadImages:status.pic_urls];
    }
    
}

- (void)loadImages: (NSArray *)urls{
    for(int i = 0; i < urls.count; i ++){
//        NSLog(@"%@", [urls objectAtIndex:i]);
        switch (i) {
            case 0:{
                [self loadImageWithUrl:[urls objectAtIndex:0] image:self.firstImage];
                break;
            }
            case 1:{
                [self loadImageWithUrl:[urls objectAtIndex:1] image:self.secondImage];
                break;
            }
            case 2:{
                [self loadImageWithUrl:[urls objectAtIndex:2] image:self.thirdImage];
                break;
            }
            case 3:{
                [self loadImageWithUrl:[urls objectAtIndex:3] image:self.fourthImage];
                break;
            }
            case 4:{
                [self loadImageWithUrl:[urls objectAtIndex:4] image:self.fifthImage];
                break;
            }
            case 5:{
                [self loadImageWithUrl:[urls objectAtIndex:5] image:self.sixthImage];
                break;
            }
            case 6:{
                [self loadImageWithUrl:[urls objectAtIndex:6] image:self.seventhImage];
                break;
            }
            case 7:{
                [self loadImageWithUrl:[urls objectAtIndex:7] image:self.eighthImage];
                break;
            }
            case 8:{
                [self loadImageWithUrl:[urls objectAtIndex:8] image:self.ninthImage];
                break;
            }
            default:
                break;
        }
    }
}



- (void)loadImageWithUrl:(MBPhoto *)photo image:(WKInterfaceImage *)imageView{
//    NSURL *url = [NSURL URLWithString:urlStr];
    NSURL *urlStringThumbnail = photo.thumbnail_pic;
    NSString *urlString = urlStringThumbnail.absoluteString;
    urlString = [urlString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"%@", url);
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ( data == nil ){
            NSLog(@"error is: %@", error);
            return;
        }
        [imageView setImage:[UIImage imageWithData:data]];
    }] resume];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)Share {
    NSLog(@"click share");
    [self shareStatus];
}

//- (IBAction)Like {
//    [self likeStatus];
//}
//
//- (IBAction)testFirstImageBtn {
//}

//- (void)likeStatus{
//    NSLog(@"like");
//    NSString *parameter = [NSString stringWithFormat:@"access_token=%@&id=%@", self.account.access_token, self.status.idstr];
//    
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    sessionConfiguration.HTTPAdditionalHeaders = @{
//                                                   @"api-key"       : @"API_KEY"
//                                                   };
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
//    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/attitudes/create.json"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPMethod = @"POST";
//    NSURLSessionDataTask *likeDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"response is: \n%@", response);
//        if (error == nil) {
//            [self.likeBtn setEnabled:false];
//            [self.likeBtn setBackgroundColor:[UIColor orangeColor]];
//        }
//        NSLog(@"error is: %@", error);
//    }];
//    [likeDataTask resume];
//    
////    NSString *parameter = [NSString stringWithFormat:@"access_token=%@&id=%@", self.account.access_token, self.status.idstr];
////    
////    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
////    sessionConfiguration.HTTPAdditionalHeaders = @{
////                                                   @"api-key"       : @"API_KEY"
////                                                   };
////    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
////    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/attitudes/create.json"];
////    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
////    request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
////    request.HTTPMethod = @"POST";
////    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
////        NSLog(@"response is: \n%@", response);
////    }];
////    [postDataTask resume];
////
////    NSString *parameter = [NSString stringWithFormat:@"attitude=simle&access_token=%@&id=%@", self.account.access_token, self.status.idstr];
////    
////    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
////    sessionConfiguration.HTTPAdditionalHeaders = @{
////                                                   @"api-key"       : @"API_KEY"
////                                                   };
////    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
////    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/attitudes/create.json"];
////    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
////    request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
////    request.HTTPMethod = @"POST";
////    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
////        NSLog(@"response is: \n%@", response);
////    }];
////    [postDataTask resume];
//}

- (void)shareStatus{
    
    NSString *parameter = [NSString stringWithFormat:@"access_token=%@&id=%@", self.account.access_token, self.status.idstr];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{
                                                   @"api-key"       : @"API_KEY"
                                                   };
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/statuses/repost.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response is: \n%@", response);
        if (error == nil) {
            [self.shareBtn setEnabled:false];
            [self.shareBtn setBackgroundColor:[UIColor orangeColor]];
        }
    }];
    [postDataTask resume];
    
}
@end



