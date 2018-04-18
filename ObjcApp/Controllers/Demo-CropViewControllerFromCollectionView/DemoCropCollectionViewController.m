//
//  DemoCropCollectionViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/18/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DemoCropCollectionViewController.h"
#import "TOCropViewController.h"

#import "RMPImageCollectionViewCell.h"


@interface DemoCropCollectionViewController ()<UICollectionViewDelegateFlowLayout, TOCropViewControllerDelegate>

@property (nonatomic, copy) NSArray *images;

@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle; //The cropping style
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;

@property (nonatomic, strong) UIImage *image;           // The image we'll be cropping

@end

@implementation DemoCropCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static const CGFloat kCellMargin = 5;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupData];
    
    self.croppingStyle = TOCropViewCroppingStyleDefault;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RMPImageCollectionViewCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:reuseIdentifier];
    
    self.navigationItem.title = @"Collection View";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark -

- (void)setupData
{
    NSMutableArray *images = [NSMutableArray array];
    // we prepared 16 images for example
    for (int i = 1; i <= 16 ; i++) {
        NSString *filename = [NSString stringWithFormat:@"%02d_S.jpeg", i];
        NSDictionary *info = @{
                               @"filename": filename,
                               @"image"   : [UIImage imageNamed:filename]
                               };
        
        [images addObject:info];
    }
    self.images = [images copy];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMPImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSDictionary *info = self.images[indexPath.row];
    cell.imageView.image = info[@"image"];
    cell.titleLabel.text = info[@"filename"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    
    NSString *filename = [NSString stringWithFormat:@"%02lu_L.jpeg", selectedIndexPath.row + 1];
    // -- The image we'll be cropping --
    self.image = [UIImage imageNamed:filename];
    
    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    CGRect viewFrame = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
//    CGRect viewFrame = [self.view convertRect:self.imageView.frame toView:self.navigationController.view];
    
    // When tapping the image view, restore the image to the previous cropping state
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault
                                                                                         image:self.image];
    cropController.delegate = self;
    
//    - (void)presentAnimatedFromParentViewController:(nonnull UIViewController *)viewController
//fromView:(nullable UIView *)fromView
//fromFrame:(CGRect)fromFrame
//setup:(nullable void (^)(void))setup
//completion:(nullable void (^)(void))completion NS_SWIFT_NAME(presentAnimated(from:view:frame:setup:completion:));
    
    [cropController presentAnimatedFromParentViewController:self
                                                  fromImage:cell.imageView.image //self.imageView.image
                                                   fromView:nil
                                                  fromFrame:viewFrame
                                                      angle:self.angle
                                               toImageFrame:self.croppedFrame
                                                      setup:^{
                                                          //self.imageView.hidden = YES;
                                                      }
                                                 completion:nil];
    
    
    // [cropController dismissAnimatedFromParentViewController:self toView:cell.imageView toFrame:viewFrame setup:nil completion:nil];
    
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    CGFloat length = (CGRectGetWidth(self.view.frame) / 2) - (kCellMargin * 2);
    if (isPad) {
        // fixed size for iPad in landscape and portrait
        length = 256 - (kCellMargin * 2);
    }
    return CGSizeMake(length, length);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, kCellMargin, kCellMargin, kCellMargin);
}

#pragma mark - Cropper Delegate -

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    // [self updateImageViewWithImage:image fromCropViewController:cropViewController];
    NSLog(@"%@", @"didCropToImage");
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    
    NSString *filename = [NSString stringWithFormat:@"%02lu_L.jpeg", selectedIndexPath.row + 1];
    // -- The image we'll be cropping --
    self.image = [UIImage imageNamed:filename];
    
    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    CGRect viewFrame = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
    
    [cropViewController dismissAnimatedFromParentViewController:self
                                               withCroppedImage:image
                                                         toView:cell.imageView
                                                        toFrame:viewFrame
                                                          setup:^{
                                                              //[self layoutImageView];
                                                              
                                                          }
                                                     completion:nil];
}

//- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
//{
//    self.croppedFrame = cropRect;
//    self.angle = angle;
//    NSLog(@"%@", @"didCropToCircularImage");
//    // [self updateImageViewWithImage:image fromCropViewController:cropViewController];
//}

@end

