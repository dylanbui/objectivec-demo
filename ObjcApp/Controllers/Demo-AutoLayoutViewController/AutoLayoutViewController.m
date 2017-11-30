//
//  AutoLayoutViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/30/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "AutoLayoutViewController.h"


@interface AutoLayoutViewController () {
    CMMotionManager *motionManager;
    UIInterfaceOrientation orientationLast, orientationAfterProcess;

}

@property (nonatomic, strong) UIButton *movingButton;
@property (nonatomic, assign) BOOL topLeft;

- (void)toggleButtonPosition;

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.movingButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.movingButton.frame = CGRectMake(50, 50, 100, 100);
    [self.movingButton setTitle:@"Move Me!" forState:UIControlStateNormal];
    self.movingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.movingButton.layer.borderWidth = 3;
    
//    [self.movingButton addTarget:self action:@selector(toggleButtonPosition) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.movingButton];
//    self.topLeft = YES;
//    [self updateConstraints];
    
    // -- Dung gia toc ke de bat su kien quay man hinh --
    // [self initializeMotionManager];
    
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification  object:nil];
    
    [self orientationChanged:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark ---
#pragma mark -

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    // Disable autorotation of the interface when recording is in progress.
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];

    //if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
    
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.width.and.height.equalTo(@50);
//            make.width.equalTo(@(50));
//            make.height.equalTo(@(50));
            
            make.top.equalTo(self.view.mas_top).with.offset(10);
            make.left.equalTo(self.view.mas_left).with.offset(10);

            
//            make.top.equalTo(self.view.mas_top).with.offset(-100);
//            make.left.equalTo(self.view.mas_left).with.offset(0);
//            make.top.equalTo(@0);
//            make.left.equalTo(@0);
        }];
    } else {
        [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(50));
            make.height.equalTo(@(50));

            make.top.equalTo(self.view.mas_top).with.offset(10);
            make.right.equalTo(self.view.mas_right).with.offset(-10);


//            make.top.equalTo(@250);
//            make.right.equalTo(@50);
        }];
    }

}




+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints
{
    
    [self.movingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(100));
        make.height.equalTo(@(100));
        
        if (self.topLeft) {
            make.left.equalTo(self.view.mas_left).with.offset(10);
            make.top.equalTo(self.view.mas_top).with.offset(70);
        }
        else {
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
            make.right.equalTo(self.view.mas_right).with.offset(-10);
        }
    }];
    
    //according to apple super should be called at end of method
    [super.view updateConstraints];
}

- (void)toggleButtonPosition
{
    self.topLeft = !self.topLeft;
    
    // tell constraints they need updating
//    [self.view setNeedsUpdateConstraints];
//    
//    // update constraints now so we can animate the change
//    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self updateConstraints];
        [self.view layoutIfNeeded];
    }];
}

- (void)rotateDevice:(const UIInterfaceOrientation)ORIENTATION
{
    if (ORIENTATION == UIInterfaceOrientationLandscapeLeft) {
        [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(50));
            make.height.equalTo(@(50));
            
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
            make.right.equalTo(self.view.mas_right).with.offset(-10);
            
//            make.left.equalTo(self.left).with.offset(10);
//            make.top.equalTo(self.top).with.offset(10);
//
//            make.bottom.equalTo(self.bottom).with.offset(-10);
//            make.right.equalTo(self.right).with.offset(-10);
        }];
    }
    else {
        [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(50));
            make.height.equalTo(@(50));
            
            make.top.equalTo(self.view.mas_top).with.offset(10);
            make.left.equalTo(self.view.mas_left).with.offset(10);
            
            //            make.left.equalTo(self.left).with.offset(10);
            //            make.top.equalTo(self.top).with.offset(10);
            //
            //            make.bottom.equalTo(self.bottom).with.offset(-10);
            //            make.right.equalTo(self.right).with.offset(-10);
        }];
        
    }
}

#pragma mark - CoreMotion Task - Chi su dung duoc tren device

- (void)initializeMotionManager
{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = .2;
    motionManager.gyroUpdateInterval = .2;
    
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                            if (!error) {
                                                [self outputAccelertionData:accelerometerData.acceleration];
                                            }
                                            else{
                                                NSLog(@"%@", error);
                                            }
                                        }];
}

#pragma mark - UIAccelerometer callback

- (void)outputAccelertionData:(CMAcceleration)acceleration
{
    UIInterfaceOrientation orientationNew;
    
    if (acceleration.x >= 0.75) {
        orientationNew = UIInterfaceOrientationLandscapeLeft;
    }
    else if (acceleration.x <= -0.75) {
        orientationNew = UIInterfaceOrientationLandscapeRight;
    }
    else if (acceleration.y <= -0.75) {
        orientationNew = UIInterfaceOrientationPortrait;
    }
    else if (acceleration.y >= 0.75) {
        orientationNew = UIInterfaceOrientationPortraitUpsideDown;
    }
    else {
        // Consider same as last time
        return;
    }
    
    if (orientationNew == orientationLast)
        return;

    // -- Debug --
    NSLog(@"Going from %@ to %@!", [[self class] orientationToText:orientationLast], [[self class] orientationToText:orientationNew]);
    
    orientationLast = orientationNew;
    
    [self rotateDevice:orientationLast];
}

+ (NSString*)orientationToText:(const UIInterfaceOrientation)ORIENTATION
{
    switch (ORIENTATION) {
        case UIInterfaceOrientationPortrait:
            return @"UIInterfaceOrientationPortrait";
        case UIInterfaceOrientationPortraitUpsideDown:
            return @"UIInterfaceOrientationPortraitUpsideDown";
        case UIInterfaceOrientationLandscapeLeft:
            return @"UIInterfaceOrientationLandscapeLeft";
        case UIInterfaceOrientationLandscapeRight:
            return @"UIInterfaceOrientationLandscapeRight";
        case UIInterfaceOrientationUnknown:
            return @"UIInterfaceOrientationUnknown";
    }
    return @"Unknown orientation!";
}


@end
