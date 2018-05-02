//
//  PresentedViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 5/2/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()

@end

@implementation PresentedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Presented View Controller";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
