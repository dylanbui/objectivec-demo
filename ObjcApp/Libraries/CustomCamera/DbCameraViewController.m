//
//  MyCameraControllerViewController.m
//  CustomCamera
//
//  Created by Dylan Bui on 5/12/17.
//  Copyright © 2017 Propzy. All rights reserved.
//

#import "DbCameraViewController.h"

#import "Masonry.h"
#import "DbImageCollectionViewCell.h"

#define DegreesToRadians(x) (M_PI * x / 180.0)

@import AVFoundation;

@interface DbCameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification  object:nil];
    
    self.listImage = [[NSMutableArray alloc] init];
    self.listImageSelected = [[NSMutableArray alloc] init];
    [_clvSelectedImage registerNib:[UINib nibWithNibName:@"DbImageCollectionViewCell"
                                                  bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"dbImageCollectionViewCell"];
    
    [self setSelectedBtn];
    
    // -- Update layout constraints when start --
    [self updateLayoutConstraints];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(focusAndExposeTap:)];
    // [tapGestureRecognizer setNumberOfTouchesRequired:1];
    self.cameraFrame.userInteractionEnabled = YES;
    [self.cameraFrame addGestureRecognizer:tapGestureRecognizer];
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
    sender.enabled = NO;
    sender.selected = NO;
    
    if (IS_SIMULATOR) {
        UIImage *capturedImage = [UIImage imageNamed:@"demo_1.jpg"];
        [self addImagesToList:UIImageJPEGRepresentation(capturedImage, 1.0)];
        sender.enabled = YES;
        sender.selected = YES;
        return;
    }
    
    [super capturePhoto:^(NSData *photoData, NSError *error) {
        if (error) {
            NSLog(@"DbCameraViewController [error] = %@", [error description]);
            sender.enabled = YES;
            sender.selected = YES;
        }
        
        [self addImagesToList:photoData];
        sender.enabled = YES;
        sender.selected = YES;
    }];
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

