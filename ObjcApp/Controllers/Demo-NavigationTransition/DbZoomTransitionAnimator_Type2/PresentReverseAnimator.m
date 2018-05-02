//
//  PresentReverseAnimator.m
//  ObjcApp
//
//  Created by Dylan Bui on 5/2/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "PresentReverseAnimator.h"

@implementation PresentReverseAnimator

- (instancetype)init
{
    if (self = [super init]) {
        self.duration = 0.3;
        self.isPresenting = YES;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Setup for animation transition
    UIView *containerView    = [transitionContext containerView];

    UIView *animatedView;
    UIView *destinationView;
    CGRect destinationFrame;
    
    if (self.isPresenting) {
        animatedView = [transitionContext viewForKey:UITransitionContextToViewKey];
        animatedView.frame = CGRectMake(0.0, -animatedView.frame.size.height, animatedView.frame.size.width, animatedView.frame.size.height);
        destinationFrame = CGRectMake(0.0, 0.0, animatedView.frame.size.width, animatedView.frame.size.height);
        [containerView addSubview:animatedView];
    } else {
        animatedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        destinationView = [transitionContext viewForKey:UITransitionContextToViewKey];
        destinationFrame = CGRectMake(0.0, -animatedView.frame.size.height, animatedView.frame.size.width, animatedView.frame.size.height);
        [containerView addSubview:destinationView];
        [containerView addSubview:animatedView];
    }
    
    [UIView animateWithDuration:self.duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        animatedView.frame = destinationFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
    
}


@end
