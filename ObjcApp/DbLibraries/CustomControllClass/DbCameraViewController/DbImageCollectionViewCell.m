//
//  ImageCollectionViewCell.m
//  CustomCamera
//
//  Created by Thuý on 5/10/17.
//  Copyright © 2017 Propzy. All rights reserved.
//

#import "DbImageCollectionViewCell.h"

@implementation DbImageCollectionViewCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [self.imgContent.layer setMasksToBounds:YES];
    [self.imgContent.layer setBorderWidth:1.5f];
    [self.imgContent.layer setBorderColor:[UIColor whiteColor].CGColor];
}

- (void)setTransform:(CGAffineTransform)transform withAnimation:(BOOL)animation
{
    if (animation) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
    }
    
    for (UIView *view in [self subviews]) {
        view.transform = transform;
    }
    
    if (animation) {
        [UIView commitAnimations];
    }
}

@end
