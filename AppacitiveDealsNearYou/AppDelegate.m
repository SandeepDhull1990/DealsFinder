//
//  AppDelegate.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"
#import "InitialSlidingViewController.h"
#import "NavigationTopViewController.h"
#import <Appacitive-iOS-SDK/APUser.h>
#import <Appacitive-iOS-SDK/APError.h>
#import <Appacitive-iOS-SDK/APUserDetails.h>
#import <Appacitive-iOS-SDK/APObject.h>
#import <Appacitive-iOS-SDK/APBlob.h>
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "MenuViewController.h"

@interface AppDelegate()
@property (strong, nonatomic) InitialSlidingViewController *initialSlidingViewController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@end

@implementation AppDelegate
NSString *const SCSessionStateChangedNotification = @"com.appacitive.AppacitiveDealsNearYou:SCSessionStateChangedNotification";
@synthesize initialSlidingViewController = _initialSlidingViewController;
@synthesize loginViewController = _loginViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     For facebook profile photo we need to use this class
     */
    [FBProfilePictureView class];
    [Appacitive appacitiveWithApiKey:@"r6ZODXPtV2UTDUkykGs92+lPwGBGa0R1FKXMizNTvDw="];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotNotification) name:SessionReceivedNotification object:nil];
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    }
        
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        self.initialSlidingViewController = [storyboard     instantiateViewControllerWithIdentifier:@"InitialSliding"];
        self.window.rootViewController = self.initialSlidingViewController;
        [self openSession];
    } else {
        self.loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
        self.window.rootViewController = self.loginViewController;
        
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)openSession {
    NSLog(@"called open session");
    [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
        [self sessionStateChanged:session state:state error:error];
    }];
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error {
    switch (state) {
        case FBSessionStateOpen: {
            /*
             create a session and create a user with facebook request
             */
            NSLog(@"SONIA'S CHECK--session state opened---accessToken is==%@", session.accessToken);
            NSUserDefaults *accessTokenUserDefaults = [NSUserDefaults standardUserDefaults];
            [accessTokenUserDefaults setObject:session.accessToken forKey:@"UserAccessToken"];
            [APUser authenticateUserWithFacebook:session.accessToken successHandler:^(){
                NSLog(@"Authentication with facebook successful");
                UIStoryboard *storyboard;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                    storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
                }
                self.initialSlidingViewController = [storyboard instantiateViewControllerWithIdentifier:@"InitialSliding"];
                [self.loginViewController presentViewController:self.initialSlidingViewController animated:YES completion:^() {
                   // NSLog(@"succesfully navigated to initial Sliding view controller with facebook authentication-======");
                }];
            }failureHandler:^(APError *error){
//                NSLog(@"Authentication with facebook Failed %@", [error description]);
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SCSessionStateChangedNotification
                                                        object:session];
    
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

-(void) gotNotification {
    NSLog(@"Reached Here after getting session");
}

@end
