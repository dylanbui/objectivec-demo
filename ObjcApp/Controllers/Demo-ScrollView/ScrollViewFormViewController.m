//
//  ScrollViewFormViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/27/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "ScrollViewFormViewController.h"

@interface ScrollViewFormViewController ()

@end

@implementation ScrollViewFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"self.view.frame = %@", NSStringFromCGRect(self.view.frame));
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"self.view.frame = %@", NSStringFromCGRect(self.view.frame));
}


@end
