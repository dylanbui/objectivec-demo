//
//  PathsViewController.m
//  TestApp
//
//  Created by Dylan Bui on 8/3/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "PathsViewController.h"
#import "CoursesViewController.h"
//#import "NavigationBarView.h"
//#import "Constant.h"

@interface PathsViewController ()

@end

@implementation PathsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self navigationBarHiddenForThisController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self styleNavBar];
    
//    __weak id weakSelf = self;
//    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    
//    NavigationBarView *navView = [[NavigationBarView alloc] init];
//    [navView setTag:123456];
////    CGRect frameOld = navView.frame;
//    
//    navView.frame = (CGRect){50 ,0 ,navView.frame.size}; // Tuong duong  CGRectMake
//    navView.alpha = 0;
//    [self.navigationController.navigationBar addSubview:navView];
//    [UIView animateWithDuration:0.25 animations:^{
//        navView.alpha = 1;
//        navView.frame = (CGRect){0 ,0 ,navView.frame.size}; // Tuong duong  CGRectMake
//        [self.navigationController.navigationBar bringSubviewToFront:navView];
//    }];    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    UIView *view = (UIView *)[self.navigationController.navigationBar viewWithTag:123456];
//    [UIView animateWithDuration:0.25 animations:^{
//        view.alpha = 0;
//        view.frame = (CGRect){50 ,0 ,view.frame.size}; // Tuong duong  CGRectMake
//    } completion:^(BOOL finished) {
//       [view removeFromSuperview];
//    }];
}


- (IBAction)btnPush_Click:(id)sender
{
    CoursesViewController *vcFirst = [[CoursesViewController alloc] init];
    // [vcFirst.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController pushViewController:vcFirst animated:YES];
}

- (void)styleNavBar
{
//    // 1. hide the existing nav bar
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    
//    // 2. create a new nav bar and style it
//    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)];
//    [newNavBar setTintColor:[UIColor whiteColor]];
//    
//    // 3. add a new navigation item w/title to the new nav bar
//    UINavigationItem *newItem = [[UINavigationItem alloc] init];
//    newItem.title = @"Paths";
//    [newNavBar setItems:@[newItem]];
//    
//    // 4. add the nav bar to the main view
//    [self.view addSubview:newNavBar];
}

@end
