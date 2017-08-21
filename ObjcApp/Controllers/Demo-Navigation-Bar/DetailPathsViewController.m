//
//  DetailPathsViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/21/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DetailPathsViewController.h"

#import "NavigationBarTitleView.h"

@interface DetailPathsViewController ()

@property (nonatomic, strong) NavigationBarTitleView *navBaseView;

@end

@implementation DetailPathsViewController

- (id)init
{
    if (self = [super init]) {
        self.navBaseView = [[NavigationBarTitleView alloc] initWithViewController:self];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnBack_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
