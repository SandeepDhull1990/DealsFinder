//
//  DealDetailViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 21/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "DealDetailViewController.h"

@interface DealDetailViewController () {
    APObject *_vote;
}
@property (weak, nonatomic) IBOutlet UIImageView *selectedDealImage;
@property (weak, nonatomic) IBOutlet UILabel *votes;
@end

@implementation DealDetailViewController

- (void) setDeal:(Deal *)deal {
    _deal = deal;
    
    NSString *query = [NSString stringWithFormat:@"articleId=%@&label=%@", [deal.objectId description],@"votes"];
    
    [APConnection
        searchForConnectionsWithRelationType:@"votes"
        withQueryString:query
        successHandler:^(NSDictionary *result) {
            NSArray *connections = [result objectForKey:@"connections"];
            if ([connections count] == 0) {
                [_votes setText:@"0"];
            }
        }];
}

- (IBAction)upvoteButtonPressed:(id)sender {
    
    if(_vote == nil) {
        APObject *vote = [APObject objectWithSchemaName:@"vote"];
        [vote addPropertyWithKey:@"rating" value:[NSNumber numberWithInt:1]];
        [vote saveObjectWithSuccessHandler:^(NSDictionary *result) {
            NSDictionary *article = [result objectForKey:@"article"];
            
            NSNumber *articleB = [article objectForKey:@"__id"];
            APConnection *connection = [APConnection connectionWithRelationType:@"votes"];
            [connection createConnectionWithObjectAId:self.deal.objectId
                        objectBId:articleB
                        labelA:@"vote"
                        labelB:@"deal"
                        successHandler:^(){
                            _vote = vote;
                        } failureHandler:nil];
        } failureHandler:nil];
    }
}
@end//15838467495953411
