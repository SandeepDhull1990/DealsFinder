//
//  Store.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 21/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject
@property (strong, nonatomic) NSString *storeName;
@property (strong, nonatomic) NSString *storeImageUrl;
@property (strong, nonatomic) NSString *storeImageFilename;
@property (strong, nonatomic) NSString *storeAddress;
@property (strong, nonatomic) NSString *storePhone;

@property (copy, nonatomic) NSString *storeImageKey;
@end
