//
//  StoreCell.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *storeImageView;
@property (strong, nonatomic) IBOutlet UILabel *storeAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *storePhoneLabel;
@end
