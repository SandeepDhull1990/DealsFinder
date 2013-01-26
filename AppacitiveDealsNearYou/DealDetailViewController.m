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
    JSNotifier *_notifier;
}
@property (weak, nonatomic) IBOutlet UIImageView *selectedDealImage;
@property (weak, nonatomic) IBOutlet UILabel *votes;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;
@end

@implementation DealDetailViewController

- (void) setDeal:(Deal *)deal {
    _deal = deal;
    NSString *query = [NSString stringWithFormat:@"articleId=%@&label=%@", [deal.objectId description],@"user"];
    
    [APConnection
     searchForConnectionsWithRelationType:@"vote"
     withQueryString:query
     successHandler:^(NSDictionary *result) {
         NSArray *connections = [result objectForKey:@"connections"];
         if ([connections count] == 0) {
             _voteCount = 0;
         } else {
             _voteCount = connections.count;
         }
         [self.votes setText:[NSString stringWithFormat:@"%d",_voteCount]];
         [self.activityIndicatorView stopAnimating];
         self.upvoteButton.enabled = YES;

     } failureHandler:^(APError *error) {
         [self.activityIndicatorView stopAnimating];
     }];
}

-(void)viewDidLoad {
    [self.upvoteButton setEnabled:NO];
}

- (IBAction)upvoteButtonPressed:(id)sender {
    
    [_notifier hide];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator startAnimating];
    
    _notifier = [[JSNotifier alloc]initWithTitle:@"Updating Vote Count.."];
    _notifier.accessoryView = activityIndicator;
    [_notifier show];
    
    [_upvoteButton setEnabled:NO];

    APUser *currentUser = [APUser currentUser];
    
    APConnection *connection = [APConnection connectionWithRelationType:@"vote"];
    [connection createConnectionWithObjectAId:currentUser.objectId
                                    objectBId:self.deal.objectId
                                       labelA:@"user"
                                       labelB:@"deal"
                               successHandler:^(){
                                   
                                   self.upvoteButton.enabled = YES;
                                   
                                   _voteCount = _voteCount + 1;
                                   [_votes setText:[NSString stringWithFormat:@"%d",_voteCount]];
                                   
                                   [_notifier setAccessoryView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyCheck.png"]] animated:YES];
                                   [_notifier setTitle:@"Vote Count Updated" animated:YES];
                                   [_notifier hideIn:2.0];
                                   
                               } failureHandler:^(APError *error) {
                                   [_notifier setAccessoryView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyX.png"]] animated:YES];
                                   if(error.code == 7006) {
                                       [_notifier setTitle:@"You have already upvoted this deal" animated:YES];
                                   } else {
                                       self.upvoteButton.enabled = YES;
                                       [_notifier setTitle:@"Error while updating vote count" animated:YES];
                                   }
                                   [_notifier hideIn:2.0];
                                   
                               }];
}

@end
