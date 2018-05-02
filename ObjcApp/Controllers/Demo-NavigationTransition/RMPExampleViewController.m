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


#import "PresentReverseAnimator.h"
#import "RevealFromFrameAnimator.h"
#import "PresentedViewController.h"
#import "PushedViewController.h"

@interface RMPExampleViewController () <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@end

@implementation RMPExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Zoom Transition";
    self.navigationController.delegate = self;
}

- (IBAction)presentButton_Click:(id)sender
{
    PresentedViewController *vcl = [[PresentedViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vcl];
    nav.transitioningDelegate = self;    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (IBAction)pushButton_Click:(id)sender
{
    // -- Dung pushViewController khong on dinh, chay ko tot --
    // -- nen dung presentViewController voi UINavigationController khac --
    PushedViewController *vcl = [[PushedViewController alloc] init];
    [self.navigationController pushViewController:vcl animated:YES];
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

// MARK: - UIViewControllerAnimatedTransitioning Delegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    RevealFromFrameAnimator *transition = [[RevealFromFrameAnimator alloc] init];
    transition.originFrame = self.pushButton.frame;
    transition.forward = (operation == UINavigationControllerOperationPush);
    return transition;
}

// MARK: - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    PresentReverseAnimator *animator = [[PresentReverseAnimator alloc] init];
    animator.isPresenting = YES;
    return animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    PresentReverseAnimator *animator = [[PresentReverseAnimator alloc] init];
    animator.isPresenting = NO;
    return animator;
}

@end
