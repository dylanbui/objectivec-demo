//
//  DbButton.m
//  ObjcApp
//
//  Created by Dylan Bui on 9/3/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbButton.h"

#define kOffsetYNone        -5.0
#define kDefaultFontSize    25.0
#define kFlatGreenColor [UIColor colorWithRed:46/255.0f green:204/255.0f blue:113/255.0f alpha:1.0f]
#define kIconHeightDefault  0.0

@interface DbButton()

@end

@implementation DbButton

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

- (void)defaultSetup
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (!_iconPosition) { _iconPosition = DbButtonImagePositionLeft; }
    if (!_iconPadding) { _iconPadding = DbButtonImagePaddingNone; }
    
    if (!_iconOffsetY) { _iconOffsetY = kOffsetYNone; }
    
    if (!_cornerRadius) { _cornerRadius = 0.0;}
    if (!_borderColor) { _borderColor = kFlatGreenColor;}
    if (!_borderWidth) { _borderWidth = 0.0;}
    
    if (!_highlightAlpha) { _highlightAlpha = 0.5;}
    if (!_disableAlpha) { _disableAlpha = 0.5;}
    
    if (!_touchEffectEnabled) { _touchEffectEnabled = false;}
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.alpha = _highlightAlpha;
    } else {
        self.alpha = 1.0;
    }
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.alpha = _highlightAlpha;
    } else {
        self.alpha = 1.0;
    }
    [self setNeedsDisplay];
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

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    [self setNeedsDisplay];
}

#pragma mark -

