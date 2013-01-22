//
//  DealsListViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "DealsListViewController.h"
#import "MenuViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Appacitive-iOS-SDK/APObject.h>
#import <Appacitive-iOS-SDK/Appacitive.h>
#import <Appacitive-iOS-SDK/APBlob.h>
#import "DealCell.h"
#import "Deal.h"
#import "NavigationTopViewController.h"
#import "DealDetailViewController.h"

#define FETCH_DEALS 1
#define FETCH_DEALS_IMAGES 2

@interface DealsListViewController () {    
}

@property (strong, nonatomic) NSMutableArray *dealsDictionaryArray;
@property (strong, nonatomic) NSMutableArray *deals;
@end

@implementation DealsListViewController
@synthesize dealsDictionaryArray, deals;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetch:FETCH_DEALS];
}

- (IBAction)revealPublishOptions:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)logoutButton:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
    [self dismissViewControllerAnimated:YES completion:^(){
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *dealItemCell = @"DealCell";
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DealCell *cell = (DealCell *)[tableView dequeueReusableCellWithIdentifier:dealItemCell];
    if (cell == nil) {
        cell = [[DealCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dealItemCell];
    }
    Deal * deal = [deals objectAtIndex:indexPath.row];
   NSString * pngIndex = [NSString stringWithFormat:@"deal%d.png",indexPath.row];
//    NSString *dealDocumentsDirectoryImagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:pngIndex];
    
    
    NSArray *arrayPath = [[NSArray alloc] initWithObjects:NSHomeDirectory(), @"Documents", pngIndex, nil];
    
    NSString *dealDocumentsDirectoryImagePath =  [NSString pathWithComponents:arrayPath];
    
    [APBlob downloadFileFromRemoteUrl:[deal dealImageUrl] toFile:dealDocumentsDirectoryImagePath downloadProgressBlock:^(double progress) {
        
    }successHandler:^() {
        UIImage *dealImage = [UIImage imageWithContentsOfFile:dealDocumentsDirectoryImagePath];
        deal.dealImageFileName = dealDocumentsDirectoryImagePath;
//        NSLog(@"successfully downloaded image from url %@ and saved to filePath %@", [deal dealImageUrl], [deal dealImageFileName]);
        cell.dealImage.image = dealImage;
    } failureHandler:^(APError *error){}];
    
    cell.dealNameLabel.text = deal.dealTitle;
    cell.dealDescriptionLabel.text = deal.dealDescription;
    cell.dealStartDateLabel.text = [NSString stringWithFormat:@"%@",deal.dealStartDate];
    cell.dealEndDateLabel.text = deal.dealEndDate;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [deals count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDealDetail"]) {
        DealDetailViewController *dealDetail = [segue destinationViewController];
        NSIndexPath *path = [_dealTableView indexPathForSelectedRow];
        Deal *selectedDeal = [deals objectAtIndex:path.row];
        [dealDetail setSelectedDeal:selectedDeal];
    }
}
-(void) fetch:(int) requestType {
    switch (requestType) {
        case FETCH_DEALS: {
            //            Fetching the Deals
            // insert query string for fetching deals near by
            [APObject searchObjectsWithSchemaName:@"deal" withQueryString:nil successHandler:^(NSDictionary *dict){
                //deals array
                dealsDictionaryArray = [dict objectForKey:@"articles"];
                deals = [[NSMutableArray alloc]init];
                for(int i =0 ; i < [dealsDictionaryArray count] ; i++) {
                    NSDictionary *dealDictionary = [dealsDictionaryArray objectAtIndex:i];
                    //                    NSLog(@"The title of deal is %@",[dealDictionary objectForKey:@"title"]);
                    Deal *deal = [[Deal alloc]init];
                    
                    deal.dealTitle = [dealDictionary objectForKey:@"title"];
                    deal.dealImageUrl = [dealDictionary objectForKey:@"photo"];
                    deal.dealStartDate = [dealDictionary objectForKey:@"startdate"];
                    deal.dealEndDate = [dealDictionary objectForKey:@"enddate"];
                    deal.dealDescription = [dealDictionary objectForKey:@"description"];
                    deal.dealLocation = [dealDictionary objectForKey:@"location"];
                    deal.dealAtttributes = [dealDictionary objectForKey:@"__attributes"];
                    
                    [deals addObject:deal];
                }//end of for loop
                [_dealTableView reloadData];
                
            } failureHandler:^(APError *error){
            }];
        }
            break;
            
        case FETCH_DEALS_IMAGES:{
            
            //                NSLog(@"deals array count $$$$$$$$$$$$$$ %d",[deals count]);
            //                for (int i = 0; i < [deals count]; i++) {
            //                    NSString * pngIndex = [NSString stringWithFormat:@"/deal%d.png", i];
            //                    NSString *dealDocumentsDirectoryImagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:pngIndex];
            //                    [APBlob downloadFileFromRemoteUrl:[[deals objectAtIndex:i] dealImageUrl] toFile:dealDocumentsDirectoryImagePath downloadProgressBlock:^(double progress) {
            //
            //                    }successHandler:^() {
            //                        _dealImage = [UIImage imageWithContentsOfFile:dealDocumentsDirectoryImagePath];
            //                        NSLog(@"successfully downloaded image from url %@ and saved to filePath %@", [[deals objectAtIndex:i] dealImageUrl], dealDocumentsDirectoryImagePath);
            //                        Deal *deal  = [deals objectAtIndex:i];
            //                        deal.dealImage = _dealImage;
            //                        NSLog(@"deal image property set %@", deal.dealImage.description);
            //                    } failureHandler:^(APError *error){}];
            //                }
            //
            
            
        }
            break;
        default:
            break;
    }
}


@end
