//
//  RMPExampleViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/18/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "RMPExampleViewController.h"

#import "RMPImageTableViewController.h"
#import "RMPImageCollectionViewController.h"

@interface RMPExampleViewController ()

@end

@implementation RMPExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Zoom Transition";
}

- (IBAction)btn_Click:(UIButton *)sender
{
    UIViewController *vcl = nil;
    if (sender.tag == 1) {
        vcl = [[RMPImageTableViewController alloc] init];
    } else {
        vcl = [[RMPImageCollectionViewController alloc] init];
    }
    
    [self.navigationController pushViewController:vcl animated:YES];
}

@end
