//
//  TaskTableViewHeader.m
//  PropzyPama
//
//  Created by Dylan Bui on 8/28/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "TaskTableViewHeader.h"

@implementation TaskTableViewHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

//- (id)initWithFrame:(CGRect)frame andHandleViewAction:(HandleViewAction)handle
//{
//    if (self = [super initWithFrame:frame andHandleViewAction:handle]) {
//        [self setupView];
//    }
//    return self;
//}

- (void)setupView
{
    // border radius
    [self.vwSegment.layer setCornerRadius:5.0f];
    
    // border
//    [self.vwSegment.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [self.vwSegment.layer setBorderWidth:0.5f];
    
    // drop shadow
    [self.vwSegment.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.vwSegment.layer setShadowOpacity:0.2];
    [self.vwSegment.layer setShadowRadius:2.0];
    [self.vwSegment.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.vwSegment.layer setShadowOffset:CGSizeMake(0, 0)];
    
    // Drawing code
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.btnToday.bounds
                                           byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                 cornerRadii:(CGSize){5.0, 5.0}].CGPath;
    self.btnToday.layer.mask = maskLayer;

    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.btnFuture.bounds
                                           byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                 cornerRadii:(CGSize){5.0, 5.0}].CGPath;
    self.btnFuture.layer.mask = maskLayer;
}

- (IBAction)btnToday_Click:(id)sender
{
//    CAShapeLayer * maskLayer = [CAShapeLayer layer];
//    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.btnToday.bounds
//                                           byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
//                                                 cornerRadii:(CGSize){5.0, 5.0}].CGPath;
//    self.btnToday.layer.mask = maskLayer;
    
    [self.btnToday setBackgroundColor:ORANGE_COLOR];
    [self.btnToday setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnFuture setBackgroundColor:[UIColor whiteColor]];
    [self.btnFuture setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.handleViewAction(self, 0, nil, nil);
}

- (IBAction)btnFuture_Click:(id)sender
{
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.btnFuture.bounds
//                                           byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
//                                                 cornerRadii:(CGSize){5.0, 5.0}].CGPath;
//    self.btnFuture.layer.mask = maskLayer;
    
    [self.btnToday setBackgroundColor:[UIColor whiteColor]];
    [self.btnToday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnFuture setBackgroundColor:ORANGE_COLOR];
    [self.btnFuture setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.handleViewAction(self, 1, nil, nil);
}

@end
