//
//  UIButton+Activity.h
//  PropzyDiy
//
//  Created by Dylan Bui on 6/7/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef IBInspectable
#define IBInspectable
#endif

@interface UIButton (Activity)

@property (readwrite, setter=useActivityIndicator:, getter=getUseActivityIndicator) IBInspectable BOOL useActivityIndicator;
-(void)updateActivityIndicatorVisibility;

@end
