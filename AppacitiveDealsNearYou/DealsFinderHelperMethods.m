//
//  DealsFinderHelperMethods.m
//  AppacitiveDealsNearYou
//
//  Created by Kauserali on 22/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "DealsFinderHelperMethods.h"

@implementation DealsFinderHelperMethods

+ (NSDate *) deserializeJsonDateString: (NSString *)jsonDateString {
    if (jsonDateString == nil && jsonDateString.length == 0) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSSS"];
    NSDate *date = [dateFormatter dateFromString:jsonDateString];
    return date;
}

@end
