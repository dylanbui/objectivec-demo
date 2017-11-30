//
//  DemoMyCameraViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/29/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DemoMyCameraViewController.h"
#import "MyCameraControllerViewController.h"

@interface DemoMyCameraViewController () <ImagePickerViewControllerDelegate>

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
    MyCameraControllerViewController *cam = [[MyCameraControllerViewController alloc] init];
    cam.imagePickerDelegate = self;
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

- (void)imageSelectionCancelled
{
    
}

- (void)imagesSelected:(NSMutableArray *)images
{
    NSLog(@"images = %d", (int) [images count]);
}


@end
