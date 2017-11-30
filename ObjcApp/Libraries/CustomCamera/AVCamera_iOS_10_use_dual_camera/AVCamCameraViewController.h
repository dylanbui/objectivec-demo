/*
	Copyright (C) 2016 Apple Inc. All Rights Reserved.
	See LICENSE.txt for this sample’s licensing information
	
	Abstract:
	View controller for camera interface.
 */

@import UIKit;
#import <AVFoundation/AVFoundation.h>

#import "AVCamPreviewView.h"
#import "AVCamPhotoCaptureDelegate.h"

//#import <AssetsLibrary/AssetsLibrary.h>
//@import AVFoundation;
//@import Photos;

@interface AVCamCameraViewController : UIViewController

// Session management.
@property (nonatomic, weak) IBOutlet AVCamPreviewView *previewView;

//AVCaptureFlashMode

- (void)setAVCameraFlashMode:(AVCaptureFlashMode)flashMode;

- (void)changeCamera:(void (^)(AVCaptureDevicePosition newPosition))completeHandler;

- (void)focusAndExposeTap:(UIGestureRecognizer *)gestureRecognizer;

//- (void)snapStillImageWithCompletionHandler:(void (^)(CMSampleBufferRef imageDataSampleBuffer, NSError *error))handler;

- (void)capturePhoto:(void (^)(AVCapturePhotoSettings *requestedPhotoSettings, NSData *photoData, NSError *error))captureHandler;
//- (void)capturePhoto:(AVCamPhotoCaptureDelegate *)photoCaptureDelegate;

@end
