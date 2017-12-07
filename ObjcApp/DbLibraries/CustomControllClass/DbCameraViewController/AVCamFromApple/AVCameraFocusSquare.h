//
//  AVCameraFocusSquare.h
//  ObjcApp
//
//  Created by Dylan Bui on 12/1/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AVCameraFocusSquare : UIView

- (instancetype)initWithTouchPoint:(CGPoint)touchPoint;
- (void)updatePoint:(CGPoint)touchPoint;
- (void)animateFocusingAction;

@end
