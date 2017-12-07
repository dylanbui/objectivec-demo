//
//  MyCameraControllerViewController.m
//  CustomCamera
//
//  Created by Dylan Bui on 5/12/17.
//  Copyright © 2017 Propzy. All rights reserved.
//

#import "DbCameraViewController.h"
#import <CoreMotion/CoreMotion.h>

#import "Masonry.h"
#import "DbImageCollectionViewCell.h"

#define LIMIT_CAPTURE_IMAGES    10

#define DegreesToRadians(x) (M_PI * x / 180.0)

@import AVFoundation;

@interface DbCameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate> {
    UIDeviceOrientation currentOrientation;
    CMMotionManager *motionManager;
}

@property (nonatomic, weak) IBOutlet UIImageView *cameraFrame;
@property (nonatomic, weak) IBOutlet UIView *vwBottom;
@property (nonatomic, weak) IBOutlet UICollectionView *clvSelectedImage;

@property (nonatomic, strong) NSMutableArray *listImage;
@property (nonatomic, strong) NSMutableArray *listImageSelected;

@end


@implementation DbCameraViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // -- Dont run when lock portrait orientation of device, but run on simulator -- 
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationOrientationChanged:)
//                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    
    if (!IS_SIMULATOR) { // Real device use CoreMotion Task - UIAccelerometer callback
        // Initialize Motion Manager
        [self initializeMotionManager];
    } else {
        // Do any additional setup after loading the view from its nib.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationOrientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    
    self.listImage = [[NSMutableArray alloc] init];
    self.listImageSelected = [[NSMutableArray alloc] init];
    [_clvSelectedImage registerNib:[UINib nibWithNibName:@"DbImageCollectionViewCell"
                                                  bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"dbImageCollectionViewCell"];
    
    [self setSelectedBtn];
    
    // -- Update layout constraints when start --
    [self updateLayoutConstraints];
    
    // -- Pinch Action --
    self.cameraFrame.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(focusAndExposeTap:)];
    // [tapGestureRecognizer setNumberOfTouchesRequired:1];
    [self.cameraFrame addGestureRecognizer:tapGestureRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchToZoom:)];
    [self.cameraFrame addGestureRecognizer:pinchRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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

#pragma mark -
#pragma mark Button Action
#pragma mark -

- (IBAction)btnTakePhoto_Click:(UIButton *)sender
{
    // -- Disable capture image button -- 
//    sender.enabled = NO;
//    sender.selected = NO;
    [self doButton:sender enabled:NO];
    __weak typeof(self) weakSelf = self;
    
    if (IS_SIMULATOR) {
        UIImage *capturedImage = [UIImage imageNamed:@"demo_1.jpg"];
        [self addImagesToList:UIImageJPEGRepresentation(capturedImage, 1.0) withCompletionHandler:^{
//            sender.enabled = YES;
//            sender.selected = YES;
            [weakSelf doButton:sender enabled:YES];
        }];
        return;
    }
    
    [super capturePhoto:^(NSData *photoData, NSError *error) {
        if (error) {
            NSLog(@"DbCameraViewController [error] = %@", [error description]);
//            sender.enabled = YES;
//            sender.selected = YES;
            [weakSelf doButton:sender enabled:YES];
        }
        
        [self addImagesToList:photoData withCompletionHandler:^{
//            sender.enabled = YES;
//            sender.selected = YES;
            [weakSelf doButton:sender enabled:YES];
        }];
    } withInterfaceOrientation:(UIInterfaceOrientation)currentOrientation];
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
    // -- Callback delegate --
    if (self.imageCameraDelegate)
        [self.imageCameraDelegate cameraImagesSelected:imagesSelected];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnClose_Click:(id)sender
{
    // -- Callback delegate --
    if (self.imageCameraDelegate)
        [self.imageCameraDelegate cameraImageCancelled];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Private Functions
#pragma mark -

- (void)addImagesToList:(NSData *)photoData withCompletionHandler:(void (^)(void))completionHandler
{
    UIImage *captureImage = [[UIImage alloc] initWithData:photoData];
    
    // -- Crop Image Conform cameraFrame --
    CGSize imageSize = captureImage.size;
    
    float scaleX = imageSize.width/self.view.frame.size.width;
    // Capture image at UIDeviceOrientationLandscape Mode
    if (imageSize.width > imageSize.height) {
        scaleX = imageSize.height/self.view.frame.size.width;
    }
    
    CGSize itemSize = CGSizeMake(_cameraFrame.frame.size.width*scaleX, _cameraFrame.frame.size.height*scaleX);
    
    CGRect imageRect = CGRectMake(_cameraFrame.frame.origin.x*scaleX, _cameraFrame.frame.origin.y*scaleX, itemSize.width, itemSize.height);
    // Capture image at UIDeviceOrientationLandscape Mode
    if (imageSize.width > imageSize.height) {
        imageRect = CGRectMake(_cameraFrame.frame.origin.x*scaleX, _cameraFrame.frame.origin.y*scaleX, itemSize.height, itemSize.width);
    }
    
    //    NSLog(@"imageRect = %@", NSStringFromCGRect(imageRect));
    //    NSLog(@"captureImage.imageOrientation = %d", (int)captureImage.imageOrientation);
    
    UIImage *cropImage = [self cropImage:captureImage ToRect:imageRect orientation:captureImage.imageOrientation];
    
    // -- Add to list --
    [self.listImage addObject:cropImage];
    NSIndexPath *lastItem = [NSIndexPath indexPathForRow:[self.listImage count] - 1 inSection:0];
    [self.listImageSelected addObject:lastItem];
    
    // -- Enable seleted image button --
    [self setSelectedBtn];
    
    [_clvSelectedImage reloadData];
    
    // -- Scroll to end --
    [_clvSelectedImage scrollToItemAtIndexPath:lastItem
                              atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
    if ([self.listImage count] >= LIMIT_CAPTURE_IMAGES) {
        // -- Hide take button --
        [self.btnTakePhoto setHidden:YES];
    }
    
    if (completionHandler)
        completionHandler();
}


- (void)setSelectedBtn
{
    if([self.listImageSelected count] == 0) {
        [self doButton:self.btnSaveImage enabled:NO];
//        [self.btnSaveImage setSelected:NO];
//        [self.btnSaveImage setEnabled:NO];
    } else {
        [self doButton:self.btnSaveImage enabled:YES];
//        [self.btnSaveImage setSelected:YES];
//        [self.btnSaveImage setEnabled:YES];
    }
}

- (CGAffineTransform)getCGAffineTransform:(UIDeviceOrientation)orientation
{
    CGAffineTransform transform = self.view.transform;
    
    if (orientation == UIDeviceOrientationPortraitUpsideDown)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(180));
    
    else if (orientation == UIDeviceOrientationLandscapeLeft)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(90));
    
    else if (orientation == UIDeviceOrientationLandscapeRight)
        transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(-90));
    
    return transform;
}

- (UIImage *)cropImage:(UIImage*)img ToRect:(CGRect)rect orientation:(UIImageOrientation)orientation;
{
    CGAffineTransform rectTransform = CGAffineTransformIdentity;
    
    switch (img.imageOrientation) {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI_2), 0, -img.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI_2), -img.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI), -img.size.width, -img.size.height);
            break;
        case UIImageOrientationLeftMirrored:
            rectTransform = CGAffineTransformTranslate(rectTransform, img.size.width, 0);
            rectTransform = CGAffineTransformRotate(rectTransform, M_PI_2);
            break;
        case UIImageOrientationRightMirrored:
            rectTransform = CGAffineTransformTranslate(rectTransform, 0, img.size.height);
            rectTransform = CGAffineTransformRotate(rectTransform, -M_PI_2);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    
    rectTransform = CGAffineTransformScale(rectTransform, img.scale, img.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], CGRectApplyAffineTransform(rect, rectTransform));
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:img.scale orientation:orientation];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

