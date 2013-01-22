//
//  LoginViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "InitialSlidingViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) InitialSlidingViewController *initialSlidingViewController;
@end

@implementation LoginViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookSessionChangedNotification:) name:SCSessionStateChangedNotification object:nil];
}

#warning fill the error
- (void) facebookSessionChangedNotification:(NSNotification*)notification {
    FBSession *session = [[notification userInfo] objectForKey:@"session"];
    if (session.state == FBSessionStateOpen && self.loginWithFacebookSuccessful != nil) {
        self.loginWithFacebookSuccessful();
    } else {
        //through an error in the form of a on screen notification
    }
}

- (IBAction)loginWithFacebook:(id)sender {
    [ApplicationDelegate openSession];
}
@end
