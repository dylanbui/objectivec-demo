//
//  SLTableViewCell.m
//  ObjcApp
//
//  Created by Dylan Bui on 10/10/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "SLTableViewCell.h"

@interface SLTableViewCell() {
    double currentOffset;
    double summaryOffset;
    double previousOffset;
}


@end

@implementation SLTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellOnTableView:(UITableView *)tableView
        didScrollOnView:(UIView *)view
             withOffset:(double)offset
{
    if (offset > 0)
        return;
    
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    // NSLog(@"%d = %f === %@", (int)self.indexPath.row, offset, NSStringFromCGRect(rectInSuperview));
    
    currentOffset = -offset;
    
    
    
    
    float padding = 8.f;
    //float min = padding;
    float max = CGRectGetHeight(rectInSuperview) - CGRectGetHeight(self.parallaxImage.frame) - 8;

    currentOffset += padding;
    
//    if (currentOffset < min)
//        currentOffset = min;
    
    if (currentOffset > max)
        currentOffset = max;
    
    CGRect imageRect = self.parallaxImage.frame;
    imageRect.origin.y = currentOffset;
    self.parallaxImage.frame = imageRect;
    
    
    //float distanceFromTop = CGRectGetHeight(view.frame) - 16 - CGRectGetMinY(rectInSuperview);
//    float difference = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(self.frame);
//    float move = (offset / CGRectGetHeight(view.frame)) * difference;
    
//    NSLog(@"    => %f === %f", distanceFromTop, move);

//    CGRect imageRect = self.parallaxImage.frame;
//    imageRect.origin.y = -(difference)+move;
//    self.parallaxImage.frame = imageRect;
    
//    CGRect imageRect = self.parallaxImage.frame;
//    imageRect.origin.y = distanceFromTop;
//    self.parallaxImage.frame = imageRect;

    

//    currentOffset = -offset;
    // CGRect imageRect = self.parallaxImage.frame;
//    float padding = 8.f;
//    float min = padding;
//    float max = CGRectGetHeight(rectInSuperview) - CGRectGetHeight(self.parallaxImage.frame) - 8;
//
//    if (currentOffset > min && currentOffset < max) {
//        CGRect imageRect = self.parallaxImage.frame;
//        imageRect.origin.y = currentOffset;
//        self.parallaxImage.frame = imageRect;
//    }
//
//    float difference = currentOffset - previousOffset;
//
//    if (summaryOffset <= CGRectGetHeight(rectInSuperview)) {
//        summaryOffset = summaryOffset + difference;
//    } else {
//        summaryOffset = 0.f;
//    }
//
////    CGRect imageRect = self.parallaxImage.frame;
//    imageRect.origin.y = summaryOffset + distanceFromOrigin;
//    self.parallaxImage.frame = imageRect;
//
//    previousOffset = currentOffset;
}

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
{
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    NSLog(@"%d = %@", (int)self.indexPath.row,  NSStringFromCGRect(rectInSuperview));
    
//    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
//    float difference = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(self.frame);
//    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
//    
//    CGRect imageRect = self.parallaxImage.frame;
//    imageRect.origin.y = -(difference/2)+move;
//    self.parallaxImage.frame = imageRect;
}

@end
