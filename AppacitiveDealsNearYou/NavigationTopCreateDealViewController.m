//
//  NavigationTopCreateDealViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 19/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "NavigationTopCreateDealViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "MenuFindDealsViewController.h"

@interface NavigationTopCreateDealViewController ()

@end

@implementation NavigationTopCreateDealViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuFindDealsViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuFindDeals"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
@end
