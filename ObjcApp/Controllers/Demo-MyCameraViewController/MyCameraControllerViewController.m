//
//  MyCameraControllerViewController.m
//  CustomCamera
//
//  Created by Dylan Bui on 5/12/17.
//  Copyright © 2017 Propzy. All rights reserved.
//

#import "MyCameraControllerViewController.h"

#import "Masonry.h"
//#import "CameraHoverView.h"
#import "UIImage+Crop.h"
#import "ImageCollectionViewCell.h"

#define DegreesToRadians(x) (M_PI * x / 180.0)

@import AVFoundation;

@interface MyCameraControllerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) UIImageView *capturedPhotoImageView;
@property(nonatomic, strong) UIImage *selectedImage;

@property(nonatomic) BOOL isCapturingImage;
@property (nonatomic, strong) NSMutableArray *listImage;
@property (nonatomic, strong) NSMutableArray *listImageSelected;


@end



@interface MyCameraControllerViewController ()

@end

@implementation MyCameraControllerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isPresented = YES;
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification  object:nil];
    
    self.listImage = [[NSMutableArray alloc] init];
    self.listImageSelected = [[NSMutableArray alloc] init];
    [_clvSelectedImage registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell"
                                                  bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"imageCell"];
    
    [self setSelectedBtn];
    
    [self updateConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // -- Create gray mask on previewView --
    // create the mask that will be applied to the layer on top of the
    // yellow background
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.frame = self.view.frame;

    // -- Sub mask --
    UIBezierPath *maskLayerPath = [UIBezierPath bezierPath];
    [maskLayerPath appendPath:[UIBezierPath bezierPathWithRect:self.previewView.frame]];
    [maskLayerPath appendPath:[UIBezierPath bezierPathWithRect:self.cameraFrame.frame]];
    maskLayer.path = maskLayerPath.CGPath;
    
    // create the layer on top of the yellow background
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = self.view.layer.bounds;
    imageLayer.backgroundColor = [[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor];
    
    // apply the mask to the layer
    imageLayer.mask = maskLayer;
    [self.previewView.layer addSublayer:imageLayer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)captureImage_Click:(UIButton *)sender
{
    // -- Disable capture image button -- 
    sender.enabled = NO;
    if (IS_SIMULATOR) {
        UIImage *capturedImage = [UIImage imageNamed:@"demo_1.jpg"];
        [self addImagesToList:UIImageJPEGRepresentation(capturedImage, 1.0)];
        sender.enabled = YES;
        return;
    }
    
    [super capturePhoto:^(NSData *photoData, NSError *error) {
        // photoData == nil => error
//        UIImage *capturedImage = [[UIImage alloc] initWithData:photoData];
        
//        self.selectedImage = [[UIImage alloc] initWithData:photoData];
//        self.capturedPhotoImageView.image = self.selectedImage;
//
//        CGSize imageSize = self.selectedImage.size;
//        float scaleX = imageSize.width/self.view.frame.size.width;
//        CGSize itemSize = CGSizeMake(_cameraFrame.frame.size.width*scaleX, _cameraFrame.frame.size.height*scaleX);
//        CGRect imageRect = CGRectMake(_cameraFrame.frame.origin.x*scaleX, _cameraFrame.frame.origin.y*scaleX, itemSize.width, itemSize.height);
//
//        [self.listImage addObject:[self.selectedImage cropImageToRect:imageRect orientation:self.selectedImage.imageOrientation]];
//        [self.listImageSelected addObject:[NSIndexPath indexPathForRow:[self.listImage count] - 1 inSection:0]];
//        [self setSelectedBtn];
//        [_clvSelectedImage reloadData];
        
        [self addImagesToList:photoData];
        sender.enabled = YES;
    }];
    
}

- (void)addImagesToList:(NSData *)photoData
{
    self.selectedImage = [[UIImage alloc] initWithData:photoData];
    self.capturedPhotoImageView.image = self.selectedImage;
    
    CGSize imageSize = self.selectedImage.size;
    float scaleX = imageSize.width/self.view.frame.size.width;
    CGSize itemSize = CGSizeMake(_cameraFrame.frame.size.width*scaleX, _cameraFrame.frame.size.height*scaleX);
    CGRect imageRect = CGRectMake(_cameraFrame.frame.origin.x*scaleX, _cameraFrame.frame.origin.y*scaleX, itemSize.width, itemSize.height);
    
    [self.listImage addObject:[self.selectedImage cropImageToRect:imageRect orientation:self.selectedImage.imageOrientation]];
    NSIndexPath *lastItem = [NSIndexPath indexPathForRow:[self.listImage count] - 1 inSection:0];
    [self.listImageSelected addObject:lastItem];
    [self setSelectedBtn];
    [_clvSelectedImage reloadData];
    
    // -- Scroll to end --
    [_clvSelectedImage scrollToItemAtIndexPath:lastItem
                              atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

- (IBAction)btnFlash_Click:(id)sender
{
    UIButton *cmd = (UIButton *)sender;
    
    switch (cmd.tag) {
        case AVCaptureFlashModeOn:
            [self setCameraFlashMode:AVCaptureFlashModeOff];
            cmd.tag = (int)AVCaptureFlashModeOff;
            [cmd setTintColor:[UIColor grayColor]];
            [cmd setSelected:NO];
            break;            
        case AVCaptureFlashModeOff:
            [self setCameraFlashMode:AVCaptureFlashModeOn];
            cmd.tag = (int)AVCaptureFlashModeOn;
            [cmd setTintColor:[UIColor blueColor]];
            [cmd setSelected:YES];
            break;
    }
}

- (IBAction)btnSaveImage_Click:(id)sender
{
    NSMutableArray *imagesSelected = [[NSMutableArray alloc] init];
    for(NSIndexPath *indexPath in _listImageSelected) {
        [imagesSelected addObject:[_listImage objectAtIndex:indexPath.row]];
    }
    if (self.imagePickerDelegate)
        [self.imagePickerDelegate imagesSelected:imagesSelected];
    [self btnClose_Click:sender];
}

- (IBAction)btnClose_Click:(id)sender
{
    self.isPresented = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setSelectedBtn
{
    if([self.listImageSelected count] == 0) {
        [self.btnSaveImage setSelected:NO];
        [self.btnSaveImage setEnabled:NO];
    } else {
        [self.btnSaveImage setSelected:YES];
        [self.btnSaveImage setEnabled:YES];
    }
}

#pragma mark -
#pragma mark ---
#pragma mark -

- (BOOL)shouldAutorotate
{
    return [super shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)orientationChanged:(NSNotification *)notification
{
    [self updateConstraints];
    [_clvSelectedImage reloadData];
}

#pragma mark -
#pragma mark UICollectionView methods
#pragma mark -

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"imageCell";
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.imgContent setImage:[self.listImage objectAtIndex:indexPath.row]];
    
    // -- Choose image just to capture --
    [cell.imgSelected setHidden:NO];
    if(![self.listImageSelected containsObject:indexPath]) {
        [cell.imgSelected setHidden:YES];
    }
    
    // -- Rotate subview --
    CGAffineTransform transform = [self getCGAffineTransform];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    for (UIView *view in [cell subviews]) {
        view.transform = transform;
    }
    
    [UIView commitAnimations];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_listImage count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(75,75);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.listImageSelected containsObject:indexPath]) {
        [self.listImageSelected removeObject:indexPath];
    } else {
        [self.listImageSelected addObject:indexPath];
    }
    [_clvSelectedImage reloadData];
    [self setSelectedBtn];
}

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (CGAffineTransform)getCGAffineTransform
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    CGRect viewFrame = [[UIScreen mainScreen] bounds];
//    NSLog(@"viewFrame = %@", NSStringFromCGRect(viewFrame));
    
    CGAffineTransform transform = self.view.transform;
    
    if (orientation == UIDeviceOrientationPortraitUpsideDown)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(180));
    
    else if (orientation == UIDeviceOrientationLandscapeLeft)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(90));
    
    else if (orientation == UIDeviceOrientationLandscapeRight)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(-90));
    
    return transform;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints
{
    //according to apple super should be called at end of method
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGRect viewFrame = [[UIScreen mainScreen] bounds];
    NSLog(@"viewFrame = %@", NSStringFromCGRect(viewFrame));
    
    CGAffineTransform transform = self.view.transform;
    
    if (orientation == UIDeviceOrientationPortraitUpsideDown)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(180));
    
    else if (orientation == UIDeviceOrientationLandscapeLeft)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(90));
    
    else if (orientation == UIDeviceOrientationLandscapeRight)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(-90));
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    for (UIView *view in [self.vwBottom subviews]) {
        view.transform = transform;
    }

    [UIView commitAnimations];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        
        [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.left.equalTo(@30);
            
            make.width.equalTo(@35);
            make.height.equalTo(@35);
        }];

    } else {
        
        [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.right.equalTo(@-30);
            
            make.width.equalTo(@35);
            make.height.equalTo(@35);
        }];
        
    }
    
