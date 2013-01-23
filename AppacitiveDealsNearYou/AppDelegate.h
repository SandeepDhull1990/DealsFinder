//
//  AppDelegate.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

extern NSString *const SCSessionStateChangedNotification;

@property (strong, nonatomic) UIWindow *window;

- (void)openSession;
@end
