//
//  RippleEffectView.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/7/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RippleEffectView : UIView{
    
    UIImageView *buttonImage;
    UITapGestureRecognizer *tapGesture;
    SEL selectedMethod;
    id senderid;
    UIColor *rippleColor;
    UIColor *bordercolor;
    UIColor *rippleTrailColor;
    NSArray *rippleColors;
    
}
typedef void (^onFinish)(BOOL success);
@property (nonatomic, copy) onFinish block;
-(instancetype)initWithImage:(UIImage *)image Frame:(CGRect)frame Color:(UIColor*)bordercolor Target:(SEL)action ID:(id)sender;
-(instancetype)initWithImage:(UIImage *)image Frame:(CGRect)frame didEnd:(onFinish)executeOnFinish;

-(void)setBorderColor:(UIColor *)color;
-(void)setRippleColor:(UIColor *)color;
-(void)setRippleTrailColor:(UIColor *)color;

@end
