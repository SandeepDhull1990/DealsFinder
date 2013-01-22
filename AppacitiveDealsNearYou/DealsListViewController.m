//
//  DealsListViewController.m
//  '
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "DealsListViewController.h"
#import "MenuViewController.h"
#import "DealCell.h"
#import "Deal.h"
#import "NavigationTopViewController.h"
#import "DealDetailViewController.h"
#import "DealsFinderHelperMethods.h"

#define FETCH_DEALS 1
#define FETCH_DEALS_IMAGES 2

@interface DealsListViewController ()

- (IBAction)revealPublishOptions:(id)sender;
- (IBAction)logoutButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *dealTableView;

@property (strong, nonatomic) NSMutableArray *deals;
@end

@implementation DealsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    [self.refreshControl addTarget:self action:@selector(refreshControlCallback) forControlEvents:UIControlEventValueChanged];
    [self fetchDeals];
}

- (void) refreshControlCallback {
    [self fetchDeals];
}

- (IBAction)revealPublishOptions:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)logoutButton:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *dealItemCell = @"DealCell";
    
    DealCell *cell = (DealCell *)[tableView dequeueReusableCellWithIdentifier:dealItemCell];
    Deal *deal = [_deals objectAtIndex:indexPath.row];
    
    cell.dealNameLabel.text = deal.dealTitle;
    cell.dealDescriptionLabel.text = deal.dealDescription;
    cell.dealStartDateLabel.text = [[DealsFinderHelperMethods deserializeJsonDateString:deal.dealStartDate] description];
    cell.dealEndDateLabel.text = [[DealsFinderHelperMethods deserializeJsonDateString:deal.dealEndDate] description];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_deals count];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"ShowDealDetail"]) {
//        DealDetailViewController *dealDetail = [segue destinationViewController];
//        NSIndexPath *path = [_dealTableView indexPathForSelectedRow];
//        Deal *selectedDeal = [deals objectAtIndex:path.row];
//        [dealDetail setSelectedDeal:selectedDeal];
//    }
//}

#warning implement failure with proper UI callbacks

-(void) fetchDeals {
    [APObject searchObjectsWithSchemaName:@"deal"
              withQueryString:nil
              successHandler:^(NSDictionary *dict){
                NSArray *dealsArray = [dict objectForKey:@"articles"];
                  _deals = [[NSMutableArray alloc] init];
                
                  [dealsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                      NSDictionary *dealDictionary = obj;
                      
                      Deal *deal = [[Deal alloc]init];
                      deal.dealTitle = [dealDictionary objectForKey:@"title"];
                      deal.dealImageUrl = [dealDictionary objectForKey:@"photo"];
                      deal.dealStartDate = [dealDictionary objectForKey:@"startdate"];
                      deal.dealEndDate = [dealDictionary objectForKey:@"enddate"];
                      deal.dealDescription = [dealDictionary objectForKey:@"description"];
                      deal.dealLocation = [dealDictionary objectForKey:@"location"];
                      [_deals addObject:deal];
                  }];
                  [_dealTableView reloadData];
                  [self.refreshControl endRefreshing];
              } failureHandler:^(APError *error) {
                  [self.refreshControl endRefreshing];
              }];
}

@end
