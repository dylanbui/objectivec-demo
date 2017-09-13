//
//  DbLabel.m
//  PropzyPama
//
//  Created by Dylan Bui on 9/11/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbLabel.h"

@interface DbLabel ()

@end

@implementation DbLabel

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

- (void)drawTextInRect:(CGRect)rect
{
    rect.origin.x += _contentEdgeInsets.left;
    rect.origin.y += _contentEdgeInsets.top;
    rect.size.width -= (_contentEdgeInsets.left + _contentEdgeInsets.right);
    rect.size.height -= (_contentEdgeInsets.top + _contentEdgeInsets.bottom);
    
    [super drawTextInRect:rect];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeToFit = CGSizeMake(size.width-(_contentEdgeInsets.left+_contentEdgeInsets.right),
                                  size.height-(_contentEdgeInsets.top+_contentEdgeInsets.bottom));
    
    if (sizeToFit.width < 0.f)
        sizeToFit.width = 0.f;
    
    if (sizeToFit.height < 0.f)
        sizeToFit.height = 0.f;
    
    CGSize selfSize = [super sizeThatFits:sizeToFit];
    
    selfSize.width += (_contentEdgeInsets.left+_contentEdgeInsets.right);
    selfSize.height += (_contentEdgeInsets.top+_contentEdgeInsets.bottom);
    
    return selfSize;
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

@end

