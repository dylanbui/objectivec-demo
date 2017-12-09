//
//  ImageAnimViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/9/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "ImageAnimViewController.h"

@interface ImageAnimViewController ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *maskView;

@end

@implementation ImageAnimViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo_4.jpg"]];
    //_imageView.frame = self.view.frame;
    _imageView.alpha = 0.5;
    _imageView.center = self.view.center;
    _imageView.contentMode = UIViewContentModeBottom; // Quan trong, tao anh tu bottom to top
    
    float _height = SCREEN_HEIGHT;
    
    CGRect frame = _imageView.frame;
    frame.size.height = 0.00001;
//    frame.origin.y += _height;
    frame.origin.y = _height;
    
    _imageView.frame = frame;
    _imageView.clipsToBounds = YES;
    
    [self.view addSubview:_imageView];

}


- (IBAction)btnChange_Click:(id)sender
{
    [UIView animateWithDuration:5.0f
                     animations:^
     {
         float _height = SCREEN_HEIGHT;
         CGRect frame = _imageView.frame;
         frame.size.height = _height;
         frame.origin.y -= _height;
         
         _imageView.alpha = 1.0;
         _imageView.frame = frame;
         
     }];
    

    // -- That bai 1 --
    // [self animateViewHeight:self.img_2 withAnimationType:kCATransitionFromBottom];

}

// Chi di chuyen anh tu tren xuong
- (void)animateViewHeight:(UIView*)animateView withAnimationType:(NSString*)animType
{
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:animType];
    
    [animation setDuration:0.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[animateView layer] addAnimation:animation forKey:kCATransition];
    animateView.hidden = !animateView.hidden;
}

@end
