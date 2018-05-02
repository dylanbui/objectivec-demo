//
//  ScrollViewType1ViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 5/1/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "ScrollViewType1ViewController.h"

@interface ScrollViewType1ViewController ()

@end

@implementation ScrollViewType1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"ScrollViewType 1";
    // -- Van dung duoc neu an NavigationBar nhung se hien thi duoi StatusBar
    // [self navigationBarHiddenForThisController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // -- Phai su dung trong viewWillAppear vi luc nay moi co frame size cu the
    // -- Dung them phuong thuc loading de an viewContent
    [self.viewContent removeFromSuperview];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [scrollView addSubview:self.viewContent];
    [self.view addSubview:scrollView];

    scrollView.contentSize = self.viewContent.frame.size;
}



@end
