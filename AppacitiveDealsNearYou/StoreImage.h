//
//  StoreImage.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 21/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreImage : NSObject {
    NSMutableDictionary *dictionary;
}

+ (StoreImage *) sharedInstance;
- (void) setImage: (UIImage *) image forKey:(NSString *) key;
- (UIImage *) imageForKey: (NSString *) key;
- (void) deleteImageForKey: (NSString *) key;

@end
