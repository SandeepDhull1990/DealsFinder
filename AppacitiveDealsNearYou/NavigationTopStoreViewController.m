//
//  NavigationTopStoreViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "NavigationTopStoreViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "MenuViewController.h"

@interface NavigationTopStoreViewController ()

@end

@implementation NavigationTopStoreViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
@end
