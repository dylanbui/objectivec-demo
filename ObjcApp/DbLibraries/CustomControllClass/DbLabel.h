//
//  DbLabel.h
//  PropzyPama
//
//  Created by Dylan Bui on 9/11/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Options for aligning text vertically for BTLabel.
 */
typedef NS_ENUM(NSUInteger, DBVerticalAlignment) {
    /**
     Align text to the top edge of label.
     */
    DBVerticalAlignmentTop = 1,
    /**
     Align text to rhe middle of label.
     */
    DBVerticalAlignmentCenter = 2,
    /**
     Align text to the bottom edge of label.
     */
    DBVerticalAlignmentBottom = 3,
};

IB_DESIGNABLE

@interface DbLabel : UILabel

// -- Fix content in label : contentEdgeInsets = top, left, bottom, right --
// [self sizeToFit]
@property (assign, nonatomic) IBInspectable UIEdgeInsets contentEdgeInsets;

/**
 Vertical text alignment mode.
 */

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSUInteger verticalAlignment;
#else
@property (nonatomic, assign) DBVerticalAlignment verticalAlignment;
#endif



@end
