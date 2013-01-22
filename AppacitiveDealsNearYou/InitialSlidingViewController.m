//
//  InitialSlidingViewController.m
//  APFindYourDeal
//
//  Created by Sonia Mane on 09/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//


#import "InitialSlidingViewController.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    }
    
    /*
     If the user is already logged in then directly go to DealsListViewController
     */
//    NSLog(@"SONIA'S CHECK ------in view did load of initial sliding view controller");
   self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationTop"];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
@end
