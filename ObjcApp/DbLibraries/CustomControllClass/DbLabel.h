//
//  DbLabel.h
//  ObjcApp
//
//  Created by Dylan Bui on 9/4/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface DbLabel : UILabel


#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable UIEdgeInsets contentEdgeInsets;
#else
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
#endif

@property (nonatomic, assign) IBInspectable CGRect rectValue;

@property (nonatomic, assign) IBInspectable UIColor *iconColor;

@end
