//
//  DbZoomTransitionAnimator.h
//  ObjcApp
//
//  Created by Dylan Bui on 4/18/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbZoomDismissAnimatedTransitioning.h"

@class DbZoomTransitionAnimator;

/**
 You need to adopt the DbZoomTransitionAnimating protocol in source view controller and destination
 view controller to make transition animations.
 
 The animator get the image position from a view controller implemented this protocol.
 */
@protocol DbZoomTransitionAnimating <NSObject>

@optional
/**
 Return background color in source view controller.
 
 This color will be used for fade in animation.
 we recommend the background color of source view controller.
 
 @return source view controller's bacground color
 */
- (nonnull UIColor *)transitionSourceBackgroundColor;


@required

/**
 Before the animation occurs, return the UIImageView of transition source view controller.
 
 You should create a new UIImageView object again, so this UIImageView is moving.
 
 @return source view controller's UIImageView before transition.
 */
- (nonnull UIView *)transitionSourceView;

/**
 Returns the UIImageView’s rectangle in a destination view controller.
 
 @return destination view controller's frame for UIImageView
 */
- (CGRect)transitionDestinationViewFrame;

@end


/**
 Delegate handler of viewController which implements transitioning protocol
 */
@protocol DbZoomTransitionDelegate <NSObject>
@optional

/**
 Notify the end of the forward and backward animations.
 
 get the original UIImageView and hide it, while the copy is being animated.
 And when the animation is done, the original could be shown.
 That will prevent the original views to be shown while animating.
 */
- (void)zoomTransitionAnimator:(nonnull DbZoomTransitionAnimator *)animator
         didCompleteTransition:(BOOL)didComplete
           animatingSourceView:(nonnull UIView *)view;

@end


/**
 Animator object that implements UIViewControllerAnimatedTransitioning
 
 You need to return this object in transition delegate method
 */
@interface DbZoomTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

/**
 Init component with custom animation durations.
 */
- (nonnull DbZoomTransitionAnimator *)initWithAnimationDurationForward:(NSTimeInterval)forward
                                                        forwardComplete:(NSTimeInterval)forwardComplete
                                                               backward:(NSTimeInterval)backward
                                                       backwardComplete:(NSTimeInterval)backwardComplete;

/**
 Changes default animation duration. Primarily here for subclassing.
 */
- (void)setDefaultAnimationDuration;

/**
 A Boolean value that determines whether transition animation is going forward.
 */
@property (nonatomic) BOOL goingForward;

/**
 The animator's delegate for transition in source view controller.
 
 You need to set this property and implement the DbZoomTransitionAnimating in source view controller.
 */
@property (nonatomic, weak, nullable) id <DbZoomTransitionAnimating, DbZoomTransitionDelegate> sourceTransition;

/**
 The animator's delegate for transition in destination view controller.
 
 You need to set this property and implement the DbZoomTransitionAnimating in destination view controller.
 */
@property (nonatomic, weak, nullable) id <DbZoomTransitionAnimating, DbZoomTransitionDelegate> destinationTransition;

@end
