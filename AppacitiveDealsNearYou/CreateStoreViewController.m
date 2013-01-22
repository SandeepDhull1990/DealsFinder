//
//  CreateStoreViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "CreateStoreViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "Store.h"
#import "StoreImage.h"

@interface CreateStoreViewController ()
@property (strong, nonatomic) Store *store;
@end

@implementation CreateStoreViewController
@synthesize clickPhotoForStoreButton, imageCaptured, store, storeName, storeAddress, storeLocation, storePhoneNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    NSString *imageKey = [store storeImageKey];
    if (imageKey) {
        UIImage *imageToDisplay = [[StoreImage sharedInstance] imageForKey:imageKey];
        [imageCaptured setImage:imageToDisplay];
    } else {
        [imageCaptured setImage:nil];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageCaptured.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealPublishOptions:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)doneButton:(id)sender {
    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationTopCreateDeal"];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newStoreViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];

}

- (IBAction)clickPhotoForStore:(id)sender {
    self.clickPhotoForStoreButton.hidden = YES;
    self.imageCaptured.hidden = NO;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        NSLog(@"camera available");
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        NSLog(@"camera not available");
    }
    
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:^(){}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    NSString *key = (__bridge NSString *)newUniqueIDString;
    [store setStoreImageKey:key];
    [[StoreImage sharedInstance] setImage:image forKey:key];
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    [imageCaptured setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)fetchCurrentLocation:(id)sender {
    // fetching the current location
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if ([storeName isFirstResponder]) {
//        return [storeName resignFirstResponder];
//    }

}
@end
