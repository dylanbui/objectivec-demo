//
//  ActivityIndicatorButton.h
//  PropzyDiy
//
//  Created by Dylan Bui on 6/8/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//  Development on : RNLoadingButton

#import <UIKit/UIKit.h>

/* Values for NSTextAlignment */

typedef enum {
    ActivityIndicatorButtonAlignmentLeft      = 0,
    ActivityIndicatorButtonAlignmentCenter    = 1,
    ActivityIndicatorButtonAlignmentRight     = 2,
} ActivityIndicatorButtonAlignment;


@interface ActivityIndicatorButton : UIButton


@property (nonatomic, readwrite) BOOL loading;

@property (nonatomic, readwrite) BOOL autoUseActivityIndicatorForDisableState;

@property(nonatomic, readonly) UIActivityIndicatorView *activityIndicator;

@property(nonatomic) UIEdgeInsets activityIndicatorEdgeInsets; // default is UIEdgeInsetsZero

@property(nonatomic, readwrite) BOOL hideImageWhenLoading; // Default YES
@property(nonatomic, readwrite) BOOL hideTextWhenLoading; // Default YES

- (void)setActivityIndicatorStyle:(UIActivityIndicatorViewStyle)indicatorStyle forState:(UIControlState)__state;
- (UIActivityIndicatorViewStyle)activityIndicatorStyleForState:(UIControlState)__state;
- (void)setActivityIndicatorAlignment:(ActivityIndicatorButtonAlignment)_aligment;

@end

