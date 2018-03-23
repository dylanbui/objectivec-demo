//
//  DbTextField.m
//  ObjcApp
//
//  Created by Dylan Bui on 3/23/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbTextField.h"

@implementation DbTextField

- (instancetype)init
{
    if (self = [super init]) {
        _contentEdgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _contentEdgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _contentEdgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, _contentEdgeInsets.left, _contentEdgeInsets.right);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds
{
//    return CGRectInset(bounds, 10, 10);
    return CGRectInset(bounds, _contentEdgeInsets.left, _contentEdgeInsets.right);
}

#pragma mark -

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_contentEdgeInsets, contentEdgeInsets))
    {
        _contentEdgeInsets = contentEdgeInsets;
        [self layoutSubviews];
    }
}

- (void)drawBorderWithColor:(UIColor *)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)corner
{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = corner;
}

- (void)addLeftView:(UIView *)leftView
{
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}


@end
