//
//  RippleEffectView.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/7/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RippleEffectView.h"

@interface RippleEffectView ()
{

    NSTimer *repeatsAnimation;
    
}

@property (nonatomic,strong) CAShapeLayer *circleShape;

@end

@implementation RippleEffectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)drawImageWithFrame:(UIImage *)image Frame:(CGRect)frame Color:(UIColor*)bordercolor
{
    buttonImage = [[UIImageView alloc]initWithImage:image];
    buttonImage.frame = CGRectMake(0, 0, frame.size.width-5, frame.size.height-5);
    buttonImage.layer.borderColor = [UIColor clearColor].CGColor;
    buttonImage.layer.borderWidth = 3;
    buttonImage.clipsToBounds = YES;
    buttonImage.layer.cornerRadius = buttonImage.frame.size.height/2;
    [self addSubview:buttonImage];
    
    buttonImage.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.borderWidth = 2;
    self.layer.borderColor = (bordercolor == nil ? [UIColor clearColor].CGColor : bordercolor.CGColor);
    
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonTapped:)];
    [self addGestureRecognizer:tapGesture];
    repeatsAnimation = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(continuousRipples) userInfo:nil repeats:YES];
}


-(instancetype)initWithImage:(UIImage *)image
                       Frame:(CGRect)frame
                       Color:(UIColor*)bordercolor
                      Target:(SEL)action
                          ID:(id)sender
{
    self = [super initWithFrame:frame];
    
    if(self){
        [self drawImageWithFrame:image Frame:frame Color:bordercolor];
        selectedMethod = action;
        senderid = sender;
    }
    
    return self;
}

-(instancetype)initWithImage:(UIImage *)image Frame:(CGRect)frame didEnd:(onFinish)executeOnFinish
{
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self drawImageWithFrame:image Frame:frame Color:bordercolor];
        self.block = executeOnFinish;
    }
    
    return self;
}

-(void)setBorderColor:(UIColor *)color
{
    bordercolor = color;
}

- (void)setRippleColor:(UIColor *)color
{
    rippleColor = color;
}

- (void)setRippleTrailColor:(UIColor *)color
{
    rippleTrailColor = color;
}

-(void)buttonTapped:(id)sender
{
    // -- clear all animation --
    if (repeatsAnimation) {
        // -- Stop animation --
        [repeatsAnimation invalidate];
        repeatsAnimation = nil;
    }
    [self.circleShape removeAllAnimations];
    [self.circleShape removeFromSuperlayer];

    // -- Run animation --
    [self continuousRipples];
    
    [UIView animateWithDuration:1.1 animations:^{
        buttonImage.alpha = 0.4;
        self.layer.borderColor = rippleColor.CGColor;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:2.2 animations:^{           //Edit animateWithDuration value to change ripple animtion time
            buttonImage.alpha = 1;
            self.layer.borderColor = rippleColor.CGColor;
        }completion:^(BOOL finished) {
            if([senderid respondsToSelector:selectedMethod]){
                [senderid performSelectorOnMainThread:selectedMethod withObject:nil waitUntilDone:NO];
            }
            
            if(_block) {
                BOOL success= YES;
                _block(success);
            }
        }];
        
    }];
}



-(void)continuousRipples
{
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
    CGPoint shapePosition = [self convertPoint:self.center fromView:nil];
    
    self.circleShape = [CAShapeLayer layer];
    self.circleShape.path = path.CGPath;
    self.circleShape.position = shapePosition;
    self.circleShape.fillColor = rippleTrailColor.CGColor;
    self.circleShape.opacity = 0;
    self.circleShape.strokeColor = rippleColor.CGColor;
    self.circleShape.lineWidth = 2;
    
    [self.layer addSublayer:self.circleShape];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @0.5;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = 2.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.circleShape addAnimation:animation forKey:nil];
}


@end
