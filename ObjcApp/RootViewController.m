//
//  RootViewController.m
//  SAM_Demo
//
//  Created by Dylan Bui on 12/28/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import "RootViewController.h"
#import "PathsViewController.h"
#import "UserSessionViewController.h"
#import "ExpandLayoutViewController.h"
#import "ScrollViewFormViewController.h"
#import "DemoButtonViewController.h"

#import "TableExpandCellViewController.h"

#import "DetailTaskViewController.h"
#import "KeyboardViewController.h"

//#import "UINavigationController+Utils.h"
//
//#import "LoginViewController.h"
//
//#import "MainTabbarViewController.h"
//
//#import "UserApi.h"
//
//// -- Demo --
//#import "InviteViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


//@synthesize loginViewController;
//@synthesize mainTabbarViewController;


- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self navigationBarHiddenForThisController];
    // Do any additional setup after loading the view.
    
    // -- Save RootViewController --
//    appDelegate.rootViewController = self;    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    PathsViewController *vcFirst = [[PathsViewController alloc] init];
//    UserSessionViewController *vcFirst = [[UserSessionViewController alloc] init];
//    ExpandLayoutViewController *vcFirst = [[ExpandLayoutViewController alloc] init];
//    TableExpandCellViewController *vcFirst = [[TableExpandCellViewController alloc] init];
//    ScrollViewFormViewController *vcFirst = [[ScrollViewFormViewController alloc] init];
//    DetailTaskViewController *vcFirst = [[DetailTaskViewController alloc] init];
    //DemoButtonViewController *vcFirst = [[DemoButtonViewController alloc] init];
    KeyboardViewController *vcFirst = [[KeyboardViewController alloc] init];
    [vcFirst.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController pushOrReplaceToFirstViewController:vcFirst animated:NO];
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
