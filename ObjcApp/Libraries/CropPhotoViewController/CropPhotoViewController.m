//
//  CropPhotoViewController.m
//  AppTest
//
//  Created by Dylan Bui on 5/31/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "CropPhotoViewController.h"

@interface CropPhotoViewController ()

- (void)processChoosePhoto:(DKAsset *)asset;

@end

@implementation CropPhotoViewController

// -- Dont allow init --
- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Use sharedInstance functions" userInfo:nil];
}


+ (instancetype _Nonnull)sharedInstance
{
    static CropPhotoViewController *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] initPrivate];
    });
    return _shared;
}

- (instancetype)initPrivate
{
    if (self = [super init]) {
        self.pickerController = [DKImagePickerController new];
        self.pickerController.assetType = DKImagePickerControllerAssetTypeAllPhotos;
        self.pickerController.autoDismissViewController = NO;
        self.pickerController.singleSelect = YES;
        self.pickerController.showsCancelButton = YES;
        self.pickerController.showsEmptyAlbums = YES;
        self.pickerController.allowMultipleTypes = NO;
        self.pickerController.sourceType = DKImagePickerControllerSourceTypeBoth; // DKImagePickerControllerSourceTypePhoto;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak __typeof(self) weakSelf = self;
    [self.pickerController setDidSelectAssets:^(NSArray * __nonnull assets) {
        [weakSelf processChoosePhoto:[assets firstObject]];
    }];
    
    [self.pickerController setDidCancel:^{
        [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.view.frame = self.pickerController.view.frame;
    [self.view addSubview:self.pickerController.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // -- Remove all selected items --
    [self.pickerController deselectAllAssets];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // -- Pop TOCropViewController --
    [self.cropViewController.navigationController popViewControllerAnimated:NO];
}

- (void)processChoosePhoto:(DKAsset *)asset
{
    [asset fetchOriginalImageWithCompleteBlock:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        // NSLog(@"processChoosePhoto = %@", @"Lay duoc hinh, tao man hinh cat");
        self.cropViewController = [[TOCropViewController alloc] initWithImage:image];
        self.cropViewController.resetAspectRatioEnabled = NO;
        self.cropViewController.rotateClockwiseButtonHidden = YES;
        self.cropViewController.rotateButtonsHidden = YES;
        self.cropViewController.aspectRatioPickerButtonHidden = YES;
        self.cropViewController.delegate = self;
        
        [self.pickerController pushViewController:self.cropViewController animated:YES];
        // [self presentViewController:self.cropViewController animated:YES completion:nil];
    }];
}

#pragma mark -
#pragma mark TOCropViewControllerDelegate
#pragma mark -

- (void)cropViewController:(TOCropViewController *)cropViewController
    didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    // 'image' is the newly cropped, circular version of the original image
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        self.didCropToCircularImage(image, cropRect, angle);
    }];
}

- (void)cropViewController:(nonnull TOCropViewController *)cropViewController
            didCropToImage:(nonnull UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    
    // -- Hide pickerController --
    //    self.pickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //    [self.pickerController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        self.didCropToImage(image, cropRect, angle);
    }];
}

- (void)cropViewController:(TOCropViewController *)cropViewController
        didFinishCancelled:(BOOL)cancelled
{
    //    NSLog(@"didFinishCancelled - %@", @"Trong ham nay");
    self.didCancel();
    [cropViewController.navigationController popViewControllerAnimated:YES];
}



@end
