//
//  CoursesViewController.m
//  TestApp
//
//  Created by Dylan Bui on 8/3/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "CoursesViewController.h"
#import "DetailCoursesViewController.h"
#import "NavigationBarView.h"

@interface CoursesViewController ()



@property (nonatomic, strong) NavigationBarView *navBaseView;


@end

@implementation CoursesViewController

- (id)init
{
    if (self = [super init]) {
        self.navBaseView = [[NavigationBarView alloc] initWithViewController:self];
        [self.navBaseView.lblMainTitle setText:@"CoursesViewController"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navBaseView.lblSecondTitle setText:@"Courses-Second"];
    
//    [self navigationBarHiddenForThisController];
    // Do any additional setup after loading the view from its nib.
    // self.navigationItem.hidesBackButton = YES;
    
//    NavigationBarView *navView = [[NavigationBarView alloc] initWithViewController:self];
//    [navView.lblMainTitle setText:@"CoursesViewController"];
//    self.navBaseView = navView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    __weak id weakSelf = self;
    //    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
//    self.navView = [[NavigationBarView alloc] initWithViewController:self];
//    [self.navView.lblMainTitle setText:@"CoursesViewController"];
//    [self.navView showNavigation];
//    [navView setTag:123456];
//    navView.frame = (CGRect){100 ,0 ,navView.frame.size}; // Tuong duong  CGRectMake
//    navView.alpha = 0;
//    navView.parentViewController = self;
//    [self.navigationController.navigationBar addSubview:navView];
//    [UIView animateWithDuration:0.25 animations:^{
//        navView.alpha = 1;
//        navView.frame = (CGRect){0 ,0 ,navView.frame.size}; // Tuong duong  CGRectMake
////        [self.navigationController.navigationBar bringSubviewToFront:navView];
//    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navView hideNavigation];
//    UIView *view = (UIView *)[self.navigationController.navigationBar viewWithTag:123456];
//    [UIView animateWithDuration:0.25 animations:^{
//        view.alpha = 0;
//        view.frame = (CGRect){100 ,0 ,view.frame.size}; // Tuong duong  CGRectMake
//    } completion:^(BOOL finished) {
//        [view removeFromSuperview];
//    }];    
}

- (void)styleNavBar
{
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)];
//    [newNavBar setTintColor:[UIColor whiteColor]];
//    UINavigationItem *newItem = [[UINavigationItem alloc] init];
//    newItem.title = @"CoursesViewController";
//    
//    // BackButtonBlack is an image we created and added to the app’s asset catalog
//    UIImage *backButtonImage = [UIImage imageNamed:@"BackButtonBlack"];
//    
//    // any buttons in a navigation bar are UIBarButtonItems, not just regular UIButtons. backTapped: is the method we’ll call when this button is tapped
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
//    
//    // the bar button item is actually set on the navigation item, not the navigation bar itself.
////    newItem.leftBarButtonItem = backBarButtonItem;
//    newItem.leftBarButtonItem = nil;
//    
//    [newNavBar setItems:@[newItem]];
//    [self.view addSubview:newNavBar];
}

- (IBAction)btnBack_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDetail_Click:(id)sender
{
    DetailCoursesViewController *vcFirst = [[DetailCoursesViewController alloc] init];
    // [vcFirst.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController pushViewController:vcFirst animated:YES];
}

- (void)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
