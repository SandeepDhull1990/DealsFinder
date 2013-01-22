//
//  StoreImage.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 21/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "StoreImage.h"

@implementation StoreImage
+ (id) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}
+ (StoreImage *) sharedInstance {
    static StoreImage *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id) init {
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void) setImage: (UIImage *) image forKey:(NSString *) key {
    [dictionary setObject:image forKey:key];
}
- (UIImage *) imageForKey: (NSString *) key {
    return [dictionary objectForKey:key];
}
- (void) deleteImageForKey: (NSString *) key {
    if (!key) {
        return;
    }
    [dictionary removeObjectForKey:key];
}


@end
