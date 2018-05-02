//
//  RevealFromFrameAnimator.h
//  ObjcApp
//
//  Created by Dylan Bui on 5/2/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RevealFromFrameAnimator : NSObject <CAAnimationDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic) float duration;
@property (nonatomic) BOOL forward;
@property (nonatomic) CGRect originFrame;

@property (weak) id<UIViewControllerContextTransitioning> animationContext;


- (instancetype)init;



@end
