//
//  PhotoGalleryViewController.m
//  PropzyTenant
//
//  Created by Dylan Bui on 7/21/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "PhotoGalleryViewController.h"

@interface PhotoGalleryViewController ()

@property (nonatomic, strong) DKImagePickerController * _Nullable  pickerController; // Choose image viewcontroler

@end

@implementation PhotoGalleryViewController

@synthesize assetType;

// -- Dont allow init --
- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Use sharedInstance functions" userInfo:nil];
}

+ (instancetype _Nonnull)sharedInstance
{
    static PhotoGalleryViewController *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] initPrivate];
    });
    return _shared;
}

- (instancetype)initPrivate
{
    if (self = [super init]) {
        self.pickerController = [DKImagePickerController new];
        self.pickerController.assetType = DKImagePickerControllerAssetTypeAllPhotos;
        self.pickerController.autoDismissViewController = NO;
        self.pickerController.showsCancelButton = YES;
        self.pickerController.showsEmptyAlbums = YES;
        self.pickerController.allowMultipleTypes = NO;
        self.pickerController.singleSelect = NO;
        self.pickerController.sourceType = DKImagePickerControllerSourceTypeBoth;
        // -- Init variable --
        self.maxSelected = 5;
        self.sourceType = DKImagePickerControllerSourceTypeBoth;
        self.singleSelect = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerController.maxSelectableCount = (self.maxSelected <= 0) ? 5 : self.maxSelected;
    self.pickerController.sourceType = self.sourceType;
    self.pickerController.singleSelect = self.singleSelect;
    
    __weak __typeof(self) weakSelf = self;
    [self.pickerController setDidSelectAssets:^(NSArray * __nonnull assets) {
        if (assets.count <= 0) // Dont choose => dont run
            return;
        if (weakSelf.didSelectAssets)            
            weakSelf.didSelectAssets(assets);
        [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.pickerController setDidCancel:^{
        if(weakSelf.didCancel)
            weakSelf.didCancel();
        [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.view.frame = self.pickerController.view.frame;
    [self.view addSubview:self.pickerController.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.pickerController deselectAllAssets];
}

@end
