//
//  LoginViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Appacitive-iOS-SDK/APUser.h>
#import <Appacitive-iOS-SDK/APError.h>
#import "InitialSlidingViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) InitialSlidingViewController *initialSlidingViewController;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        NSLog(@"In the init with coder");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginWithFacebook:(id)sender {
//    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
//    [appDelegate openSession];
    UIStoryboard *storyboard;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    }
    self.initialSlidingViewController = [storyboard instantiateViewControllerWithIdentifier:@"InitialSliding"];
    [self presentViewController:self.initialSlidingViewController animated:YES completion:^() {
//        NSLog(@"succesfully navigated to initial Sliding view controller with facebook authentication-======");
    }];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    //    [self.spinner stopAnimating];
    NSLog(@"LOG IN FAILED----------->");
}

@end
