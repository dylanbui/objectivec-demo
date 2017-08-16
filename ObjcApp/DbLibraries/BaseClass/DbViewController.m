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

@end

@implementation DbViewController

@synthesize stranferParams;
@synthesize appDelegate;
//@synthesize userSession;

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
//    self.userSession = [UserSession instance];
}

// -- Should run after init and before viewDidLoad --
- (void)initLoadDataForController:(id)params
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [DbUtils postNotification:NOTIFY_VCL_DID_LOAD object:self];
}

- (void)viewWillAppear:(BOOL)animated
{
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
#pragma mark === ICallbackParentDelegate ===
#pragma mark -

- (void)onCallback:(id)_self andCallerId:(NSInteger)callerId withParams:(NSDictionary *)params withError:(NSError *)error
{

}

#pragma mark -
#pragma mark IWebConnectionDelegate
#pragma mark -

- (void)onRequestProgress:(NSProgress *)downloadProgress andCallerId:(int)callerId
{
    
}

- (void)onRequestCompleteWithContent:(id)content andCallerId:(int)callerId
{

}

-(void)onRequestErrorWithContent:(id)content andCallerId:(int)callerId andError:(NSError *)error
{
    NSLog(@"DbViewController - onRequestErrorWithContent : %@",[error description]);
    if (error.code == 1005 && [error.domain isEqualToString:@"WebServiceClientErrorDomain"]) {
        // -- Error connection wifi => Show network connection alert --
        [DbUtils showSettingsNetworkConnection:[UIApplication sharedApplication].keyWindow.rootViewController];
    }
}

@end
