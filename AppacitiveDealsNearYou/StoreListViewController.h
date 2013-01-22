//
//  StoreListViewController.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreListViewController : UITableViewController
- (IBAction)revealPublishOptions:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *storeTableView;
@end