- (void)initialize
{
    [self defaultSetup];
    
    // Borders
    [self.layer setCornerRadius:_cornerRadius];
    [self.layer setMasksToBounds:true];
    [self.layer setBorderWidth:_borderWidth];
    [self.layer setBorderColor:_borderColor.CGColor];
    
#if !TARGET_INTERFACE_BUILDER
    // Create whole title
    if (_iconImage) {

        // Icon overlay
        if (_iconColor) // Set color
            _iconImage = [self overlayImage:_iconImage withColor:_iconColor];
        
        [self setAttributedTitle:[self createStringWithImage:_iconImage
                                                      string:self.titleLabel.text
                                                       color:self.titleLabel.textColor
                                                iconPosition:_iconPosition
                                                     padding:_iconPadding
                                              andIconOffsetY:_iconOffsetY] forState:UIControlStateNormal];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
#endif
    
    // Simple effect
    UIControlEvents applyEffectEvents = UIControlEventTouchDown | UIControlEventTouchDragInside | UIControlEventTouchDragEnter;
    [self removeTarget:self action:@selector(applyTouchEffect) forControlEvents:applyEffectEvents];
    [self addTarget:self action:@selector(applyTouchEffect) forControlEvents:applyEffectEvents];
    
    UIControlEvents dismissEffectEvents = UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside | UIControlEventTouchDragExit | UIControlEventTouchCancel;
    [self removeTarget:self action:@selector(dismissTouchEffect) forControlEvents:dismissEffectEvents];
    [self addTarget:self action:@selector(dismissTouchEffect) forControlEvents:dismissEffectEvents];
}

#pragma mark - Setters

- (void)setIconImage:(UIImage *)iconImage
{
    if (iconImage != _iconImage) {
        _iconImage = iconImage;
        [self initialize];
    }
}

- (void)setIconColor:(UIColor *)iconColor
{
    if (iconColor != _iconColor) {
        _iconColor = iconColor;
        [self initialize];
    }
}

- (void)setIconHeight:(CGFloat)iconHeight
{
    if (iconHeight != _iconHeight) {
        UIFont * titleFont = self.titleLabel.font;
        // Get early frame
    //    [self.titleLabel setFont:_titleFont];
        [self layoutIfNeeded];
        
        if (iconHeight == kIconHeightDefault) {
            _iconHeight = MIN(fabs([titleFont pointSize]), _iconImage.size.height);
        } else {
            _iconHeight = MIN(iconHeight, _iconImage.size.height);
        }
        
        if (!_iconImage) {
            return;
        }
        if (_iconImage.size.height > _iconHeight) {
            _iconImage = [self scaleImage:_iconImage proportionallyToHeight:_iconHeight];
        }
        [self initialize];
    }
}

- (void)setIconOffsetY:(CGFloat)iconOffsetY
{
    _iconOffsetY = iconOffsetY + kOffsetYNone;
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

- (void)setIconPosition:(DbButtonImagePosition)iconPosition
{
    if (iconPosition != _iconPosition) {
        _iconPosition = iconPosition;
        [self initialize];
    }
}

- (void)setIconPadding:(DbButtonImagePadding)iconPadding
{
    if (iconPadding != _iconPadding) {
        _iconPadding = iconPadding;
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

- (void)setTouchEffectEnabled:(BOOL)touchEffectEnabled
{
    _touchEffectEnabled = touchEffectEnabled;
    [self initialize];
}

#pragma mark - JTImageButton logic

- (NSAttributedString *)createStringWithImage:(UIImage *)image
                                       string:(NSString *)string
                                        color:(UIColor *)color
                                 iconPosition:(DbButtonImagePosition)iconSide
                                      padding:(DbButtonImagePadding)padding
                               andIconOffsetY:(CGFloat)iconOffsetY
{
    if (!string)
    {
        string = @"";
        padding = DbButtonImagePaddingNone;
    }
    
    NSMutableAttributedString *finalString;
    
    if (iconSide == DbButtonImagePositionRight) {
        //Right
        finalString = [NSMutableAttributedString new];
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName : color};
        NSAttributedString *aString;
        
        if (padding == DbButtonImagePaddingSmall) {
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", string]
                                                      attributes:attributes];
        } else if (padding == DbButtonImagePaddingMedium){
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ", string]
                                                      attributes:attributes];
        } else if (padding == DbButtonImagePaddingBig){
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ", string]
                                                      attributes:attributes];
        } else {
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]
                                                      attributes:attributes];
        }
        
        [finalString appendAttributedString:aString];
        
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, iconOffsetY, attachment.image.size.width, attachment.image.size.height);
        
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        [finalString appendAttributedString:attachmentString];
        
    } else if (iconSide == DbButtonImagePositionLeft) {
        // Left
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = image;
        
        attachment.bounds = CGRectMake(0, iconOffsetY, attachment.image.size.width, attachment.image.size.height);
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        finalString = [[NSMutableAttributedString alloc] initWithAttributedString:attachmentString];
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName : color};
        NSAttributedString *aString;
        
        if (padding == DbButtonImagePaddingSmall && _iconImage) {
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", string]
                                                      attributes:attributes];
        } else if (padding == DbButtonImagePaddingMedium && _iconImage){
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", string]
                                                      attributes:attributes];
        } else if (padding == DbButtonImagePaddingBig && _iconImage){
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@", string]
                                                      attributes:attributes];
        } else {
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]
                                                      attributes:attributes];
        }
        
        [finalString appendAttributedString:aString];
    }
    return finalString;
}

#pragma mark - Working with image icon

- (UIImage *)overlayImage:(UIImage *)source withColor:(UIColor *)color
{
    
    UIGraphicsBeginImageContextWithOptions(source.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color setFill];
    
    CGContextTranslateCTM(context, 0, source.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);
    CGContextDrawImage(context, rect, source.CGImage);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImage;
}

- (UIImage *)scaleImage:(UIImage *)image proportionallyToHeight:(CGFloat)height
{
    
    CGFloat finalScale = image.size.height / height;
    UIImage *scaledImage = [UIImage imageWithCGImage:[image CGImage] scale:(image.scale * finalScale) orientation:(image.imageOrientation)];
    return scaledImage;
}

#pragma mark - Touch effect

- (void)applyTouchEffect
{
    if (_touchEffectEnabled) {
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformMakeScale(1.05, 1.05);
        } completion:nil];
    }
}

- (void)dismissTouchEffect
{
    if (_touchEffectEnabled) {
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }
}



@end