// -- Debug orientation device --
- (NSString*)orientationToText:(const UIDeviceOrientation)ORIENTATION
{
    switch (ORIENTATION) {
        case UIDeviceOrientationPortrait:
            return @"UIDeviceOrientationPortrait";
        case UIDeviceOrientationPortraitUpsideDown:
            return @"UIDeviceOrientationPortraitUpsideDown";
        case UIDeviceOrientationLandscapeLeft:
            return @"UIDeviceOrientationLandscapeLeft";
        case UIDeviceOrientationLandscapeRight:
            return @"UIDeviceOrientationLandscapeRight";
        case UIDeviceOrientationFaceUp:
            return @"UIDeviceOrientationFaceUp";
        case UIDeviceOrientationFaceDown:
            return @"UIDeviceOrientationFaceDown";
        case UIDeviceOrientationUnknown:
            return @"UIDeviceOrientationUnknown";
    }
    return @"Unknown orientation!";
}

- (void)doButton:(UIButton *)button enabled:(BOOL)enabled
{
    button.enabled = enabled;
    button.selected = enabled;
}

#pragma mark -
#pragma mark Rotate Device
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

- (void)notificationOrientationChanged:(NSNotification *)notification
{
    // -- Only use for SIMULATOR --
    // currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    // NSLog(@"Going from %@ to %@ !", [self orientationToText:currentOrientation], [self orientationToText:orientation]);
    currentOrientation = orientation;
    [self updateLayoutConstraints];
}

