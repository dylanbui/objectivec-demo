//
//  BALabel.h
//  ObjcApp
//
//  Created by Dylan Bui on 9/8/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


typedef enum {
    BAVerticalAlignmentCenter = 0,
    BAVerticalAlignmentTop,
    BAVerticalAlignmentBottom
} BAVerticalAlignment;

typedef enum {
    BALabelBezelNone = 0,
    BALabelBezelRound,
    BALabelBezelRoundSolid
} BALabelBezel;

@interface BALabel : UILabel

@property(nonatomic, assign) UIEdgeInsets textInsets;
@property(nonatomic, assign) BAVerticalAlignment verticalAlignment;
@property(nonatomic, assign) BALabelBezel bezel;
@property(nonatomic, assign) CGFloat bezelLineWidth;
@property(nonatomic, retain) UIColor *bezelColor;

- (void)sizeToFitInWidth;
- (void)sizeToFitInWidthMaxHeight:(CGFloat)maxHeight;

@end
