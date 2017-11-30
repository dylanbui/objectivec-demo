//
//  ImageCollectionViewCell.m
//  CustomCamera
//
//  Created by Thuý on 5/10/17.
//  Copyright © 2017 Propzy. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [self.imgContent.layer setMasksToBounds:YES];
    [self.imgContent.layer setBorderWidth:1.5f];
    [self.imgContent.layer setBorderColor:[UIColor whiteColor].CGColor];
}

@end