- (void)addImagesToList:(NSData *)photoData
{
    UIImage *captureImage = [[UIImage alloc] initWithData:photoData];
    
    // -- Crop Image Conform cameraFrame --
    CGSize imageSize = captureImage.size;
    float scaleX = imageSize.width/self.view.frame.size.width;
    CGSize itemSize = CGSizeMake(_cameraFrame.frame.size.width*scaleX, _cameraFrame.frame.size.height*scaleX);
    CGRect imageRect = CGRectMake(_cameraFrame.frame.origin.x*scaleX, _cameraFrame.frame.origin.y*scaleX, itemSize.width, itemSize.height);
    
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

- (CGAffineTransform)getCGAffineTransform:(UIDeviceOrientation)orientation
{
    if (orientation == UIDeviceOrientationUnknown)
        orientation = [[UIDevice currentDevice] orientation];
    
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

- (void)orientationChanged:(NSNotification *)notification
{
    [self updateLayoutConstraints];
    [_clvSelectedImage reloadData];
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
    CGAffineTransform transform = [self getCGAffineTransform:UIDeviceOrientationUnknown];
    
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
    CGAffineTransform transform = [self getCGAffineTransform:UIDeviceOrientationUnknown];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    for (UIView *view in [self.vwBottom subviews]) {
        view.transform = transform;
    }

    [UIView commitAnimations];
    
    // -- Update constraint close button --
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        
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

//// this method is implemented in your capture session manager (wherever AVCaptureSession is used)
//// capture a still image and save the device orientation
//- (void)captureStillImage
//{
//    UIDeviceOrientation currentDeviceOrientation = UIDevice.currentDevice.orientation;
//    [self.stillImageOutput
//     captureStillImageAsynchronouslyFromConnection:self.videoConnection
//     completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
//         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
//         if (imageData) {
//             UIImage *image = [UIImage imageWithData:imageData];
//             NSDictionary *captureInfo = {
//                 @"image" : image,
//                 @"deviceOrientation" : @(currentDeviceOrientation)
//             };
//             // TODO: send image & orientation to delegate or post notification to observers
//         }
//         else {
//             // TODO: handle image capture error
//         }
//     }];
//}
//
//// this method rotates the UIImage captured by the capture session manager based on the
//// device orientation when the image was captured
//- (UIImage *)imageRotatedUpFromCaptureInfo:(NSDictionary *)captureInfo
//{
//    UIImage *image = [captureInfo objectForKey:@"image"];
//    UIDeviceOrientation deviceOrientation = [[captureInfo objectForKey:@"deviceOrientation"] integerValue];
//    UIImageOrientation rotationOrientation = [self rotationNeededForImageCapturedWithDeviceOrientation:deviceOrientation];
//    // TODO: scale the image if desired
//    CGSize newSize = image.size;
//    return [imageScaledToSize:newSize andRotatedByOrientation:rotationOrientation];
//}
//
//// return a scaled and rotated an image
//- (UIImage *)imageScaledToSize:(CGSize)newSize andRotatedByOrientation:(UIImageOrientation)orientation
//{
//    CGImageRef imageRef = self.CGImage;
//    CGRect imageRect = CGRectMake(0.0, 0.0, newSize.width, newSize.height);
//    CGRect contextRect = imageRect;
//    CGAffineTransform transform = CGAffineTransformIdentity;
//
//    switch (orientation)
//    {
//        case UIImageOrientationDown: { // rotate 180 deg
//            transform = CGAffineTransformTranslate(transform, imageRect.size.width, imageRect.size.height);
//            transform = CGAffineTransformRotate(transform, M_PI);
//        } break;
//
//        case UIImageOrientationLeft: { // rotate 90 deg left
//            contextRect = CGRectTranspose(contextRect);
//            transform = CGAffineTransformTranslate(transform, imageRect.size.height, 0.0);
//            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
//        } break;
//
//        case UIImageOrientationRight: { // rotate 90 deg right
//            contextRect = CGRectTranspose(contextRect);
//            transform = CGAffineTransformTranslate(transform, 0.0, imageRect.size.width);
//            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
//        } break;
//
//        case UIImageOrientationUp: // no rotation
//        default:
//            break;
//    }
//
//    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
//    CGColorSpaceRef colorSpaceRef = CGImageGetColorSpace(imageRef);
//
//    // madify bitmapInfo to work with PNG if necessary
//    if (bitmapInfo == kCGImageAlphaNone) {
//        bitmapInfo = kCGImageAlphaNoneSkipLast;
//    }
//    else if (bitmapInfo == kCGImageAlphaLast) {
//        bitmapInfo = kCGImageAlphaPremultipliedLast;
//    }
//
//    // Build a context that's the same dimensions as the new size
//    CGContextRef context = CGBitmapContextCreate(NULL,
//                                                 contextRect.size.width,
//                                                 contextRect.size.height,
//                                                 CGImageGetBitsPerComponent(imageRef),
//                                                 0,
//                                                 colorSpaceRef,
//                                                 bitmapInfo);
//
//
//    CGContextConcatCTM(context, transform);
//    CGContextDrawImage(context, imageRect, imageRef);
//
//    // Get the rotated image from the context and a UIImage
//    CGImageRef rotatedImageRef = CGBitmapContextCreateImage(context);
//    UIImage *rotatedImage = [UIImage imageWithCGImage:rotatedImageRef];
//
//    // Clean up
//    CGImageRelease(rotatedImageRef);
//    CGContextRelease(context);
//
//    return rotatedImage;
//}

// return the UIImageOrientation needed for an image captured with a specific deviceOrientation
//- (UIImageOrientation)rotationNeededForImageCapturedWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation
//{
//    UIImageOrientation rotationOrientation;
//    switch (deviceOrientation) {
//        case UIDeviceOrientationPortraitUpsideDown: {
//            rotationOrientation = UIImageOrientationLeft;
//        } break;
//
//        case UIDeviceOrientationLandscapeRight: {
//            rotationOrientation = UIImageOrientationDown;
//        } break;
//
//        case UIDeviceOrientationLandscapeLeft: {
//            rotationOrientation = UIImageOrientationUp;
//        } break;
//
//        case UIDeviceOrientationPortrait:
//        default: {
//            rotationOrientation = UIImageOrientationRight;
//        } break;
//    }
//    return rotationOrientation;
//}



@end
