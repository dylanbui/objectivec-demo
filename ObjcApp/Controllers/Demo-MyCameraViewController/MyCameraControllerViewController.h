//
//  MyCameraControllerViewController.h
//  CustomCamera
//
//  Created by Dylan Bui on 5/12/17.
//  Copyright © 2017 Propzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbConstant.h"
#import "AVCamViewController.h"
//#import "AVCamCameraViewController.h"
//#import "AVCamPhotoCaptureDelegate.m"
//
//#import "AVCamPreviewView.h"
//#import <AVFoundation/AVFoundation.h>
//#import <AssetsLibrary/AssetsLibrary.h>

@protocol ImagePickerViewControllerDelegate <NSObject>
- (void)imageSelectionCancelled;
- (void)imagesSelected:(NSMutableArray *)images;

@end

@interface MyCameraControllerViewController : AVCamViewController

@property (nonatomic, weak) IBOutlet UIImageView *cameraFrame;
@property (weak, nonatomic) IBOutlet UIView *vwBottom;

@property (nonatomic, weak) IBOutlet UIButton *btnSaveImage;
@property (nonatomic, weak) IBOutlet UIButton *btnFlash;
@property (nonatomic, weak) IBOutlet UICollectionView *clvSelectedImage;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;

//@property (weak, nonatomic) IBOutlet UIView *shadowView;
//@property (weak, nonatomic) IBOutlet UIView *vwShadowTop;
//@property (weak, nonatomic) IBOutlet UIView *vwShadowLeft;
//@property (weak, nonatomic) IBOutlet UIView *vwShadowRight;
//@property (weak, nonatomic) IBOutlet UIView *vwShadowBot;

@property (nonatomic) BOOL isPresented;

@property(nonatomic, weak) id<ImagePickerViewControllerDelegate> imagePickerDelegate;

@end
