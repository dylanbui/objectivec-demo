//
//  HeaderMapView.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/12/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "HeaderMapView.h"
#import "UIView+GSKLayoutHelper.h"
#import "GSKGeometry.h"

@interface HeaderMapView ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *button;

@end


@implementation HeaderMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumContentHeight = 64;
        self.backgroundColor = [UIColor redColor];
        [self setupImageView];
        [self setupButton];
    }
    return self;
}

- (void)setupImageView
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lab"]];
    [self.contentView addSubview:self.imageView];
}

- (void)setupButton
{
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = [UIColor blueColor];
    [self.button setTitle:@"I'm a button" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.contentView addSubview:self.button];
    [self.button sizeToFit];
}


- (void)didChangeStretchFactor:(CGFloat)stretchFactor
{
    [super didChangeStretchFactor:stretchFactor];
    CGFloat limitedStretchFactor = MIN(1, stretchFactor);
//    NSLog(@"stretchFactor = %f; limitedStretchFactor = %f", stretchFactor, limitedStretchFactor);
    
    CGSize minImageSize = CGSizeMake(32, 32);
    CGSize maxImageSize = CGSizeMake(96, 96);
    //    CGPoint minImageOrigin = CGPointMake(96, 24);
    CGPoint minImageOrigin = CGPointMake(35, 24);
    CGPoint maxImageOrigin = CGPointMake((self.contentView.width - maxImageSize.width) / 2, 32);
    
    self.imageView.size = CGSizeInterpolate(limitedStretchFactor, minImageSize, maxImageSize);
    self.imageView.left = CGFloatInterpolate(limitedStretchFactor, minImageOrigin.x, maxImageOrigin.x);
    self.imageView.top = CGFloatInterpolate(stretchFactor, minImageOrigin.y, maxImageOrigin.y);
    
    if (stretchFactor < 1) {
        // -- Scroll top --
        self.button.top = CGFloatInterpolate(stretchFactor,
                                             self.imageView.centerY - self.button.height / 2,
                                             self.imageView.bottom + 4);
    } else {
        // -- Scroll down --
        self.button.top = self.imageView.bottom + 4;
    }
    
    self.button.left = CGFloatInterpolate(limitedStretchFactor,
                                          minImageOrigin.x + minImageSize.width + 8,
                                          self.contentView.width / 2 - self.button.width / 2);
}



@end
