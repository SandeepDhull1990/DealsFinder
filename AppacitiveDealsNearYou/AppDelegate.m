//
//  AppDelegate.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "AppDelegate.h"
#import "FacebookSDK.h"
#import "LoginViewController.h"
#import "InitialSlidingViewController.h"
#import "NavigationTopViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "MenuViewController.h"

@interface AppDelegate()
@property (strong, nonatomic) InitialSlidingViewController *initialSlidingViewController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@end

@implementation AppDelegate
NSString *const SCSessionStateChangedNotification = @"com.appacitive.AppacitiveDealsNearYou:SCSessionStateChangedNotification";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Appacitive appacitiveWithApiKey:@"r6ZODXPtV2UTDUkykGs92+lPwGBGa0R1FKXMizNTvDw="];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)openSession {
    [FBSession openActiveSessionWithReadPermissions:nil
               allowLoginUI:YES
               completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                  [self sessionStateChanged:session state:state error:error];
    }];
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error {
    switch (state) {
        case FBSessionStateOpen: {
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:session.accessToken forKey:@"UserAccessToken"];//extern
            
            [APUser authenticateUserWithFacebook:session.accessToken successHandler:^(){
                UIStoryboard *storyboard;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                    storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
                }
                self.initialSlidingViewController = [storyboard instantiateViewControllerWithIdentifier:@"InitialSliding"];
                [self.loginViewController presentViewController:self.initialSlidingViewController animated:YES completion:^() {
                    
                }];
            } failureHandler:^(APError *error){
                
            }];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed: {
            [FBSession.activeSession closeAndClearTokenInformation];
            UIStoryboard *storyboard;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
            }
             self.loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.initialSlidingViewController presentViewController:self.loginViewController animated:YES completion:^(){}];
        }
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SCSessionStateChangedNotification object:session userInfo:@{@"session":session}];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBSession.activeSession handleOpenURL:url];
}

@end
