//
//  StoreListViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "StoreListViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import <Appacitive-iOS-SDK/APObject.h>
#import <Appacitive-iOS-SDK/APBlob.h>
#import "Store.h"
#import "StoreCell.h"

#define FETCH_STORE_DETAILS 11

@interface StoreListViewController () {
    UIView *_footerView;
}
@property (strong, nonatomic) NSMutableArray *storesDictionaryArray;
@property (strong, nonatomic) NSMutableArray *stores;
@property (strong, nonatomic) NSMutableArray *storeImages;
@end

@implementation StoreListViewController
@synthesize stores, storesDictionaryArray, storeImages, storeTableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    stores = [[NSMutableArray alloc] init];
    storeImages = [[NSMutableArray alloc] init];
    [self fetch:FETCH_STORE_DETAILS];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StoreCell";
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Store *store = [stores objectAtIndex:indexPath.row];
    
//    cell.storeNameLabel.text = [store storeName];
    NSLog(@"storeImages count is %d", [storeImages count]);

    NSString * pngIndex = [NSString stringWithFormat:@"store%d.png",indexPath.row];
    NSArray *arrayPath = [[NSArray alloc] initWithObjects:NSHomeDirectory(), @"Documents", pngIndex, nil];
    
    NSString *storeDocumentsDirectoryImagePath =  [NSString pathWithComponents:arrayPath];
    
    [APBlob downloadFileFromRemoteUrl:[store storeImageUrl] toFile:storeDocumentsDirectoryImagePath downloadProgressBlock:^(double progress) {
        
    }successHandler:^() {
        UIImage *storeImage = [UIImage imageWithContentsOfFile:storeDocumentsDirectoryImagePath];
        store.storeImageFilename = storeDocumentsDirectoryImagePath;
//        cell.storeImageView.image = storeImage;
//        [APBlob uploadFileWithName:storeDocumentsDirectoryImagePath
//                mimeType:@"image/png" uploadProgressBlock:^(double progress) {
//                
//                } successHandler:^(NSDictionary *result) {
//                    NSLog(@"successfully uploaded");
//        }failureHandler:^(APError *error){
//            NSLog(@"Error");
//        }];
        
    } failureHandler:^(APError *error){}];

//    cell.storeAddressLabel.text = [store storeAddress];
//    cell.storePhoneLabel.text = [store storePhone];
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationTopCreateDeal"];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newStoreViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_footerView == nil) {
        _footerView = [[UIView alloc] init];
        //we would like to show a gloosy red button, so get the image first
        
        UIImage *image = [[UIImage imageNamed:@"flt_apply_btn.png"]
                          stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        UIImage *imagePressed = [[UIImage imageNamed:@"flt_apply_btn_press.png"]
                                 stretchableImageWithLeftCapWidth:8 topCapHeight:8];
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:imagePressed forState:UIControlStateSelected];
        
        //the button should be as big as a table view cell
        [button setFrame:CGRectMake(10, 3, 300, 44)];
        
        //set title, font size and font color
        [button setTitle:@"Create new Store" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //set action of the button
        [button addTarget:self action:@selector(createNewStore:)
         forControlEvents:UIControlEventTouchUpInside];
        
        //add the button to the view
        [_footerView addSubview:button];
    }
    
    return _footerView;
}

- (void)createNewStore:(id)sender {
    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationTopCreateStore"];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newStoreViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}
- (IBAction)revealPublishOptions:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - fetch remote data

- (void) fetch:(int) requestType {
    switch (requestType) {
        case FETCH_STORE_DETAILS: {
            
            [APObject searchObjectsWithSchemaName:@"store" withQueryString:nil successHandler:^(NSDictionary *dict){
                storesDictionaryArray = [dict objectForKey:@"articles"];
                for (int i = 0; i < [storesDictionaryArray count]; i++) {
                    NSDictionary *storeDictionary = [storesDictionaryArray objectAtIndex:i];
                    
                    Store *store = [[Store alloc] init];
                    
                    store.storeName = [storeDictionary objectForKey:@"name"];
                    store.storeAddress = [storeDictionary objectForKey:@"address"];
                    store.storePhone = [storeDictionary objectForKey:@"phone"];
                    store.storeImageUrl = [storeDictionary objectForKey:@"photo"];
                    
                    [stores addObject:store];
//                    NSLog(@"stores fetched are -->> %@", [store description]);
                    [storeTableView reloadData];
                }
            
            } failureHandler:^(APError *error){}];
        }
            break;
            
        default:
            break;
    }
    
}
@end
