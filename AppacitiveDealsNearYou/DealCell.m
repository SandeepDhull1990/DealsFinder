//
//  DealCell.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 17/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "DealCell.h"

@implementation DealCell
@synthesize dealImage, dealNameLabel, dealDescriptionLabel, dealStartDateLabel, dealEndDateLabel, dealMilesAway;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
