//
//  CreateStoreViewController.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateStoreViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *clickPhotoForStoreButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageCaptured;
@property (strong, nonatomic) IBOutlet UITextField *storeName;
@property (strong, nonatomic) IBOutlet UITextView *storeAddress;
@property (strong, nonatomic) IBOutlet UITextField *storePhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *storeLocation;

- (IBAction)revealPublishOptions:(id)sender;
- (IBAction)doneButton:(id)sender;
- (IBAction)clickPhotoForStore:(id)sender;
- (IBAction)fetchCurrentLocation:(id)sender;

@end
