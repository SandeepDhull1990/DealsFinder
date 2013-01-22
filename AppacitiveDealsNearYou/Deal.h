//
//  Deal.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

@interface Deal : NSObject
@property (strong, nonatomic) NSString *dealTitle;
@property (strong, nonatomic) NSString *dealImageUrl;
@property (strong, nonatomic) NSString *dealImageFileName;
@property (strong, nonatomic) NSString *dealStartDate;
@property (strong, nonatomic) NSString *dealEndDate;
@property (strong, nonatomic) NSString *dealDescription;
@property (strong, nonatomic) NSString *dealLocation;
@end
