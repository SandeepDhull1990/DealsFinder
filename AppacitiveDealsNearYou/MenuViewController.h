//
//  MenuViewController.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ECSlidingViewController/ECSlidingViewController.h>

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate>
- (IBAction)backToDealsList:(id)sender;

@end
