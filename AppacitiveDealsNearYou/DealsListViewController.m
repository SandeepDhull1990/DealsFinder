//
//  DealsListViewController.m
//  '
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "DealsListViewController.h"
#import "DealCell.h"
#import "Deal.h"
#import "DealDetailViewController.h"
#import "DealsFinderHelperMethods.h"

#define FETCH_DEALS 1
#define FETCH_DEALS_IMAGES 2

@interface DealsListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *dealTableView;
@property (strong, nonatomic) NSMutableArray *deals;

- (IBAction)showMenu:(id)sender;
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

- (IBAction)showMenu:(id)sender {
    [[self revealViewController] revealToggleAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *dealItemCell = @"DealCell";
    
    DealCell *cell = (DealCell *)[tableView dequeueReusableCellWithIdentifier:dealItemCell];
    Deal *deal = [_deals objectAtIndex:indexPath.row];
    
    cell.dealNameLabel.text = deal.dealTitle;
    cell.dealDescriptionLabel.text = deal.dealDescription;
    cell.dealStartDateLabel.text = [[DealsFinderHelperMethods deserializeJsonDateStringToHumanReadableForm:deal.dealStartDate] description];
    cell.dealEndDateLabel.text = [[DealsFinderHelperMethods deserializeJsonDateStringToHumanReadableForm:deal.dealEndDate] description];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_deals count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDealDetail"]) {
        DealDetailViewController *dealDetail = [segue destinationViewController];
        NSIndexPath *path = [_dealTableView indexPathForSelectedRow];
        Deal *selectedDeal = [_deals objectAtIndex:path.row];
        [dealDetail setDeal:selectedDeal];
    }
}

-(void) fetchDeals {
    [APObject searchObjectsWithSchemaName:@"deal"
              withQueryString:nil
              successHandler:^(NSDictionary *dict){
                NSArray *dealsArray = [dict objectForKey:@"articles"];
                  _deals = [[NSMutableArray alloc] init];
                
                  [dealsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                      NSDictionary *dealDictionary = obj;
                      
                      Deal *deal = [[Deal alloc]init];
                      deal.objectId = [dealDictionary objectForKey:@"__id"];
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
