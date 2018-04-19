//
//  DbZoomTransitionAnimator.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/18/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbZoomTransitionAnimator.h"

@implementation DbZoomTransitionAnimator
{
    NSTimeInterval kForwardAnimationDuration;
    NSTimeInterval kForwardCompleteAnimationDuration;
    NSTimeInterval kBackwardAnimationDuration;
    NSTimeInterval kBackwardCompleteAnimationDuration;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaultAnimationDuration];
    }
    return self;
}

/**
 Init component with custom animation durations.
 */
- (DbZoomTransitionAnimator * _Nonnull)initWithAnimationDurationForward:(NSTimeInterval)forward
                                                         forwardComplete:(NSTimeInterval)forwardComplete
                                                                backward:(NSTimeInterval)backward
                                                        backwardComplete:(NSTimeInterval)backwardComplete
{
    self = [super init];
    if (self) {
        kForwardAnimationDuration = forward;
        kForwardCompleteAnimationDuration = forwardComplete;
        kBackwardAnimationDuration = backward;
        kBackwardCompleteAnimationDuration = backwardComplete;
    }
    return self;
}

/**
 Sets default animation duration. Written as separate method so it would be overrideable by a subclass
 instead of repeatability having to use the convenience init method.
 */
- (void)setDefaultAnimationDuration {
    kForwardAnimationDuration = 0.3;
    kForwardCompleteAnimationDuration = 0.2;
    kBackwardAnimationDuration = 0.25;
    kBackwardCompleteAnimationDuration = 0.18;
}

#pragma mark - <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.goingForward) {
        return kForwardAnimationDuration + kForwardCompleteAnimationDuration;
    } else {
        return kBackwardAnimationDuration + kBackwardCompleteAnimationDuration;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Setup for animation transition
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView    = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    // Without animation when you have not confirm the protocol
    Protocol *animating = @protocol(DbZoomTransitionAnimating);
    BOOL doesNotConfirmProtocol = ![self.sourceTransition conformsToProtocol:animating] || ![self.destinationTransition conformsToProtocol:animating];
    if (doesNotConfirmProtocol) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        return;
    }
    
    // Add a alphaView To be overexposed, so background becomes dark in animation
    UIView *alphaView = [[UIView alloc] initWithFrame:[transitionContext finalFrameForViewController:toVC]];
//    alphaView.backgroundColor = toVC.view.backgroundColor;
    alphaView.backgroundColor = (self.goingForward ? toVC.view.backgroundColor : fromVC.view.backgroundColor);
    if ([self.sourceTransition respondsToSelector:@selector(transitionSourceBackgroundColor)]) {
        alphaView.backgroundColor = [self.sourceTransition transitionSourceBackgroundColor];
    }
    [containerView addSubview:alphaView];
    
    // -- DucBui: Set toVC frame == fromVC frame  -- 
    toVC.view.frame = fromVC.view.frame;
    [toVC.view layoutIfNeeded];
    
    // Transition source of image to move me to add to the last
    UIView *sourceView = [self.sourceTransition transitionSourceView];
    [containerView addSubview:sourceView];
    
    if (self.goingForward) { // PUSH
        
        // -- DucBui: Remove --
        // Warning : ios unbalanced calls to begin/end appearance transitions for uinavigationcontroller
        // [fromVC beginAppearanceTransition:NO animated:YES];
        
        [UIView animateWithDuration:kForwardAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             sourceView.frame = [self.destinationTransition transitionDestinationViewFrame];
                             sourceView.transform = CGAffineTransformMakeScale(1.02, 1.02);
                             alphaView.alpha = 0.9;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:kForwardCompleteAnimationDuration
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  alphaView.alpha = 0;
                                                  sourceView.transform = CGAffineTransformIdentity;
                                              }
                                              completion:^(BOOL finished) {
                                                  sourceView.alpha = 0;
                                                  if ([self.destinationTransition conformsToProtocol:@protocol(DbZoomTransitionAnimating)] &&
                                                      [self.destinationTransition respondsToSelector:@selector(zoomTransitionAnimator:didCompleteTransition:animatingSourceView:)]) {
                                                      [self.destinationTransition zoomTransitionAnimator:self
                                                                                   didCompleteTransition:![transitionContext transitionWasCancelled]
                                                                                     animatingSourceView:sourceView];
                                                  }
                                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                                  
                                                  // Remove the views from superviews to release the references
                                                  [alphaView removeFromSuperview];
                                                  [sourceView removeFromSuperview];
                                                  
                                                  // -- DucBui: Remove --
                                                  // Warning : ios unbalanced calls to begin/end appearance transitions for uinavigationcontroller
                                                  // [fromVC endAppearanceTransition];
                                              }];
                         }];
        
    } else { // DISMISS
        [UIView animateWithDuration:kBackwardAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             sourceView.frame = [self.destinationTransition transitionDestinationViewFrame];
                             alphaView.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:kBackwardCompleteAnimationDuration
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  sourceView.alpha = 0;
                                              }
                                              completion:^(BOOL finished) {
                                                  if ([self.destinationTransition conformsToProtocol:@protocol(DbZoomTransitionAnimating)] &&
                                                      [self.destinationTransition respondsToSelector:@selector(zoomTransitionAnimator:didCompleteTransition:animatingSourceView:)]) {
                                                      [self.destinationTransition zoomTransitionAnimator:self
                                                                                   didCompleteTransition:![transitionContext transitionWasCancelled]
                                                                                animatingSourceView:sourceView];
                                                  }
                                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                                  if(![[UIApplication sharedApplication].keyWindow.subviews containsObject:toVC.view]) {
                                                      [[UIApplication sharedApplication].keyWindow addSubview:toVC.view];
                                                  }
                                                  // Remove the views from superviews to release the references
                                                  [alphaView removeFromSuperview];
                                                  [sourceView removeFromSuperview];
                                              }];
                         }];
    }
}

@end


