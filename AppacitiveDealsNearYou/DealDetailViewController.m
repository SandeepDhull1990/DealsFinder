//
//  DealDetailViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 21/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "DealDetailViewController.h"
#import <JSNotifier.h>

@interface DealDetailViewController () {
    int _voteCount;
}
@property (weak, nonatomic) IBOutlet UIImageView *selectedDealImage;
@property (weak, nonatomic) IBOutlet UILabel *votes;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;
@end

@implementation DealDetailViewController

- (void) setDeal:(Deal *)deal {
    _deal = deal;
    NSString *query = [NSString stringWithFormat:@"articleId=%@&label=%@", [deal.objectId description],@"vote"];
    
    [APConnection
     searchForConnectionsWithRelationType:@"votes"
     withQueryString:query
     successHandler:^(NSDictionary *result) {
         NSArray *connections = [result objectForKey:@"connections"];
         if ([connections count] == 0) {
             [_votes setText:@"0"];
             [self.activityIndicatorView stopAnimating];
             self.upvoteButton.enabled = YES;
         } else {
             _voteCount = connections.count;
             [self.votes setText:[NSString stringWithFormat:@"%d",_voteCount]];
             self.upvoteButton.enabled = YES;
             [self.activityIndicatorView stopAnimating];
         }
     } failureHandler:^(APError *error) {
         [self.activityIndicatorView stopAnimating];
         NSLog(@"error : %@" , [error description]);
     }];
}

-(void)viewDidLoad {
    [self.upvoteButton setEnabled:NO];
}

- (IBAction)upvoteButtonPressed:(id)sender {
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator startAnimating];
    
    JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"Updating Vote Count.."];
//    CGRect frame = notify.frame;
    notify.accessoryView = activityIndicator;
    [notify show];
    
    [_upvoteButton setEnabled:NO];
    
    APObject *vote = [APObject objectWithSchemaName:@"vote"];
    [vote addPropertyWithKey:@"rating" value:[NSNumber numberWithInt:1]];
    [vote saveObjectWithSuccessHandler:^(NSDictionary *result) {
        NSDictionary *article = [result objectForKey:@"article"];
        
        NSNumber *articleA = [article objectForKey:@"__id"];
        APConnection *connection = [APConnection connectionWithRelationType:@"votes"];
        [connection createConnectionWithObjectAId:articleA
                                        objectBId:self.deal.objectId
                                           labelA:@"vote"
                                           labelB:@"deal"
                                   successHandler:^(){
                                       _voteCount = _voteCount + 1;
                                       [_votes setText:[NSString stringWithFormat:@"%d",_voteCount]];
                                       
                                       [notify setAccessoryView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyCheck.png"]] animated:YES];
                                       [notify setTitle:@"Vote Count Updated" animated:YES];
                                       [notify hideIn:3.0];
                                       
                                   } failureHandler:^(APError *error) {
                                       
                                       [notify setAccessoryView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyX.png"]] animated:YES];
                                       [notify setTitle:@"Error while updating vote count" animated:YES];
                                       [notify hideIn:2.0];
                                       
                                   }];
    } failureHandler:^(APError *error) {
        
        [notify setAccessoryView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyX.png"]] animated:YES];
        [notify setTitle:@"Error while updating vote count" animated:YES];
        [notify hideIn:2.0];
        
    }];
}

@end
