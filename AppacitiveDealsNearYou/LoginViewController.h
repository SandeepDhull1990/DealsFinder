//
//  LoginViewController.h
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 14/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

typedef void (^LoginWithFacebookSuccessful) ();
typedef void (^LoginWithTwitterSuccessfull) ();

@interface LoginViewController : UIViewController
@property (nonatomic, copy) LoginWithFacebookSuccessful loginWithFacebookSuccessful;
@property (nonatomic, copy) LoginWithTwitterSuccessfull loginWithTwitterSuccessful;
@end
