//
//  DealDetailViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 21/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "DealDetailViewController.h"

@interface DealDetailViewController () {
    __block APObject *_vote;
}
@property (weak, nonatomic) IBOutlet UIImageView *selectedDealImage;
@property (weak, nonatomic) IBOutlet UILabel *votes;
@end

@implementation DealDetailViewController

- (void) setDeal:(Deal *)deal {
    _deal = deal;
    
    NSString *query = [NSString stringWithFormat:@"articleId=%@&label=%@", [deal.objectId description],@"vote"];
    
    [APConnection
        searchForConnectionsWithRelationType:@"votes"
        withQueryString:query
        successHandler:^(NSDictionary *result) {
            NSArray *conns = [result objectForKey:@"connections"];
            if ([conns count] == 0) {
                [_votes setText:@"0"];
            } else {
                NSNumber *voteArticleId = [[[conns objectAtIndex:0] objectForKey:@"__endpointa"] objectForKey:@"articleid"];
                APObject *vote = [APObject objectWithSchemaName:@"vote"];
                vote.objectId = voteArticleId;
                [vote fetchWithSuccessHandler:^(){
                    _vote = vote;
                } failureHandler:nil];
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
                        labelA:@"deal"
                        labelB:@"vote"
                        successHandler:^(){
                            _vote = vote;
                            [_votes setText:@"1"];
                        } failureHandler:^(APError *error) {
                            NSLog(@"%@", error.description);
                        }];
        } failureHandler:nil];
    } else {
        __block NSNumber *rating;
        [_vote.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            NSDictionary *dict = (NSDictionary*)obj;
            if ([dict objectForKey:@"rating"] != nil) {
                rating = [dict objectForKey:@"rating"];
                *stop = YES;
            }
        }];
    }
}
@end
