//
//  DealCell.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 17/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

@interface DealCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dealImage;
@property (weak, nonatomic) IBOutlet UILabel *dealNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealMilesAway;
@end
