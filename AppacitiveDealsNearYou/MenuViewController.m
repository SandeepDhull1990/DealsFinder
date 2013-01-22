//
//  MenuViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () {
    UIButton *_footerView;
}
@end

@implementation MenuViewController


- (id) initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
//
//
//# pragma mark TableView Delegate methods
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationTopStore"];
//    
//    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
//        CGRect frame = self.slidingViewController.topViewController.view.frame;
//        self.slidingViewController.topViewController = newStoreViewController;
//        self.slidingViewController.topViewController.view.frame = frame;
//        [self.slidingViewController resetTopView];
//    }];
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//    _footerView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [_footerView setTitle:@"Logout" forState:UIControlStateNormal];
//    
////    [button addTarget:self action:@selector(logout:)
////     forControlEvents:UIControlEventTouchUpInside];
//    return _footerView;
//}

- (void)logout:(id) sender {
    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newStoreViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}

- (IBAction)backToDealsList:(id)sender {
    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationTop"];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newStoreViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];

}
@end
