//
//  NavigationBarBaseView.m
//  PropzyPama
//
//  Created by Dylan Bui on 8/11/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbNavigationBarView.h"

@implementation DbNavigationBarView

- (id)initWithViewController:(UIViewController *)containerViewController
{
    if (self = [super init]) {
        self.vclContainer = containerViewController;
        [self initView];
    }
    
    return self;
}

- (void)initView
{
    // -- Navigation frame --
    CGRect viewFrame = (CGRect){
        .origin = {0, 0},
        .size.width = [[UIScreen mainScreen] bounds].size.width,
        .size.height = self.frame.size.height
    };
    // self.frame = (CGRect) {0, 0, [[UIScreen mainScreen] bounds].size.width, 44};
    self.frame = viewFrame;
    
    // -- Turn off back button --
    self.vclContainer.navigationItem.hidesBackButton = YES;
    // -- Set empty back title --
//    self.vclContainer.navigationController.navigationBar.topItem.title = @"";
//    self.vclContainer.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                                          style:UIBarButtonItemStylePlain
//                                                                                         target:nil
//                                                                                         action:nil];
    // -- Fix error 3 dots --
    // https://stackoverflow.com/questions/22425356/title-shows-3-dots-instead-of-the-string-in-a-toggle-button
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}
//                                                forState:UIControlStateNormal];
    
    // -- Fix error 3 dots way 2 : Remove Back Text --
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];

    
    // -- Hide all control --
    [self hideAllItemNavigationBar];
    
    self.backgroundColor = [self.vclContainer.navigationController.navigationBar barTintColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerViewDidLoad:)
                                                 name:NOTIFY_VCL_DID_LOAD object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerViewWillAppear:)
                                                 name:NOTIFY_VCL_WILL_APPEAR object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerViewWillDisappear:)
                                                 name:NOTIFY_VCL_WILL_DISAPPEAR object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)controllerViewDidLoad:(NSNotification *)notification
{
    if ([notification.object isEqual:self.vclContainer]) {
    }
}

- (void)controllerViewWillAppear:(NSNotification *)notification
{
    if ([notification.object isEqual:self.vclContainer]) {
        // NSLog(@"%@", @"controllerViewWillAppear");
        [self showNavigation];
    }
}

- (void)controllerViewWillDisappear:(NSNotification *)notification
{
    if ([notification.object isEqual:self.vclContainer]) {
        // NSLog(@"%@", @"controllerViewWillDisappear");
        [self hideNavigation];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (IBAction)btnBack_Click:(id)sender
{
    [self.vclContainer.navigationController popViewControllerAnimated:YES];
}

- (void)showNavigation
{
    [self.vclContainer.navigationController.navigationBar addSubview:self];
    
    self.alpha = 0.5;
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            [self showAllItemNavigationBar];
        }];
    }];
}

- (void)hideNavigation
{
    [UIView animateWithDuration:0.4 animations:^{
        [self hideAllItemNavigationBar];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}


- (void)hideAllItemNavigationBar
{
    for (UIView *viewControl in self.subviews) {
        if ([viewControl isKindOfClass:[UILabel class]]) {
            viewControl.alpha = 0;
            viewControl.tag = viewControl.frame.origin.x;
            viewControl.frame = (CGRect) {viewControl.frame.origin.x + 100, viewControl.frame.origin.y, viewControl.frame.size};
        } else if ([viewControl isKindOfClass:[UIButton class]] || [viewControl isKindOfClass:[UIBarButtonItem class]]) {
            viewControl.alpha = 0;
        }
    }
}

- (void)showAllItemNavigationBar
{
    for (UIView *viewControl in self.subviews) {
        if ([viewControl isKindOfClass:[UILabel class]]) {
            viewControl.alpha = 1;
            viewControl.frame = (CGRect) {viewControl.tag, viewControl.frame.origin.y, viewControl.frame.size};
        } else if ([viewControl isKindOfClass:[UIButton class]] || [viewControl isKindOfClass:[UIBarButtonItem class]]) {
            viewControl.alpha = 1;
        }
    }
}

@end
