//
//  DbActionView.m
//  ObjcApp
//
//  Created by Dylan Bui on 9/1/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbActionView.h"

#define kActionViewFlatGreenColor [UIColor colorWithRed:46/255.0f green:204/255.0f blue:113/255.0f alpha:1.0f]

@interface DbActionView () <UIGestureRecognizerDelegate> {
    
    NSMutableDictionary *dictOldProperty;

}

@end

@implementation DbActionView

- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self initialize];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self initialize];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if (enabled) {
        self.alpha = 1.0;
    } else {
        self.alpha = _disableAlpha;
    }
    [self setNeedsDisplay];
}

//- (void)setNeedsLayout
//{
//    [super setNeedsLayout];
//    [self setNeedsDisplay];
//}

- (void)defaultSetup
{
    // -- _masksToBounds == NO => show shadown --
    // -- Khi hien shadow thi border radius khong co merger voi child view --
    if (!_masksToBounds) { _masksToBounds = NO;}
    
    if (!_cornerRadius) { _cornerRadius = 0.0;}
    if (!_borderColor) { _borderColor = kActionViewFlatGreenColor;}
    if (!_borderWidth) { _borderWidth = 0.0;}
    
    if (!_shadowColor) { _shadowColor = [UIColor lightGrayColor];}
    if (!_shadowOpacity) { _shadowOpacity = 0.0;}
    if (!_shadowRadius) { _shadowRadius = 0.0;}
    if (CGSizeEqualToSize(_shadowOffset, CGSizeZero)) { _shadowOffset = CGSizeZero; }
    
    if (!_highlightAlpha) { _highlightAlpha = 0.7;}
    if (!_disableAlpha) { _disableAlpha = 0.5;}
    
    if (self.backgroundColor) {
        dictOldProperty = nil;
        dictOldProperty = [[NSMutableDictionary alloc] init];
        [dictOldProperty setObject:self.backgroundColor forKey:@"backgroundColor"];
    }
}

- (void)initialize
{
    [self defaultSetup];
    
    [self.layer setMasksToBounds:_masksToBounds];
    
    // Borders
    [self.layer setCornerRadius:_cornerRadius];
    [self.layer setBorderWidth:_borderWidth];
    [self.layer setBorderColor:_borderColor.CGColor];
    
    // Drop shadow
    [self.layer setShadowColor:_shadowColor.CGColor];
    [self.layer setShadowOpacity:_shadowOpacity];
    [self.layer setShadowRadius:_shadowRadius];
    [self.layer setShadowOffset:_shadowOffset];

    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(btnView_Click:)];
    singleFingerTap.delegate = nil;
    [self removeGestureRecognizer:singleFingerTap];

    if (self.enabled) {
        singleFingerTap.delegate = self;
        [self addGestureRecognizer:singleFingerTap];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setBackgroundColor:_touchUpInsideColor];    
}

- (IBAction)btnView_Click:(UIGestureRecognizer *)gestureRecognizer
{
    [UIView animateWithDuration:0.1 animations:^{
        [self setBackgroundColor:[dictOldProperty objectForKey:@"backgroundColor"]];
    } completion:^(BOOL finished) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    
//    switch (gestureRecognizer.state) {
//        case UIGestureRecognizerStatePossible:
//            NSLog(@"%@", @"UIGestureRecognizerStatePossible");
//            break;
//            
//        case UIGestureRecognizerStateBegan:
//            NSLog(@"%@", @"UIGestureRecognizerStateBegan");
//            break;
//            
//        case UIGestureRecognizerStateChanged:
//            NSLog(@"%@", @"UIGestureRecognizerStateChanged");
//            break;
//            
//        case UIGestureRecognizerStateEnded:
//            NSLog(@"%@", @"UIGestureRecognizerStateEnded");
//            break;
//            
//        case UIGestureRecognizerStateCancelled:
//            NSLog(@"%@", @"UIGestureRecognizerStateCancelled");
//            break;
//            
//        case UIGestureRecognizerStateFailed:
//            NSLog(@"%@", @"UIGestureRecognizerStateFailed");
//            break;
//            
//        default:
//            NSLog(@"%@", @"NONEEEE");
//            break;
//    }
//    
//    NSLog(@"%@", @"click");
}

#pragma mark - Setters

- (void)setMasksToBounds:(BOOL)masksToBounds
{
    _masksToBounds = masksToBounds;
    [self initialize];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (fabs(cornerRadius) != _cornerRadius) {
        _cornerRadius = fabs(cornerRadius);
        [self initialize];
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (borderColor != _borderColor) {
        _borderColor = borderColor;
        [self initialize];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (fabs(borderWidth) != _borderWidth) {
        _borderWidth = fabs(borderWidth);
        [self initialize];
    }
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    if (shadowColor != _shadowColor) {
        _shadowColor = shadowColor;
        [self initialize];
    }    
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    if (fabs(shadowOpacity) != _shadowOpacity) {
        _shadowOpacity = fabs(shadowOpacity);
        [self initialize];
    }
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    if (!CGSizeEqualToSize(shadowOffset, _shadowOffset)) {
        _shadowOffset = shadowOffset;
        [self initialize];
    }
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    if (fabs(shadowRadius) != _shadowRadius) {
        _shadowRadius = fabs(shadowRadius);
        [self initialize];
    }
}

- (void)setHighlightAlpha:(CGFloat)highlightAlpha
{
    if (fabs(highlightAlpha) != _highlightAlpha) {
        _highlightAlpha = fabs(highlightAlpha);
        [self initialize];
    }
}

- (void)setDisableAlpha:(CGFloat)disableAlpha
{
    if (fabs(disableAlpha) != _disableAlpha) {
        _disableAlpha = fabs(disableAlpha);
        [self initialize];
    }
}

- (void)setTouchUpInsideColor:(UIColor *)touchUpInsideColor
{
    if (touchUpInsideColor != _touchUpInsideColor) {
        _touchUpInsideColor = touchUpInsideColor;
        [self initialize];
    }
}

@end
