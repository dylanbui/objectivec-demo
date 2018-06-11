//
//  ProcessImageUploadViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/8/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "ProcessImageUploadViewController.h"

#import "DemoUploadPhotoOperation.h"

#import "RMPImageCollectionViewCell.h"

@interface ProcessImageUploadViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray *arrImages;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation ProcessImageUploadViewController

static NSString * const reuseIdentifier = @"Cell";
static const CGFloat kCellMargin = 5;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupData];
    
    [self.clvContent registerNib:[UINib nibWithNibName:@"RMPImageCollectionViewCell" bundle:[NSBundle mainBundle]]
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
    self.arrImages = [images copy];
}

#pragma mark -

- (IBAction)btnUpload_Click:(id)sender
{
    __block NSError *uploadError = nil;
    
    DbOperationQueue *queue = [[DbOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:1]; // SERIAL
    [queue setCompletionQueue:^{
        // -- CompletionAllOperations --
        // -- Update the progress view --
        if ([NSThread isMainThread]) {
            NSLog(@"%@", @"NSThread isMainThread");
        } else {
            NSLog(@"%@", @"NSThread subThread");
        }
        
        [DbUtils dispatchToMainQueue:^{
            //[hudProcess hideAnimated:YES];
            if (uploadError) {
                //                complete(0);
            } else {
                //                complete(1);
            }
        }];
    }];
    // -- Dang bi loi, ko the chay trong cac view bi che --
    for (int i = 0; i < 8; i++) {
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.clvContent cellForItemAtIndexPath:indexPath];
        
        MBProgressHUD *hudProcess = [MBProgressHUD showHUDAddedTo:cell.contentView animated:YES];
        hudProcess.mode = MBProgressHUDModeAnnularDeterminate; // Vong tron
        hudProcess.bezelView.color = [UIColor clearColor];
        hudProcess.progress = 0.0;
        
        DemoUploadPhotoOperation *uploadProcess = [[DemoUploadPhotoOperation alloc] init];
        
        uploadProcess.startOperationBlock = ^(id owner, id data) {

        };
        
        uploadProcess.uploadProgressOperationBlock = ^(id result, NSProgress *uploadProgress) {
            hudProcess.progress = uploadProgress.fractionCompleted;
        };
        
        uploadProcess.completionOperationBlock = ^(id owner, id result, NSError *error) {
            // -- CompletionOperationBlock --
            if (error != nil) {
                NSLog(@"UploadPhotoOperation = %@", @"cancelAllOperations");
                uploadError = error;
                [queue cancelAllOperations];
            }
            
            UIImage *image = [[UIImage imageNamed:@"Checkmark"]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            hudProcess.customView = imageView;
            hudProcess.mode = MBProgressHUDModeCustomView;
            [hudProcess hideAnimated:YES afterDelay:0.5];
        };

        // -- Start queue --
        [queue addOperation:uploadProcess];
    }
}

#pragma mark - Private function
#pragma mark -

- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
}

- (void)doSomeWorkWithProgressObject:(NSProgress *)progressObject
{
    // This just increases the progress indicator in a loop.
    while (progressObject.fractionCompleted < 1.0f) {
        if (progressObject.isCancelled) break;
        [progressObject becomeCurrentWithPendingUnitCount:1];
        [progressObject resignCurrent];
        usleep(50000);
    }
}

//- (void)doSomeWorkWithProgress
//{
//    self.canceled = NO;
//    // This just increases the progress indicator in a loop.
//    float progress = 0.0f;
//    while (progress < 1.0f) {
//        if (self.canceled) break;
//        progress += 0.01f;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // Instead we could have also passed a reference to the HUD
//            // to the HUD to myProgressTask as a method parameter.
//            [MBProgressHUD HUDForView:self.navigationController.view].progress = progress;
//        });
//        usleep(50000);
//    }
//}

- (void)doSomeWorkWithMixedProgress:(MBProgressHUD *)hud {
    // Indeterminate mode
    sleep(2);
    // Switch to determinate mode
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.mode = MBProgressHUDModeDeterminate;
        hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    });
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.progress = progress;
        });
        usleep(50000);
    }
    // Back to indeterminate mode
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = NSLocalizedString(@"Cleaning up...", @"HUD cleanining up title");
    });
    sleep(2);
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = NSLocalizedString(@"Completed", @"HUD completed title");
    });
    sleep(2);
}

#pragma mark - <UICollectionViewDataSource>
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arrImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMPImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSDictionary *info = self.arrImages[indexPath.row];
    cell.imageView.image = info[@"image"];
    cell.titleLabel.text = info[@"filename"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    self.selectedIndexPath = indexPath;
//
//    NSString *filename = [NSString stringWithFormat:@"%02lu_L.jpeg", self.selectedIndexPath.row + 1];
    // -- The image we'll be cropping --
    // self.image = [UIImage imageNamed:filename];
    
//    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
    // CGRect viewFrame = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
    // CGRect viewFrame = [cell.imageView convertRect:cell.imageView.frame toView:self.navigationController.view];
    
    // When tapping the image view, restore the image to the previous cropping state
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat length = (CGRectGetWidth(self.view.frame) / 2) - (kCellMargin * 2);
    return CGSizeMake(length, length);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, kCellMargin, kCellMargin, kCellMargin);
}





@end

