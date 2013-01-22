//
//  DealDetailViewController.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 21/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"

@interface DealDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *selectedDealImage;
@property (strong, nonatomic) Deal *selectedDeal;
@end
