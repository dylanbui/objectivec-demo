//
//  DemoMyCameraViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/29/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DemoMyCameraViewController.h"
//#import "MyCameraControllerViewController.h"
#import "DbCameraViewController.h"

@interface DemoMyCameraViewController () <DbCameraImageDelegate>

@end

@implementation DemoMyCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShowCamera_Click:(id)sender
{
    DbCameraViewController *cam = [[DbCameraViewController alloc] init];
    cam.imageCameraDelegate = self;
    [self presentViewController:cam animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)cameraImageCancelled
{
    NSLog(@"%@", @"imageSelectionCancelled");
}

- (void)cameraImagesSelected:(NSMutableArray *)images
{
    NSLog(@"images = %d", (int) [images count]);
}


@end
