//
//  DbLabel.h
//  PropzyPama
//
//  Created by Dylan Bui on 9/11/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface DbLabel : UILabel

// -- Fix content in label : contentEdgeInsets = top, left, bottom, right --
// [self sizeToFit]
@property (assign, nonatomic) IBInspectable UIEdgeInsets contentEdgeInsets;

@end
