//
//  AppDelegate.m
//  pushNotify
//
//  Created by Dom on 4/15/14.
//  Copyright (c) 2014 dolodev. All rights reserved.
//

#import "AppDelegate.h"
#import "RestInterface.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    NSLog(@"launchOptions: %@",launchOptions);
    NSLog(@"badgeNumber: %li",[app applicationIconBadgeNumber]);
    
    RestInterface* ri = [[RestInterface alloc] initWithIP:@"http://35.2.226.236:3000"];
    [ri fetchWithCb:^(NSArray* response){
        NSLog(@"response: %@", response);
        [ri ackMessage:response];
        app.applicationIconBadgeNumber = 0;
    }];
    
    return YES;
}

- (void)application:(UIApplication*)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)token
{
//	NSLog(@"token: %@", token);
}

- (void)application:(UIApplication*)app didReceiveRemoteNotification:(NSDictionary *)info
{
    NSLog(@"user info: %@",info);
}

@end
