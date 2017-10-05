//
//  CropPhotoViewController.h
//  AppTest
//
//  Created by Dylan Bui on 5/31/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <DKImagePickerController/DKImagePickerController-Swift.h>
#import "TOCropViewController.h"

@interface CropPhotoViewController : UIViewController <TOCropViewControllerDelegate>

@property (nonatomic, strong) DKImagePickerController * _Nullable  pickerController; // Choose image viewcontroler
@property (nonatomic, strong) TOCropViewController * _Nullable cropViewController; // Crop image viewcontroler

@property (nonatomic, copy) void (^ _Nullable didCropToCircularImage)(UIImage * _Nonnull image, CGRect cropRect, NSInteger angle);
@property (nonatomic, copy) void (^ _Nullable didCropToImage)(UIImage * _Nonnull image, CGRect cropRect, NSInteger angle);
@property (nonatomic, copy) void (^ _Nullable didCancel)(void);

+ (instancetype _Nonnull)sharedInstance;

@end

