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

@class CropPhotoViewController;

@protocol CropPhotoViewControllerDelegate <NSObject>
@optional

- (void)cropPhotoViewController:(nonnull CropPhotoViewController *)cropViewController didCropToCircularImage:(nonnull UIImage *)image
                       withRect:(CGRect)cropRect angle:(NSInteger)angle;

- (void)cropPhotoViewController:(nonnull CropPhotoViewController *)cropViewController didCropToImage:(nonnull UIImage *)image
                       withRect:(CGRect)cropRect angle:(NSInteger)angle;


- (void)cropPhotoViewController:(nonnull CropPhotoViewController *)cropViewController didFinishCancelled:(BOOL)cancelled;

@end


@interface CropPhotoViewController : UIViewController <TOCropViewControllerDelegate>

@property (nonatomic, strong) DKImagePickerController * _Nullable  pickerController; // Choose image viewcontroler
@property (nonatomic, strong) TOCropViewController * _Nullable cropViewController; // Crop image viewcontroler

@property (nullable, nonatomic, weak) id <CropPhotoViewControllerDelegate> delegate;

- (instancetype _Nonnull )init;


@end

