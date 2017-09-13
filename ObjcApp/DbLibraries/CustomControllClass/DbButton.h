//
//  DbButton.h
//  ObjcApp
//
//  Created by Dylan Bui on 9/3/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//  Build on : https://github.com/kubatruhlar/JTImageButton
//  Refer : https://github.com/Friend-LGA/LGViews/blob/master/LGViews/LGButton/LGButton.m
//      Support icon at : top, bottom, left, right
//  Refer : https://www.cocoacontrols.com/controls/gbflatbutton

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface DbButton : UIButton

typedef NS_ENUM(NSUInteger, DbButtonImagePosition)
{
    DbButtonImagePositionLeft   = 0,
    DbButtonImagePositionRight  = 1,
    DbButtonImagePositionTop    = 2,
    DbButtonImagePositionBottom = 3,
    DbButtonImagePositionCenter = 4
};

typedef NS_ENUM(NSUInteger, DbButtonImagePadding)
{
    DbButtonImagePaddingNone    = 0,
    DbButtonImagePaddingSmall   = 1,
    DbButtonImagePaddingMedium  = 2,
    DbButtonImagePaddingBig     = 3
};

/**
 Icon should be overlayed with color. The default iconColor is nil. Final image quality could be different.
 */
#if TARGET_INTERFACE_BUILDER
@property (nonatomic, strong) IBInspectable UIImage *iconImage;
#else
@property (nonatomic, strong) UIImage *iconImage;
#endif

/**
 Icon should be overlayed with color. The default iconColor is nil. Final image quality could be different.
 */
@property (nonatomic, assign) IBInspectable UIColor *iconColor;

@property (nonatomic, assign) IBInspectable CGFloat iconHeight;

@property (nonatomic, assign) IBInspectable CGFloat iconOffsetY;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSUInteger iconPosition;
#else
@property (nonatomic, assign) DbButtonImagePosition iconPosition;
#endif

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSUInteger iconPadding;
#else
@property (nonatomic, assign) DbButtonImagePadding iconPadding;
#endif

/**
 The float value of corner radius. The default cornerRadius is 3.0f.
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 The border color of the button represented as a UIColor. The default border color is orange.
 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/**
 The border width of the button represented as a float. The default border width is 1.0f.
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 The alpha of the button when highlighted. The default highlightAlpha is 0.5f.
 */
@property (nonatomic, assign) IBInspectable CGFloat highlightAlpha;

/**
 The alpha of the button when disabled. The default disableAlpha is 0.5f.
 */
@property (nonatomic, assign) IBInspectable CGFloat disableAlpha;

/**
 The effect of the button when touched. The default touchEffectEnabled is NO.
 */
@property (nonatomic, assign) IBInspectable BOOL touchEffectEnabled;



@end