//    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
//        [self.vwBottom mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@0);
//            make.left.equalTo(@0);
//            make.bottom.equalTo(@0);
//            make.width.equalTo(@80);
//        }];
//
//        [self.clvSelectedImage mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@0);
//            make.left.equalTo(self.vwBottom.mas_left).with.offset(0.0);
//            make.bottom.equalTo(@0);
//            make.width.equalTo(@75);
//        }];
//
//        [self.cameraFrame mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@15);
//            make.left.equalTo(self.clvSelectedImage.mas_left).with.offset(15.0);
//            make.bottom.equalTo(@15);
//            make.right.equalTo(@15);
//
//        }];
//    } else { // UIInterfaceOrientationPortrait
//        [self.vwBottom mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(@0);
//            make.left.equalTo(@0);
//            make.right.equalTo(@0);
//            make.height.equalTo(@80);
//        }];
//
//        [self.clvSelectedImage mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.vwBottom.mas_top).with.offset(0.0);
//            make.left.equalTo(@0);
//            make.right.equalTo(@0);
//            make.height.equalTo(@75);
//        }];
//
//        [self.cameraFrame mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@15);
//            make.left.equalTo(@15);
//            make.bottom.equalTo(self.clvSelectedImage.mas_top).with.offset(15.0);
//            make.right.equalTo(@15);
//        }];
//    }

    
    
    
    // --- remake/update constraints here
    //    [self.imgError mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(@0);
    //        make.centerX.equalTo(self.mas_centerX);
    ////        make.width.equalTo(@48);
    ////        make.height.equalTo(@48);
    //    }];
    //
    //    [self.lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.imgError.mas_bottom).with.offset(12.0);
    ////        make.leading.equalTo(@15);
    ////        make.trailing.equalTo(@-15);
    //        make.left.equalTo(self).offset(15);
    //        make.right.equalTo(self).offset(-15);
    //        make.height.greaterThanOrEqualTo(@21);
    //    }];
    

}



@end
