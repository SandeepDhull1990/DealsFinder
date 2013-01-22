//
//  Deal.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "Deal.h"

@implementation Deal
@synthesize dealTitle, dealImageUrl, dealImageFileName, dealStartDate, dealEndDate, dealDescription, dealLocation, dealAtttributes;

- (NSString *)description {
    return [NSString stringWithFormat:@"Deals fetched - Title: %@, ImageUrl: %@, Filename: %@, StartDate: %@, EndDate: %@, Description: %@, Location: %@, Attributes: %@",dealTitle, dealImageUrl, dealImageFileName, dealStartDate, dealEndDate, dealDescription, dealLocation, dealAtttributes];
}
@end
