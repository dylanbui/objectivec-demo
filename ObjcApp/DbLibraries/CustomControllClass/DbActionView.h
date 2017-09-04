//
//  DbActionView.h
//  ObjcApp
//
//  Created by Dylan Bui on 9/1/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface DbActionView : UIControl

@property (nonatomic, assign) IBInspectable BOOL masksToBounds;

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

@property (nonatomic, strong) IBInspectable UIColor *shadowColor;

@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;

@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;

@property (nonatomic) IBInspectable CGSize shadowOffset;

/**
 The alpha of the button when highlighted. The default highlightAlpha is 0.7f.
 */
@property (nonatomic, assign) IBInspectable CGFloat highlightAlpha;

/**
 The alpha of the button when disabled. The default disableAlpha is 0.5f.
 */
@property (nonatomic, assign) IBInspectable CGFloat disableAlpha;

@property (nonatomic, strong) IBInspectable UIColor *touchUpInsideColor;

@end
