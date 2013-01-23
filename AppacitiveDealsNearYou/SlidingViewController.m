//
//  InitialSlidingViewController.m
//  APFindYourDeal
//
//  Created by Sonia Mane on 09/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//


#import "SlidingViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@implementation SlidingViewController

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appacitiveSessionReceived) name:SessionReceivedNotification object:nil];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) appacitiveSessionReceived {
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        [ApplicationDelegate openSession];
    } else {
        UIStoryboard *storyBoardTemp = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
        __weak LoginViewController *loginViewController = (LoginViewController*) [storyBoardTemp instantiateViewControllerWithIdentifier:@"Login"];
        
        loginViewController.loginWithFacebookSuccessful = ^() {
            [loginViewController dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
@end
