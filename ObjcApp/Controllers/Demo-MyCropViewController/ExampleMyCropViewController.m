//
//  ExampleMyCropViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/19/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "ExampleMyCropViewController.h"
#import "DbFontAwesomeKit.h"
#import "DbBarButtonItem.h"

// -- Co the dung them --
// https://www.cocoacontrols.com/controls/babcropperview

@interface ExampleMyCropViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PECropViewControllerDelegate>

@property (nonatomic, strong) UIButton *btnEditor;
@property (nonatomic, strong) UIButton *btnCamera;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation ExampleMyCropViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // -- Define right menu --
    DbFontAwesome *editIcon = [DbFontAwesome pencilSquareOIconWithSize:20];
    [editIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]];
    
    DbBarButtonItem* btn_1 = [DbBarButtonItem barItemWithImage:[editIcon imageWithSize:(CGSize){20, 20}]
                                                 selectedImage:nil
                                                    clickBlock:^(id sender) {
                                                        [self btnEdit_Click:nil];
                                                    }];
    
    DbFontAwesome *cameraIcon = [DbFontAwesome videoCameraIconWithSize:20];
    [cameraIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]];
    
    DbBarButtonItem* btn_2 = [DbBarButtonItem barItemWithImage:[cameraIcon imageWithSize:(CGSize){20, 20}]
                                                 selectedImage:nil
                                                    clickBlock:^(id sender) {
                                                        [self btnCamera_Click:nil];
                                                    }];
    
    [self.navigationItem setRightBarButtonItems:@[btn_2, btn_1]];
    
}

#pragma mark -
#pragma mark Button Action
#pragma mark -

- (IBAction)btnEdit_Click:(UIButton *)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.imageView.image;
    
    UIImage *image = self.imageView.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (IBAction)btnCamera_Click:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Photo Album", nil), nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", nil)];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
    [actionSheet showFromToolbar:self.navigationController.toolbar];
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    self.imageView.image = croppedImage;
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Private methods

- (void)showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)openPhotoAlbum
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)updateEditButtonEnabled
{
//    self.editButton.enabled = !!self.imageView.image;
}

#pragma mark - UIActionSheetDelegate methods

/*
 Open camera or photo album.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(@"Photo Album", nil)]) {
        [self openPhotoAlbum];
    } else if ([buttonTitle isEqualToString:NSLocalizedString(@"Camera", nil)]) {
        [self showCamera];
    }
}

#pragma mark - UIImagePickerControllerDelegate methods

/*
 Open PECropViewController automattically when image selected.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self btnEdit_Click:nil];
    }];
}

@end
