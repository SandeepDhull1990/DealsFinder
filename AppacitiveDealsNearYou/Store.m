//
//  Store.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 21/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "Store.h"

@implementation Store
@synthesize storeName, storeAddress, storePhone, storeImageUrl, storeImageFilename, storeImageKey;

- (NSString *)description {
    return [NSString stringWithFormat:@"Stores fetched are - Name: %@, Address:%@, Phone No.:%@", storeName, storeAddress, storePhone];
}
@end
