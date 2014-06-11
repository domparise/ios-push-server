//
//  RestInterface.h
//  pushNotify
//
//  Created by Dom on 4/15/14.
//  Copyright (c) 2014 dolodev. All rights reserved.
//

@interface RestInterface : NSObject

- (id) initWithIP:(NSString*)ip;
- (void) fetchWithCb:(void(^)(NSArray*))cb;
- (void) ackMessage:(NSArray*)msgs;

@end
