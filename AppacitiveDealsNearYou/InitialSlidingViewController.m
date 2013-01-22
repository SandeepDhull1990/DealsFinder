//
//  InitialSlidingViewController.m
//  APFindYourDeal
//
//  Created by Sonia Mane on 09/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//


#import "InitialSlidingViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#warning rename storyboardtemp
@interface InitialSlidingViewController() {
    BOOL _isAppacitiveSessionReceived;
    UIStoryboard *_storyBoardTemp;
}
@end

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _storyBoardTemp = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    self.topViewController = [_storyBoardTemp instantiateViewControllerWithIdentifier:@"NavigationTop"];
}

- (void) viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appacitiveSessionReceived) name:SessionReceivedNotification object:nil];
}

- (void) viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) appacitiveSessionReceived {
    _isAppacitiveSessionReceived = YES;
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        [ApplicationDelegate openSession];
    } else {
        __weak LoginViewController *loginViewController = (LoginViewController*) [_storyBoardTemp instantiateViewControllerWithIdentifier:@"Login"];
        
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
