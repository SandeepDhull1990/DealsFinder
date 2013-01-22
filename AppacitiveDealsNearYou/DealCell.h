//
//  DealCell.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 17/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *dealImage;
@property (strong, nonatomic) IBOutlet UILabel *dealNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dealDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dealStartDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *dealEndDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *dealMilesAway;

@end
