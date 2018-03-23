//
//  BaseViewController.m
//  PhotoManager
//
//  Created by Dylan Bui on 12/16/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import "DbViewController.h"
#import "DbErrorView.h"

@interface DbViewController () {
    int errorCode;
    
}

@property (nonatomic, assign) BOOL isNavigationBarHidden;

@end

@implementation DbViewController

@synthesize stranferParams;
@synthesize appDelegate;

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

- (instancetype)initFromDeviceNib
{
    NSString *nibName = [DbUtils nibNamedForDevice:NSStringFromClass([self class])];
    NSLog(@"initFromDeviceNib with nibName = %@", nibName);
    self = [super initWithNibName:nibName bundle:nil];
    if (self) {
        [self initDbControllerData];
    }
    return self;
}


// -- Tu dong chay khi tao giao dien XIB -- 
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    nibNameOrNil = [DbUtils nibNamedForDevice:nibNameOrNil];
//    // NSLog(@"LOG VAL : nibNameOrNil from parent = %@", nibNameOrNil); /* DEBUG LOG */
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        [self initDbControllerData];
//    }
//    return self;
//}

- (void)initDbControllerData
{
    self.appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    errorCode = 0;
}

// -- Should run after init and before viewDidLoad --
- (void)initLoadDataForController:(id)params
{

}

#pragma mark -
#pragma mark Circle Live ViewController
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [DbUtils postNotification:NOTIFY_VCL_DID_LOAD object:self];
    // -- Define push notification --
    [DbUtils removeNotification:self name:NOTIFY_REACHABLE_NETWORK];
    [DbUtils addNotification:NOTIFY_REACHABLE_NETWORK observer:self selector:@selector(loadDataFromServer) object:nil];
    
    // -- Show loading first in UITableView -- 
    self.isLoadingDataSource = YES;
    
    self.titleForEmptyDataSet = nil;
    self.defaultImageForEmptyDataSet = nil;
    self.verticalOffsetForEmptyDataSet = 0;
    
    // -- UITableView --
    if (self.tblContent) {
        self.tblContent.rowHeight = UITableViewAutomaticDimension;
        self.tblContent.estimatedRowHeight = 44;
        self.tblContent.delegate = self;
        self.tblContent.dataSource = self;
        
        self.tblContent.emptyDataSetSource = self;
        self.tblContent.emptyDataSetDelegate = self;
    }
}

- (void)loadDataFromServer
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // -- Process show/hide navigation bar --
    // -- Default self.isNavigationBarHidden = NO => Navigation bar allways be show --        
    [self.navigationController setNavigationBarHidden:self.isNavigationBarHidden animated:YES];
    //errorCode = 0;
    
    [super viewWillAppear:animated];
    [DbUtils postNotification:NOTIFY_VCL_WILL_APPEAR object:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [DbUtils postNotification:NOTIFY_VCL_DID_APPEAR object:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [DbUtils postNotification:NOTIFY_VCL_WILL_DISAPPEAR object:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [DbUtils postNotification:NOTIFY_VCL_DID_DISAPPEAR object:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [DbUtils removeNotification:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark Public Functions
#pragma mark -

- (void)navigationBarHiddenForThisController
{
    self.isNavigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark -
#pragma mark DZNEmptyDataSetSource methods
#pragma mark -

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.verticalOffsetForEmptyDataSet)
        return self.verticalOffsetForEmptyDataSet;
    return -self.tblContent.tableHeaderView.frame.size.height/2.0f;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    // -- Network connection --
    if (errorCode == 1005) {
        DbErrorView *vwError = [[DbErrorView alloc] init];
        [vwError errorNetworkConnection];
        return vwError;
    }
    
    // -- Empty data --
    if (!self.isLoadingDataSource) {
        DbErrorView *vwError = [[DbErrorView alloc] init];
        [vwError errorEmptyData];
        if (self.titleForEmptyDataSet != nil) {
            vwError.lblTitle.text = self.titleForEmptyDataSet;
        }
        if (self.defaultImageForEmptyDataSet != nil) {
            vwError.imgError.image = self.defaultImageForEmptyDataSet;
        }
        return vwError;
    }
    
    // -- Default is loading --
    UIActivityIndicatorView *activityView =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView startAnimating];
    return activityView;
}

#pragma mark -
#pragma mark UITableViewDataSource methods
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -
#pragma mark === ICallbackParentDelegate ===
#pragma mark -

- (void)onCallback:(id)_self andCallerId:(NSInteger)callerId withParams:(NSDictionary *)params withError:(NSError *)error
{

}

#pragma mark -
#pragma mark IDbWebConnectionDelegate
#pragma mark -

- (void)onRequestProgress:(NSProgress *)downloadProgress andCallerId:(int)callerId
{
    
}

- (void)onRequestCompleteWithContent:(id)content andCallerId:(int)callerId
{
    self.isLoadingDataSource = NO;
    errorCode = 0;
    if (self.tblContent) {
        [self.tblContent.pullToRefreshView stopAnimating];
        [self.tblContent.infiniteScrollingView stopAnimating];
    }
}

-(void)onRequestErrorWithContent:(id)content andCallerId:(int)callerId andError:(NSError *)error
{
    self.isLoadingDataSource = NO;
    if (self.tblContent) {
        [self.tblContent.pullToRefreshView stopAnimating];
    }
    NSLog(@"DbViewController - onRequestErrorWithContent : %@",[error description]);
    if (error.code == 1005 && [error.domain isEqualToString:@"WebServiceClientErrorDomain"]) {
        // -- Error connection wifi => Show network connection alert --
        errorCode = 1005;
        if (self.tblContent) {
            [self.tblContent reloadData];
        }
        [DbUtils showSettingsNetworkConnection:[UIApplication sharedApplication].keyWindow.rootViewController];
    }
}

@end
