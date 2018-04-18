//
//  RMPDetailViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/17/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "RMPDetailViewController.h"

@interface RMPDetailViewController ()

@end

@implementation RMPDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *filename = [NSString stringWithFormat:@"%02lu_L.jpeg", self.index + 1];
    self.titleLabel.text = filename;
}

#pragma mark - <RMPZoomTransitionAnimating>

- (UIImageView *)transitionSourceImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.mainImageView.image];
    imageView.contentMode = self.mainImageView.contentMode;
    // imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = self.mainImageView.frame;
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.view.backgroundColor;
}

- (CGRect)transitionDestinationImageViewFrame
{
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGRect frame = self.mainImageView.frame;
    frame.size.width = width;
    return frame;
}

#pragma mark - <RMPZoomTransitionDelegate>

- (void)zoomTransitionAnimator:(RMPZoomTransitionAnimator *)animator
         didCompleteTransition:(BOOL)didComplete
      animatingSourceImageView:(UIImageView *)imageView
{
    self.mainImageView.image = imageView.image;
}

#pragma mark -

- (IBAction)closeButtonDidPush:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