- (void)orientationDidChange:(UIDeviceOrientation)orientation
{
    [self updateLayoutConstraints];
}

#pragma mark -
#pragma mark CoreMotion Task - UIAccelerometer callback
#pragma mark -

- (void)initializeMotionManager
{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = .2;
    motionManager.gyroUpdateInterval = .2;
    
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                            if (!error) {
                                                [self outputAccelertionData:accelerometerData.acceleration];
                                            }
                                            else{
                                                NSLog(@"%@", error);
                                            }
                                        }];
}

- (void)outputAccelertionData:(CMAcceleration)acceleration
{
    float const threshold = 40.0;
    
    BOOL (^isNearValue) (float value1, float value2) = ^BOOL(float value1, float value2)
    {
        return fabsf(value1 - value2) < threshold;
    };
    
    BOOL (^isNearValueABS) (float value1, float value2) = ^BOOL(float value1, float value2)
    {
        return isNearValue(fabsf(value1), fabsf(value2));
    };
    
    float yxAtan = (atan2(acceleration.y, acceleration.x)) * 180 / M_PI;
    float zyAtan = (atan2(acceleration.z, acceleration.y)) * 180 / M_PI;
    float zxAtan = (atan2(acceleration.z, acceleration.x)) * 180 / M_PI;
    
    UIDeviceOrientation orientation = currentOrientation;
    
    if (isNearValue(-90.0, yxAtan) && isNearValueABS(180.0, zyAtan))
    {
        orientation = UIDeviceOrientationPortrait;
    }
    else if (isNearValueABS(180.0, yxAtan) && isNearValueABS(180.0, zxAtan))
    {
        orientation = UIDeviceOrientationLandscapeLeft;
    }
    else if (isNearValueABS(0.0, yxAtan) && isNearValueABS(0.0, zxAtan))
    {
        orientation = UIDeviceOrientationLandscapeRight;
    }
    else if (isNearValue(90.0, yxAtan) && isNearValueABS(0.0, zyAtan))
    {
        orientation = UIDeviceOrientationPortraitUpsideDown;
    }
    else if (isNearValue(-90.0, zyAtan) && isNearValue(-90.0, zxAtan))
    {
        orientation = UIDeviceOrientationFaceUp;
    }
    else if (isNearValue(90.0, zyAtan) && isNearValue(90.0, zxAtan))
    {
        orientation = UIDeviceOrientationFaceDown;
    }
    
    // NSLog(@"Going from %@ to %@!", [self orientationToText:currentOrientation], [self orientationToText:orientation]);
    
    // -- Dont process when FaceUp, FaceDown device --
    if (orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown)
        return;
    
    if (currentOrientation != orientation)
    {
        currentOrientation = orientation;
        // -- Sure code run on main thread --
        dispatch_async(dispatch_get_main_queue(), ^{
            [self orientationDidChange:currentOrientation];
        });
    }
}

#pragma mark -
#pragma mark UICollectionView methods
#pragma mark -

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"dbImageCollectionViewCell";
    DbImageCollectionViewCell *cell = (DbImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.imgContent setImage:[self.listImage objectAtIndex:indexPath.row]];
    
    // -- Choose image just to capture --
    [cell.imgSelected setHidden:NO];
    if(![self.listImageSelected containsObject:indexPath]) {
        [cell.imgSelected setHidden:YES];
    }
    
    // -- Rotate subview --
    CGAffineTransform transform = [self getCGAffineTransform:currentOrientation];
    [cell setTransform:transform withAnimation:NO];
    
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

#pragma mark -
#pragma mark Update layout when rotate
#pragma mark -

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateLayoutConstraints
{
    // -- Update images icon rotate --
    CGAffineTransform transform = [self getCGAffineTransform:currentOrientation];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    for (UIView *view in [self.vwBottom subviews]) {
        view.transform = transform;
    }

    [UIView commitAnimations];

    // -- Rotate visibleCells --
    for (DbImageCollectionViewCell *cell in [_clvSelectedImage visibleCells]) {
        [cell setTransform:transform withAnimation:YES];
    }
    
    // -- Update constraint close button --
    if (currentOrientation == UIDeviceOrientationLandscapeRight) {
        
        [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.left.equalTo(@30);
            make.width.and.height.equalTo(@35);
        }];

    } else {
        
        [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.right.equalTo(@-30);
            make.width.and.height.equalTo(@35);
        }];
        
    }
}

@end
