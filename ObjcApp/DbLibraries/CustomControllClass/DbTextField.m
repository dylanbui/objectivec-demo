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
    return UIEdgeInsetsInsetRect(bounds, _contentEdgeInsets);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, _contentEdgeInsets);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, _contentEdgeInsets);
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

- (void)addRightView:(UIView *)rightView
{
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UIView *)addRightViewWithImage:(UIImageView*)imageView andPadding:(float)padding
{
    float height = CGRectGetHeight(imageView.frame);
    float width =  CGRectGetWidth(imageView.frame) + padding;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [paddingView addSubview:imageView];
    [self addRightView:paddingView];
    return paddingView;
}

- (UIView *)addLeftViewWithImage:(UIImageView*)imageView andPadding:(float)padding
{
    float height = CGRectGetHeight(imageView.frame);
    float width =  CGRectGetWidth(imageView.frame) + padding;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [paddingView addSubview:imageView];
    [self addLeftView:paddingView];
    return paddingView;
}

@end
