//
//  HeaderMapView.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/12/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "HeaderMapView.h"

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
}

- (void)setupButton
{
}


- (void)didChangeStretchFactor:(CGFloat)stretchFactor
{
    [super didChangeStretchFactor:stretchFactor];
    
}


@end
