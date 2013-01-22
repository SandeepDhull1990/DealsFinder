//
//  NavigationTopViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <ECSlidingViewController/ECSlidingViewController.h>
#import "NavigationTopViewController.h"
#import "MenuViewController.h"

@implementation NavigationTopViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self.slidingViewController setAnchorRightPeekAmount:20.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
