//
//  MenuFindDealsViewController.m
//  AppacitiveDealsNearYou
//
//  Created by Sonia Mane on 18/01/13.
//  Copyright (c) 2013 Appacitive. All rights reserved.
//

#import "MenuFindDealsViewController.h"

@interface MenuFindDealsViewController () {
    UIView *_footerView;
}
@property (strong, nonatomic) NSArray *menuItems;
@end

@implementation MenuFindDealsViewController
@synthesize menuItems;

- (void)awakeFromNib {
    self.menuItems = [NSArray arrayWithObjects:@"Find near by Deals", nil];
    //  NSLog(@"in awake from nib");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"in view did load");
//    [self.slidingViewController setAnchorRightRevealAmount:280.f];
//    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
}

#pragma mark TableView Data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellIdentifier = @"MenuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
    return cell;
}

# pragma mark TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationTop"];
    
//    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
//        CGRect frame = self.slidingViewController.topViewController.view.frame;
//        self.slidingViewController.topViewController = newStoreViewController;
//        self.slidingViewController.topViewController.view.frame = frame;
//        [self.slidingViewController resetTopView];
//    }];
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
        [button setTitle:@"Logout" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //set action of the button
        [button addTarget:self action:@selector(logout:)
         forControlEvents:UIControlEventTouchUpInside];
        
        //add the button to the view
        [_footerView addSubview:button];
    }
    
    return _footerView;
}

- (void)logout:(id) sender {
    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    
//    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
//        CGRect frame = self.slidingViewController.topViewController.view.frame;
//        self.slidingViewController.topViewController = newStoreViewController;
//        self.slidingViewController.topViewController.view.frame = frame;
//        [self.slidingViewController resetTopView];
//    }];

}
- (IBAction)backToDealsList:(id)sender {
    UIViewController *newStoreViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    
//    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
//        CGRect frame = self.slidingViewController.topViewController.view.frame;
//        self.slidingViewController.topViewController = newStoreViewController;
//        self.slidingViewController.topViewController.view.frame = frame;
//        [self.slidingViewController resetTopView];
//    }];
    
}
@end
