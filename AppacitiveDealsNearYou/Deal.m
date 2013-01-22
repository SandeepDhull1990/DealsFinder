//
//  Deal.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "Deal.h"

@implementation Deal

- (NSString *)description {
    return [NSString stringWithFormat:@"Deals fetched - Title: %@, ImageUrl: %@, Filename: %@, StartDate: %@, EndDate: %@, Description: %@, Location: %@", _dealTitle, _dealImageUrl, _dealImageFileName, _dealStartDate, _dealEndDate, _dealDescription, _dealLocation];
}
@end
