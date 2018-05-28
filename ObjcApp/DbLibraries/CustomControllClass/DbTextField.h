//
//  DbTextField.h
//  ObjcApp
//
//  Created by Dylan Bui on 3/23/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DbTextField : UITextField

// -- Fix content in label : contentEdgeInsets = top, left, bottom, right --
// -- Neu left content qua nhieu th chuyen wa dung leftView lam padding --
//@property (assign, nonatomic) IBInspectable UIEdgeInsets contentEdgeInsets;
// Ex : self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
@property (assign, nonatomic) UIEdgeInsets contentEdgeInsets;

- (void)drawBorderWithColor:(UIColor *)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)corner;

- (UIView *)addRightViewWithImage:(UIImageView*)imageView andPadding:(float)padding;
- (UIView *)addLeftViewWithImage:(UIImageView*)imageView andPadding:(float)padding;

- (void)addLeftView:(UIView *)leftView;
- (void)addRightView:(UIView *)rightView;


@end
