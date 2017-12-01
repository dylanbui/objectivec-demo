//
//  MyCameraControllerViewController.h
//  CustomCamera
//
//  Created by Dylan Bui on 5/12/17.
//  Copyright © 2017 Propzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbConstant.h"
#import "AVCamViewController.h"

@protocol DbCameraImageDelegate <NSObject>
- (void)cameraImageCancelled;
- (void)cameraImagesSelected:(NSMutableArray *)images;

@end

@interface DbCameraViewController : AVCamViewController

@property (nonatomic, weak) IBOutlet UIButton *btnSaveImage;
@property (nonatomic, weak) IBOutlet UIButton *btnFlash;
@property (nonatomic, weak) IBOutlet UIButton *btnClose;
@property (nonatomic, weak) IBOutlet UIButton *btnTakePhoto;

@property(nonatomic, weak) id<DbCameraImageDelegate> imageCameraDelegate;

@end
