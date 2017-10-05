//
//  UIImageView+FaceAwareFill.h
//  PropzyPama
//
//  Created by Dylan Bui on 9/25/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FaceAwareFill)

//Ask the image to perform an "Aspect Fill" but centering the image to the detected faces
//Not the simple center of the image
- (void)faceAwareFill;

- (void)makeAvatarWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;
- (void)makeAvatar:(float)cornerRadius borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;


@end
