//
//  NavigationTopCreateStoreViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "NavigationTopCreateStoreViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "MenuFindDealsViewController.h"

@interface NavigationTopCreateStoreViewController ()

@end

@implementation NavigationTopCreateStoreViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuFindDealsViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
