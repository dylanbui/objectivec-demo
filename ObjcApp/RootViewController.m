//
//  RootViewController.m
//  SAM_Demo
//
//  Created by Dylan Bui on 12/28/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

#import "STCalendarHeaderViewController.h"
#import "MapDrawingViewController.h"
#import "RangeSliderViewController.h"
#import "DemoMyCameraViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = NO;
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self navigationBarHiddenForThisController];
    // Do any additional setup after loading the view.
    
    // -- Save RootViewController --
//    appDelegate.rootViewController = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    ViewController *vcFirst = [[ViewController alloc] init];
    // STCalendarHeaderViewController *vcFirst = [[STCalendarHeaderViewController alloc] init];
//    MapDrawingViewController *vcFirst = [[MapDrawingViewController alloc] init];
//    RangeSliderViewController *vcFirst = [[RangeSliderViewController alloc] init];
    DemoMyCameraViewController *vcFirst = [[DemoMyCameraViewController alloc] init];
//    [vcFirst.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController pushOrReplaceToFirstViewController:vcFirst animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [[UserSession instance] doLogout];
//    [self showLoginViewController];
//    return;
    
    // ------------------------
//    if ([[UserSession instance] isLogin] == NO) {
//        // -- Show login form --
//        [self showLoginViewController];
//    } else {
//        
//        // -- Reload user data --
//        // [[UserSession instance] reloadDataFromLastSession];
//        [self.appDelegate.rootViewController showMainTabbarViewController];
//    }
}

//- (void)showMainTabbarViewController
//{
//    self.mainTabbarViewController = [[MainTabbarViewController alloc] init];
//    [self.navigationController pushOrReplaceToFirstViewController:self.mainTabbarViewController animated:YES];
//}
//
//- (void)showLoginViewController
//{
//    self.loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"sidLoginViewController"];
//    [self.navigationController pushOrReplaceToFirstViewController:self.loginViewController animated:YES];
//}
//
//- (void)doLogout
//{
//    // -- Clear token --
//    NSDictionary *params = @{@"deviceToken": [[UserSession instance] getDevicePushNotificationToken], @"osName": @"iOS"};
//    [UserApi doLogout:params];
//    
//    // -- Logout user --
//    [[UserSession instance] doLogout];
//    
//    // -- Load login page --
//    [self showLoginViewController];
//}

@end
