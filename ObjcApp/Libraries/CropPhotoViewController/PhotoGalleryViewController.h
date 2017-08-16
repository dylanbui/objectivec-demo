//
//  PhotoGalleryViewController.h
//  PropzyTenant
//
//  Created by Dylan Bui on 7/21/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <DKImagePickerController/DKImagePickerController-Swift.h>

@interface PhotoGalleryViewController : UIViewController

@property (nonatomic) enum DKImagePickerControllerAssetType assetType;
@property (nonatomic) enum DKImagePickerControllerSourceType sourceType;

@property (nonatomic) BOOL singleSelect;
@property (nonatomic) int maxSelected;
@property (nonatomic, copy) void (^ _Nullable didSelectAssets)(NSArray<DKAsset *> * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable setDidCancel)();


- (instancetype _Nonnull )init;


@end
