//
//  BaseViewController.m
//  PhotoManager
//
//  Created by Dylan Bui on 12/16/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Resize.h"

@interface BaseViewController () {
    
}

@end

@implementation BaseViewController

@synthesize userSession;

- (id)init
{
    self = [super init];
    if(self) {
        [self initDbControllerData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initDbControllerData];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initDbControllerData];
    }
    return self;
}


- (void)initDbControllerData
{
    self.userSession = [UserSession instance];
}

// -- Should run after init and before viewDidLoad --
- (void)initLoadDataForController:(id)params
{

}

#pragma mark -
#pragma mark ViewController Circle Live
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    // self.edgesForExtendedLayout = NO;
    
//    // -- Config NavigationBar Background --
//    UIImage *img_bg = [[UIImage imageNamed:@"bg_top_address"]
//                       croppedImage:CGRectMake(0, 0, SCREEN_WIDTH, self.navigationController.navigationBar.frame.size.height + 20)];
//    [self.navigationController.navigationBar setBackgroundImage:img_bg forBarMetrics:UIBarMetricsDefault];
//    
//    // -- Config NavigationBar Title Font --
//    NSDictionary *titleAttributes =@{
//                                     NSFontAttributeName :FONT_NAVIGATION_TITLE_BAR,
//                                     NSForegroundColorAttributeName : [DbUtils colorWithHexString:@"#313131"] };
//    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
//    // self.navigationItem.title = @"title";
//    
//    // -- Config NavigationBar Back button (Change icon) --
//    UIImage *backBtn = [UIImage imageNamed:@"ic_arrow_back"];
//    backBtn = [backBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    //     self.navigationItem.backBarButtonItem.title = @"";
//    //    self.navigationController.navigationBar.topItem.title = @"";
//    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:nil
//                                                                            action:nil];
//    
//    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
//    self.navigationController.navigationBar.backIndicatorImage = backBtn;
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if (self.navigationController.isNavigationBarHidden) {}
//    [self.navigationController setNavigationBarHidden:self.navigationController.isNavigationBarHidden animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    BOOL hidden = self.navigationController.isNavigationBarHidden;
//    [self.navigationController setNavigationBarHidden:!hidden animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark === ICallbackParentDelegate ===
#pragma mark -

//- (void)onCallback:(id)_self andCallerId:(NSInteger)callerId withParams:(NSDictionary *)params withError:(NSError *)error
//{
//}

#pragma mark -
#pragma mark IWebConnectionDelegate
#pragma mark -

//- (void)onRequestProgress:(NSProgress *)downloadProgress andCallerId:(int)callerId
//{
//    
//}
//
//- (void)onRequestCompleteWithContent:(id)content andCallerId:(int)callerId
//{
//
//}
//
//-(void)onRequestErrorWithContent:(id)content andCallerId:(int)callerId andError:(NSError *)error
//{
//    NSLog(@"BaseViewController - onRequestErrorWithContent : %@",[error description]);
//
//    if (error.code == 1005 && [error.domain isEqualToString:@"WebServiceClientErrorDomain"]) {
//        // -- Error connection wifi => Show network connection alert --
//    }
//}


@end
