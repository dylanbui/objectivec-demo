//
//  DbZoomDismissAnimatedTransitioning.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/18/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbZoomDismissAnimatedTransitioning.h"

@interface DbZoomDismissAnimatedTransitioning ()

@property (nonatomic, weak) UIViewController *sourceVcl;

@end

@implementation DbZoomDismissAnimatedTransitioning

- (instancetype)initWithSourceController:(UIViewController *)vcl
{
    if (self = [super init]) {
        self.sourceVcl  = vcl;
    }
    return self;
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    id <DbZoomTransitionAnimating, DbZoomTransitionDelegate> sourceTransition = (id<DbZoomTransitionAnimating, DbZoomTransitionDelegate>)source;
    id <DbZoomTransitionAnimating, DbZoomTransitionDelegate> destinationTransition = (id<DbZoomTransitionAnimating, DbZoomTransitionDelegate>)presented;
    if ([sourceTransition conformsToProtocol:@protocol(DbZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(DbZoomTransitionAnimating)]) {
        DbZoomTransitionAnimator *animator = [[DbZoomTransitionAnimator alloc] init];
        animator.goingForward = YES;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id <DbZoomTransitionAnimating, DbZoomTransitionDelegate> sourceTransition = (id<DbZoomTransitionAnimating, DbZoomTransitionDelegate>)dismissed;
    id <DbZoomTransitionAnimating, DbZoomTransitionDelegate> destinationTransition = (id<DbZoomTransitionAnimating, DbZoomTransitionDelegate>)self.sourceVcl; //self;
    if ([sourceTransition conformsToProtocol:@protocol(DbZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(DbZoomTransitionAnimating)]) {
        DbZoomTransitionAnimator *animator = [[DbZoomTransitionAnimator alloc] init];
        animator.goingForward = NO;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}


@end
