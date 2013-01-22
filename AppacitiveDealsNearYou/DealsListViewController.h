//
//  DealsListViewController.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ECSlidingViewController/ECSlidingViewController.h>

@interface DealsListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate>
- (IBAction)revealPublishOptions:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *dealTableView;
- (IBAction)logoutButton:(id)sender;
@end
