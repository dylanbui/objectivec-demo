//
//  DbPlaceSearchViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/10/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbPlaceSearchViewController.h"
#import "DbUtils.h"
#import "DbFontIconKit.h"
#import "UIView+LayoutHelper.h"

@interface DbPlaceSearchViewController ()

@property (nonatomic, strong) NSMutableArray *arrContents;
@property (nonatomic, strong) UIActivityIndicatorView *searchLoadingActivityIndicator;

@property (nonatomic, strong) NSString *substring;

@property (nonatomic, strong) GooglePlacesApiClient *placeApiClient;

@property (nonatomic,strong) IBOutlet UITextField* txtAutoComplete;
@property (nonatomic,strong) IBOutlet UITableView* tblContent;
@property (nonatomic,strong) IBOutlet UIButton* btnBack;
@property (nonatomic,strong) IBOutlet UIButton* btnCurrentLocation;

@property (nonatomic) BOOL isAddSubViewAction;

@end

@implementation DbPlaceSearchViewController

- (instancetype)init
{
    if (self = [super init]) {
        // -- Default value --
        self.country = @"VN";
        self.language = @"vi";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.isAddSubViewAction = NO;
    
    self.placeApiClient = [GooglePlacesApiClient sharedInstance];
    self.placeApiClient.apiKey = self.apiKey;
    self.placeApiClient.country = self.country;
    self.placeApiClient.language = self.language;
    
    // -- Define back button --
    DbFontAwesome *backIcon = [DbFontAwesome chevronLeftIconWithSize:7];
    [backIcon addAttribute:NSForegroundColorAttributeName value:[DbUtils colorWithHexString:@"#2196F3"]];
    UIImage *backImage = [backIcon imageWithSize:CGSizeMake(20, 20)];
    [self.btnBack setBackgroundImage:backImage forState:UIControlStateNormal];
    
    self.arrContents = [[NSMutableArray alloc] init];
    
//    [self.tblContent setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tblContent setDelegate:self];
    [self.tblContent setDataSource:self];
    self.tblContent.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangeWithNotification:)
                                                 name:UITextFieldTextDidChangeNotification object:self.txtAutoComplete];
    
    self.btnCurrentLocation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (IBAction)btnBack_Click:(id)sender
{
    if (self.isAddSubViewAction == NO) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    // -- Animation remove view --
    [self willMoveToParentViewController:nil];  // 1
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.origin = CGPointMake(10, 10);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];            // 2
        [self removeFromParentViewController];      // 3
    }];
}

- (IBAction)btnCurrentLocation_Click:(id)sender
{
    // CLLocationCoordinate2D location = CLLocationCoordinate2DMake(10.794369, 106.680117);
    // -- Show loading if need --
    [self.placeApiClient retrievePlaceDetailsByGps:self.currentLocation withCompletion:^(GooglePlaceDetail *place, NSError *error) {
//        NSLog(@"%@", @"CurrentLocation");
//        NSLog(@"name = %@", place.name);
//        NSLog(@"formatedAddress = %@", place.formattedAddress);
//        NSLog(@"location = %@", place.location);
//        [self.delegate searchViewController:self didReturnPlace:place];
        if (self.didReturnPlace != nil) {
            self.didReturnPlace(self, place);
        }
        [self btnBack_Click:nil];
    }];
}

- (void)addSubViewPlaceSearch
{
    UIViewController *topVcl = [DbUtils getTopViewController];
    // NSLog(@"vcl.view.frame = %@", NSStringFromCGRect(topVcl.view.frame));
    
    // -- Set view --
    self.view.frame = topVcl.view.frame;
    self.view.alpha = 0;
    // -- Add subview --
    [topVcl addChildViewController:self];
    [topVcl.view addSubview:self.view];
    
    // -- Animation display view --
    self.view.origin = CGPointMake(10, 10);
    [UIView animateWithDuration:0.3 animations:^{
        self.view.origin = CGPointMake(0, 0);
        self.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.isAddSubViewAction = YES;
    }];
}

#pragma mark - UITextField
#pragma mark -

#pragma mark - Events

- (void)textFieldDidChangeWithNotification:(NSNotification *)aNotification
{
    if(aNotification.object == self.txtAutoComplete){
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(fetchAutoCompleteSuggestions)
                                                   object:nil];
        
        [self performSelector:@selector(fetchAutoCompleteSuggestions)
                   withObject:nil
                   afterDelay:0.65];
    }
}

#pragma mark - Getters

- (void)fetchAutoCompleteSuggestions
{
    NSString *searchWordProtection = [self.txtAutoComplete.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(searchWordProtection.length > 0) {
    
        [self.placeApiClient retrieveGooglePlaceInformation:searchWordProtection withCompletion:^(NSArray *searchResults, NSError *error) {
            
            if (error != nil) {
                NSLog(@"Autocomplete error %@", [error localizedDescription]);
                return;
            }
            
            if (searchResults.count > 0) {
                self.arrContents = [[NSMutableArray alloc] initWithArray:searchResults];
            } else {
                [self.arrContents removeAllObjects];
            }
            
            [self.tblContent reloadData];
        }];
        
    } else {
        [self.arrContents removeAllObjects];
        [self.tblContent reloadData];
    }
}
#pragma mark - UITableView
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.arrContents.count) {
        return [self locationSearchResultCellForIndexPath:indexPath];
    } else {
        return [self loadingCell];
    }
}

- (UITableViewCell *)locationSearchResultCellForIndexPath:(NSIndexPath *)indexPath
{
    GoogleAutoCompleteResult *placeObj = [self.arrContents objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tblContent dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    [cell.textLabel setText:placeObj.mainAddress];
    [cell.detailTextLabel setText:placeObj.secondaryAddress];
    
    return cell;
}


#pragma mark - Table View Delegate Methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoogleAutoCompleteResult *placeObj = [self.arrContents objectAtIndex:indexPath.row];
    // NSLog(@"didSelectRowAtIndexPath = %@", placeObj.placeID);
    
    [self.placeApiClient retrievePlaceDetailsById:placeObj.placeID withCompletion:^(GooglePlaceDetail *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Autocomplete error %@", [error localizedDescription]);
            return;
        }

//        NSLog(@"name = %@", place.name);
//        NSLog(@"formatedAddress = %@", place.formattedAddress);
//        NSLog(@"location = %@", place.location);
//        [self.delegate searchViewController:self didReturnPlace:place];
        
        if (self.didReturnPlace != nil) {
            self.didReturnPlace(self, place);
        }
        [self btnBack_Click:nil];
    }];
}

#pragma mark - Properties

- (UITableViewCell *)loadingCell
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView addSubview:self.searchLoadingActivityIndicator];
    
    return cell;
}

- (UIActivityIndicatorView *)searchLoadingActivityIndicator
{
    if (!_searchLoadingActivityIndicator) {
        _searchLoadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_searchLoadingActivityIndicator setCenter:CGPointMake(self.view.center.x, 22)];
        [_searchLoadingActivityIndicator setHidesWhenStopped:YES];
    }
    return _searchLoadingActivityIndicator;
}

@end
