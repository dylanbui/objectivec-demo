//
//  RevealFromFrameAnimator.m
//  ObjcApp
//
//  Created by Dylan Bui on 5/2/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "RevealFromFrameAnimator.h"

@interface RevealFromFrameAnimator()

//__weak id animationContext;

@end

@implementation RevealFromFrameAnimator

- (instancetype)init
{
    if (self = [super init]) {
        self.duration = 0.3;
        self.forward = YES;
        self.originFrame = CGRectZero;
    }
    return self;
}

- (CAShapeLayer *)maskLayerForAnimation:(CGRect)frame
{
    CAShapeLayer* maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    CGRect maskRect = frame;
    CGPathRef path = CGPathCreateWithRect(maskRect, nil); //CGPath(rect: maskRect, transform: nil)
    maskLayer.path = path;
    return maskLayer;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.animationContext = transitionContext;
    // Setup for animation transition
    UIView *containerView    = [transitionContext containerView];
    
    UIView *originView;
    UIView *animatedView;
    
    if (self.forward) {
        animatedView = [transitionContext viewForKey:UITransitionContextToViewKey];
        originView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [containerView addSubview:animatedView];
    } else {
        animatedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        originView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [containerView addSubview:originView];
        [containerView addSubview:animatedView];
    }
    
    CGRect startFrame;
    CGPathRef newPath;
    
    if (self.forward) {
        startFrame = self.originFrame;
        newPath = CGPathCreateWithRect(animatedView.frame, nil);
    } else {
        startFrame = animatedView.frame;
        newPath = CGPathCreateWithRect(self.originFrame, nil);
    }
    
    CAShapeLayer *maskLayer = [self maskLayerForAnimation:startFrame];
    animatedView.layer.mask = maskLayer;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.delegate = self;
    pathAnimation.fromValue = (__bridge id _Nullable)(maskLayer.path);
    pathAnimation.toValue = (__bridge id _Nullable)(newPath);
    pathAnimation.duration = self.duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    maskLayer.path = newPath;
    [maskLayer addAnimation:pathAnimation forKey:@"path"];
    
}

// MARK: - CAAnimationDelegate Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.animationContext completeTransition:flag];
}

@end
