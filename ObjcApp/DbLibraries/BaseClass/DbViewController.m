//
//  BaseViewController.m
//  PhotoManager
//
//  Created by Dylan Bui on 12/16/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import "DbViewController.h"

@interface DbViewController () {
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initDbControllerData];
    }
    return self;
}

- (void)initDbControllerData
{
    self.appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
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
    
    self.isLoadingDataSource = NO;
    
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

- (void)viewWillAppear:(BOOL)animated
{
    // -- Process show/hide navigation bar --
    // -- Default self.isNavigationBarHidden = NO => Navigation bar allways be show --        
    [self.navigationController setNavigationBarHidden:self.isNavigationBarHidden animated:YES];
    
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

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.defaultImageForEmptyDataSet == nil) {
        UIImage *image = [UIImage imageNamed:@"ic_empty_data.png"
                                    inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        return image;
    }
    else
        return self.defaultImageForEmptyDataSet;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Chưa có dữ liệu.";
    if (self.titleForEmptyDataSet) {
        text = self.titleForEmptyDataSet;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName: [DbUtils colorWithHexString:@"#989898" alpha:0.3]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if (!self.isLoadingDataSource)
        return nil;
    
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
    if (self.tblContent) {
        [self.tblContent.pullToRefreshView stopAnimating];
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
        [DbUtils showSettingsNetworkConnection:[UIApplication sharedApplication].keyWindow.rootViewController];
    }
}

@end
