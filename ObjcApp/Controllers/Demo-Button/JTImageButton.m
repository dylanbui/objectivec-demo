//
//  JTImageButton.m
//  JTImageButton
//
//  Created by Jakub Truhlar on 10.05.15.
//  Copyright (c) 2015 Jakub Truhlar. All rights reserved.
//

#import "JTImageButton.h"

@interface JTImageButton() {
    dispatch_once_t onceTokenViewLiveRendering;
}


//@property (nonatomic, strong) NSString *titleText;
////@property (nonatomic, strong) UIImage *iconImage;
//@property (nonatomic, strong) UIFont *titleFont;
//@property (nonatomic, assign) CGFloat iconHeight;
//@property (nonatomic, assign) CGFloat iconOffsetY;

@end

#define kDefaultFontSize 25.0
#define kFlatGreenColor [UIColor colorWithRed:46/255.0f green:204/255.0f blue:113/255.0f alpha:1.0f]

@implementation JTImageButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        [self initialize];
    }
    return self;
}

- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self initialize];
}

//- (void)drawRect:(CGRect)rect
//{
//#ifndef TARGET_INTERFACE_BUILDER
//    [self viewLiveRendering];
//#endif
//}
//
//-(void)viewLiveRendering{
//    dispatch_once(&onceTokenViewLiveRendering, ^{
//        [self initialize];
//    });
//}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        [self initialize];
    }
    return self;
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

- (void)initialize
{
    [self defaultSetup];
    
    // Basics
//    [self setTitleColor:_titleColor forState:UIControlStateNormal];
//    [self.titleLabel setFont:_titleFont];
//    [self setBackgroundColor:_bgColor];
//    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    // Borders
    [self.layer setCornerRadius:_cornerRadius];
    [self.layer setMasksToBounds:true];
    [self.layer setBorderWidth:_borderWidth];
    [self.layer setBorderColor:_borderColor.CGColor];
    
    // Icon overlay
    UIImage * tempIcon = nil;
    if (_iconColor && _iconImage) {
        tempIcon = [self overlayImage:_iconImage withColor:_iconColor];
    }
    
#if !TARGET_INTERFACE_BUILDER
    // Create whole title
    if (tempIcon) {
        [self setAttributedTitle:[self createStringWithImage:tempIcon
                                                      string:self.titleLabel.text
                                                       color:self.titleLabel.textColor
                                                iconPosition:JTImageButtonIconSideLeft
                                                     padding:JTImageButtonPaddingNone
                                              andIconOffsetY:0] forState:UIControlStateNormal];

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

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    [self setNeedsDisplay];
}

#pragma mark - Default setup
- (void)defaultSetup
{
    if (!_cornerRadius) { _cornerRadius = 0.0;}
    if (!_borderColor) { _borderColor = kFlatGreenColor;}
    if (!_borderWidth) { _borderWidth = 0.0;}
    
    if (!_highlightAlpha) { _highlightAlpha = 0.7;}
    if (!_disableAlpha) { _disableAlpha = 0.5;}
    
//    if (!_iconColor) { _iconColor = nil;}
//    if (!_iconImage) { _iconImage = nil;}
    
    if (!_touchEffectEnabled) { _touchEffectEnabled = false;}
}

#pragma mark - JTImageButton logic
- (NSAttributedString *)createStringWithImage:(UIImage *)image
                                       string:(NSString *)string
                                        color:(UIColor *)color
                                 iconPosition:(JTImageButtonIconSide)iconSide
                                      padding:(CGFloat)padding
                               andIconOffsetY:(CGFloat)iconOffsetY {
    
//    padding = JTImageButtonPaddingBig;
    
//    iconSide = JTImageButtonIconSideRight;
    iconSide = JTImageButtonIconSideTop;
    
    iconOffsetY = -7;
    
    if (!string)
    {
        string = @"";
        padding = JTImageButtonPaddingNone;
    }
    
    NSMutableAttributedString *finalString;
    
    if (iconSide == JTImageButtonIconSideRight) {
        //Right
        finalString = [NSMutableAttributedString new];
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName : color};
        NSAttributedString *aString;
        
        if (padding == JTImageButtonPaddingSmall) {
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", string] attributes:attributes];
        } else if (padding == JTImageButtonPaddingMedium){
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ", string] attributes:attributes];
        } else if (padding == JTImageButtonPaddingBig){
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ", string] attributes:attributes];
        } else {
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string] attributes:attributes];
        }
        
        [finalString appendAttributedString:aString];
        
        
        
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, iconOffsetY, attachment.image.size.width, attachment.image.size.height);
        
        NSLog(@"%@", NSStringFromCGSize(attachment.image.size));
        NSLog(@"%@", NSStringFromCGSize(self.frame.size));
        
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        [finalString appendAttributedString:attachmentString];
        
    } else if (iconSide == JTImageButtonIconSideLeft) {
        // Left
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = image;
        
        attachment.bounds = CGRectMake(0, iconOffsetY, attachment.image.size.width, attachment.image.size.height);
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        finalString = [[NSMutableAttributedString alloc] initWithAttributedString:attachmentString];
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName : color};
        NSAttributedString *aString;
        
        if (padding == JTImageButtonPaddingSmall && _iconImage) {
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", string] attributes:attributes];
        } else if (padding == JTImageButtonPaddingMedium && _iconImage){
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", string] attributes:attributes];
        } else if (padding == JTImageButtonPaddingBig && _iconImage){
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@", string] attributes:attributes];
        } else {
            aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string] attributes:attributes];
        }
        
        [finalString appendAttributedString:aString];

    } else if (iconSide == JTImageButtonIconSideTop) {
        
//        textMutableAttributedString.append(lineBreak)
//        let imageAttachment = NSTextAttachment.init()
//        imageAttachment.image = UIImage.init(named: "Lenna")
//        // You can set image bounds, be attention on origin.y
//        // imageAttachment.bounds = CGRect.init(x: 0, y: -8, width: (imageAttachment.image?.size.width)!, height: (imageAttachment.image?.size.height)!)
//        let imageAttributedString = NSAttributedString.init(attachment: imageAttachment)
//        let imageMutableAttributedString = NSMutableAttributedString.init(attributedString: imageAttributedString)
//        let imageParagraphStyle = NSMutableParagraphStyle.init()
//        imageParagraphStyle.alignment = .center
//        // one image's length is 1
//        imageMutableAttributedString.addAttributes([NSParagraphStyleAttributeName : imageParagraphStyle], range: NSRange.init(location: 0, length: imageAttributedString.length))
//        textMutableAttributedString.append(imageMutableAttributedString)

        
        
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = image;
        
//        attachment.bounds = CGRectMake(0, 0, attachment.image.size.width, attachment.image.size.height);
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSMutableParagraphStyle *imageParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        imageParagraphStyle.alignment = NSTextAlignmentCenter;
        
        finalString = [[NSMutableAttributedString alloc] initWithAttributedString:attachmentString];
        [finalString addAttribute:NSParagraphStyleAttributeName value:imageParagraphStyle
                            range:NSMakeRange(0, attachmentString.length)];

        NSMutableParagraphStyle *titleParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        titleParagraphStyle.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName : color,
                                     NSParagraphStyleAttributeName : titleParagraphStyle};

        
        NSAttributedString *lineBreak = [[NSAttributedString alloc] initWithString:@"\n" attributes:attributes];
        [finalString appendAttributedString:lineBreak];
        
        
        NSAttributedString *aString;
        aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string] attributes:attributes];
        [finalString appendAttributedString:aString];
    }
    
    return finalString;
}

