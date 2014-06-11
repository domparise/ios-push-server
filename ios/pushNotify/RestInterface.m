//
//  RestInterface.m
//  pushNotify
//
//  Created by Dom on 4/15/14.
//  Copyright (c) 2014 dolodev. All rights reserved.
//

#import "RestInterface.h"

@interface RestInterface () <NSURLSessionDelegate>
@property NSURLSession* session;
@property NSString* ip;
@end

@implementation RestInterface

- (id) initWithIP:(NSString *)ip
{
    self = [super init];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.ip = ip;
    return self;
}

- (void) fetchWithCb:(void(^)(NSArray*))cb
{
    NSURL* url = [NSURL URLWithString:[_ip stringByAppendingString:@"/fetch"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:@{@"sup": @"yolo"} options:0 error:nil]];
    NSURLSessionDataTask *task = [_session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSArray* raw = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (raw.count) {
            NSMutableArray* arr = [NSMutableArray new];
            for (NSDictionary* dic in raw) {
                [arr addObject:dic];
            };
            NSLog(@" arr:%@",arr);
            cb(arr);
        } else {
            if (error) {
                NSLog(@"error fetching notifications");
            } else {
                NSLog(@"nothing to fetch");
            }
            cb(nil);
        }
    }];
    [task resume];
}

- (void) ackMessage:(NSArray*)msgs
{
    NSURL* url = [NSURL URLWithString:[_ip stringByAppendingString:@"/ack"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSDictionary* data = @{@"seen": (msgs ? msgs : @"yolo") };
    NSLog(@" data: %@",data);
    NSError* err = [NSError new];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:data options:0 error:&err]];
    [request setHTTPMethod:@"POST"];
    NSURLSessionDataTask* task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"err: %@",[error userInfo]);
    }];
    [task resume];
}

@end
