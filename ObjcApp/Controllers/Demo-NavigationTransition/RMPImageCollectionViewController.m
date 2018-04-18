//
//  RMPImageCollectionViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/17/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "RMPImageCollectionViewController.h"

#import "RMPImageCollectionViewController.h"
#import "RMPImageCollectionViewCell.h"
#import "RMPDetailViewController.h"

@interface RMPImageCollectionViewController ()<UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate, RMPZoomTransitionAnimating>

@property (nonatomic, copy) NSArray *images;

@end

@implementation RMPImageCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static const CGFloat kCellMargin = 5;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupData];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RMPImageCollectionViewCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:reuseIdentifier];
    
    self.navigationItem.title = @"Collection View";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // -- KHong duoc goi reload cell tro lai, vi no se lam mat selected cell khi Backward -- 
//    [self.collectionView reloadData];
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
    RMPDetailViewController *vc = [[RMPDetailViewController alloc] init];
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    vc.index = selectedIndexPath.row;
    vc.transitioningDelegate = self;
    
//    [self.navigationController pushViewController:vc animated:YES];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:vc animated:YES completion:nil];
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

//#pragma mark <RMPZoomTransitionAnimating>
//
//- (UIImageView *)transitionSourceImageView
//{
//    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
//    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
//    imageView.contentMode = cell.imageView.contentMode;
//    imageView.clipsToBounds = YES;
//    imageView.userInteractionEnabled = NO;
//    imageView.frame = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
//    return imageView;
//}
//
//- (UIColor *)transitionSourceBackgroundColor
//{
//    return self.collectionView.backgroundColor;
//}
//
//- (CGRect)transitionDestinationImageViewFrame
//{
//    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
//    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
//    CGRect cellFrameInSuperview = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
//    return cellFrameInSuperview;
//}

#pragma mark - <RMPZoomTransitionAnimating>

- (UIImageView *)transitionSourceImageView
{
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
    imageView.contentMode = cell.imageView.contentMode;
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.collectionView.backgroundColor;
}

- (CGRect)transitionDestinationImageViewFrame
{
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    CGRect cellFrameInSuperview = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
    return cellFrameInSuperview;
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)source;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)presented;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = YES;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)dismissed;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)self;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = NO;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}



@end

