//
//  PhotoGalleryViewController.m
//  PropzyTenant
//
//  Created by Dylan Bui on 7/21/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "PhotoGalleryViewController.h"
#import "Constant.h"

@interface PhotoGalleryViewController ()

@property (nonatomic, strong) DKImagePickerController * _Nullable  pickerController; // Choose image viewcontroler

@end

@implementation PhotoGalleryViewController

@synthesize assetType;

- (instancetype)init
{
    if (self = [super init]) {
        self.pickerController = [DKImagePickerController new];
        self.pickerController.assetType = DKImagePickerControllerAssetTypeAllPhotos;
        self.pickerController.autoDismissViewController = NO;
        self.pickerController.showsCancelButton = YES;
        self.pickerController.showsEmptyAlbums = YES;
        self.pickerController.allowMultipleTypes = NO;
        self.pickerController.singleSelect = NO;
        self.pickerController.sourceType = DKImagePickerControllerSourceTypePhoto;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerController.maxSelectableCount = self.maxSelected;
    self.pickerController.sourceType = self.sourceType;
    self.pickerController.singleSelect = self.singleSelect;
    
    __weak __typeof(self) weakSelf = self;
    [self.pickerController setDidSelectAssets:^(NSArray * __nonnull assets) {
        if (weakSelf.didSelectAssets)            
            weakSelf.didSelectAssets(assets);
        [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.pickerController setDidCancel:^{
        if(weakSelf.setDidCancel)
            weakSelf.setDidCancel();
        [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.view.frame = self.pickerController.view.frame;
    [self.view addSubview:self.pickerController.view];
}



@end