#pragma mark - Working with image icon
- (UIImage *)overlayImage:(UIImage *)source withColor:(UIColor *)color {
    
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

- (UIImage *)scaleImage:(UIImage *)image proportionallyToHeight:(CGFloat)height {
    
    CGFloat finalScale = image.size.height / height;
    UIImage *scaledImage = [UIImage imageWithCGImage:[image CGImage] scale:(image.scale * finalScale) orientation:(image.imageOrientation)];
    return scaledImage;
}

#pragma mark - Setters

- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
//    [self setNeedsDisplay];
    [self initialize];
}

- (void)setIconColor:(UIColor *)iconColor
{
    _iconColor = iconColor;
//    [self setNeedsDisplay];
    [self initialize];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = fabs(cornerRadius);
//    [self setNeedsDisplay];
    [self initialize];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
//    [self setNeedsDisplay];
    [self initialize];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = fabs(borderWidth);
//    [self setNeedsDisplay];
    [self initialize];
}

//- (void)setIconSide:(JTImageButtonIconSide)iconSide {
//    _iconSide = iconSide;
//    [self initialize];
//}

- (void)setHighlightAlpha:(CGFloat)highlightAlpha
{
    _highlightAlpha = fabs(highlightAlpha);
//    [self setNeedsDisplay];
    [self initialize];
}

- (void)setDisableAlpha:(CGFloat)disableAlpha
{
    _disableAlpha = fabs(disableAlpha);
//    [self setNeedsDisplay];
    [self initialize];
}

- (void)setTouchEffectEnabled:(BOOL)touchEffectEnabled
{
    _touchEffectEnabled = touchEffectEnabled;
//    [self setNeedsDisplay];
    [self initialize];
}

@end
