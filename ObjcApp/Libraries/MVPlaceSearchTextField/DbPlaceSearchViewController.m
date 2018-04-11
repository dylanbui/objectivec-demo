//
//  DbPlaceSearchViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/10/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbPlaceSearchViewController.h"
#import "PlaceObject.h"

@interface DbPlaceSearchViewController ()

@property (nonatomic, strong) NSMutableArray *arrContents;
@property (nonatomic, strong) UIActivityIndicatorView *searchLoadingActivityIndicator;

@property (nonatomic, strong) NSTimer *autoCompleteTimer;
@property (nonatomic, strong) NSString *substring;

@property (nonatomic, strong) GMSPlacesClient *placesClient;
@property (nonatomic, strong) GooglePlacesApiClient *placeApiClient;

@property (nonatomic,strong) IBOutlet UITextField* txtAutoComplete;
@property (nonatomic,strong) IBOutlet UITableView* tblContent;
@property (nonatomic,strong) IBOutlet UIButton* btnBack;
@property (nonatomic,strong) IBOutlet UIButton* btnCurrentLocation;

@end

@implementation DbPlaceSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // self.placesClient = [GMSPlacesClient sharedClient];
    self.placeApiClient = [GooglePlacesApiClient sharedInstance];
    self.placeApiClient.apiKey = self.apiKey;
    self.placeApiClient.apiKey = @"AIzaSyBK_MVp9sT3n-klZ4BIMnKHi1cjHJyYNFA";
    self.placeApiClient.country = @"VN";
    self.placeApiClient.language = @"vi";
    
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

- (IBAction)btnBack_Click:(id)sender
{
    
}

- (IBAction)btnCurrentLocation_Click:(id)sender
{
    
}

#pragma mark - UITextField
#pragma mark -

#pragma mark - Events

- (void)textFieldDidChangeWithNotification:(NSNotification *)aNotification
{
    if(aNotification.object == self.txtAutoComplete){
//        [self reloadData];

        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(fetchAutoCompleteSuggestions)
                                                   object:nil];
        
        [self performSelector:@selector(fetchAutoCompleteSuggestions)
                   withObject:nil
                   afterDelay:0.65];

    }
}

- (void)reloadData
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(fetchAutoCompleteSuggestions)
                                               object:nil];
    
    [self performSelector:@selector(fetchAutoCompleteSuggestions)
               withObject:nil
               afterDelay:0.5];
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
    NSLog(@"didSelectRowAtIndexPath = %@", placeObj.placeID);
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
