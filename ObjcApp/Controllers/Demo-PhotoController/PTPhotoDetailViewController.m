//
//  PTPhotoDetailViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 10/5/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "PTPhotoDetailViewController.h"
#import "PhotoGalleryViewController.h"
#import "CropPhotoViewController.h"
#import "UIImage+Resize.h"

@interface PTPhotoDetailViewController ()

@end

@implementation PTPhotoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Detail photo";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnChoose_Click:(UIButton *)sender
{
    PhotoGalleryViewController *vclGallery = nil;
    CropPhotoViewController *vclCropPhoto = nil;
    if (sender.tag == 1) {
        NSLog(@"%@", @"tag === 1");
        vclGallery = [PhotoGalleryViewController sharedInstance];
        [vclGallery setDidSelectAssets:^(NSArray<DKAsset *> * _Nonnull assets) {
            // -- First --
            [self addDKAsset:[assets objectAtIndex:0] toImage:self.img_1];
        }];
        [self presentViewController:vclGallery animated:YES completion:nil];
        // [[DbUtils getTopViewController] presentViewController:vclGallery animated:YES completion:nil];
    }
    if (sender.tag == 2) {
        NSLog(@"%@", @"tag === 2");
        vclGallery = [PhotoGalleryViewController sharedInstance];
        // -- Last --
        [vclGallery setDidSelectAssets:^(NSArray<DKAsset *> * _Nonnull assets) {
            [self addDKAsset:[assets objectAtIndex:(assets.count - 1)] toImage:self.img_2];
        }];
        [self presentViewController:vclGallery animated:YES completion:nil];
    }
    if (sender.tag == 3) {
        NSLog(@"%@", @"tag === 3");
        vclCropPhoto = [CropPhotoViewController sharedInstance];
        [vclCropPhoto setDidCropToImage:^(UIImage * _Nonnull image, CGRect cropRect, NSInteger angle) {
            UIImage *imgNewAvatar = [image cropCenterToSize:self.img_3.frame.size];
            [self.img_3 setImage:imgNewAvatar];
        }];
        [self presentViewController:vclCropPhoto animated:YES completion:nil];
    }
    if (sender.tag == 4) {
        NSLog(@"%@", @"tag === 4");
        vclCropPhoto = [CropPhotoViewController sharedInstance];
        [vclCropPhoto setDidCropToImage:^(UIImage * _Nonnull image, CGRect cropRect, NSInteger angle) {
            UIImage *imgNewAvatar = [image cropCenterToSize:self.img_4.frame.size];
            [self.img_4 setImage:imgNewAvatar];
        }];
        [self presentViewController:vclCropPhoto animated:YES completion:nil];
        
    }
    
}

- (void)addDKAsset:(DKAsset *)asset toImage:(UIImageView *)imageView
{
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode   = PHImageRequestOptionsResizeModeFast;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    requestOptions.synchronous = NO; // User synchronous
    
    [asset fetchImageWithSize:imageView.frame.size options:requestOptions
                completeBlock:^(UIImage * _Nullable image, NSDictionary * _Nullable dict) {
                    NSLog(@"image.size = %@", NSStringFromCGSize(imageView.frame.size));
                    // -- Fix Image Orientation --
                    imageView.image = [image fixOrientation];
                }];
}


@end
