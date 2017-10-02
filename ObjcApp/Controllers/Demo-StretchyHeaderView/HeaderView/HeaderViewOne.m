//
//  HeaderViewOne.m
//  ObjcApp
//
//  Created by Dylan Bui on 10/2/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "HeaderViewOne.h"
#import "UIView+GSKLayoutHelper.h"
#import "GSKGeometry.h"

@interface HeaderViewOne ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *button;

@end

@implementation HeaderViewOne

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
    [self.button setTitle:@"I'm a button"
                 forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor lightGrayColor]
                      forState:UIControlStateHighlighted];
    [self.button addTarget:self
                    action:@selector(didTapButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
    [self.button sizeToFit];
}


- (void)didChangeStretchFactor:(CGFloat)stretchFactor
{
    [super didChangeStretchFactor:stretchFactor];
    CGFloat limitedStretchFactor = MIN(1, stretchFactor);
    
    CGSize minImageSize = CGSizeMake(32, 32);
    CGSize maxImageSize = CGSizeMake(96, 96);
//    CGPoint minImageOrigin = CGPointMake(96, 24);
    CGPoint minImageOrigin = CGPointMake(35, 24);
    CGPoint maxImageOrigin = CGPointMake((self.contentView.width - maxImageSize.width) / 2, 32);
    
    self.imageView.size = CGSizeInterpolate(limitedStretchFactor, minImageSize, maxImageSize);
    self.imageView.left = CGFloatInterpolate(limitedStretchFactor, minImageOrigin.x, maxImageOrigin.x);
    self.imageView.top = CGFloatInterpolate(stretchFactor, minImageOrigin.y, maxImageOrigin.y);
    
    if (stretchFactor < 1) {
        self.button.top = CGFloatInterpolate(stretchFactor,
                                             self.imageView.centerY - self.button.height / 2,
                                             self.imageView.bottom + 4);
    } else {
        self.button.top = self.imageView.bottom + 4;
    }
    
    self.button.left = CGFloatInterpolate(limitedStretchFactor,
                                          minImageOrigin.x + minImageSize.width + 8,
                                          self.contentView.width / 2 - self.button.width / 2);
}

- (void)didTapButton:(id)sender
{
    NSLog(@"tap!");
}

@end

