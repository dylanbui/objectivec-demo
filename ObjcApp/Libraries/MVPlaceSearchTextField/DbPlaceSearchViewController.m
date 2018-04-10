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

@property (nonatomic, strong) NSArray *arrContents;
@property (nonatomic, strong) UIActivityIndicatorView *searchLoadingActivityIndicator;

@property (nonatomic, strong) NSTimer *autoCompleteTimer;
@property (nonatomic, strong) NSString *substring;

@property (nonatomic, strong) GMSPlacesClient *placesClient;

@end

@implementation DbPlaceSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.placesClient = [GMSPlacesClient sharedClient];
    
    [self.tblContent setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tblContent setDelegate:self];
    [self.tblContent setDataSource:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangeWithNotification:)
                                                 name:UITextFieldTextDidChangeNotification object:self];
    
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
    if(aNotification.object == self){
        [self reloadData];
    }
}

- (void)reloadData
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(fetchAutoCompleteSuggestions)
                                               object:nil];
    
    [self performSelector:@selector(fetchAutoCompleteSuggestions)
               withObject:nil
               afterDelay:0.65];
}

#pragma mark - Getters

- (void)fetchAutoCompleteSuggestions
{
    NSString *searchWordProtection = [self.txtAutoComplete.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    // filter.type = kGMSPlacesAutocompleteTypeFilterNoFilter;
    filter.type = kGMSPlacesAutocompleteTypeFilterAddress;
    filter.country = @"VN";
    if(searchWordProtection.length > 0) {
        [self.placesClient autocompleteQuery:searchWordProtection
                              bounds:nil
                              filter:filter
                            callback:^(NSArray *results, NSError *error) {
                                if (error != nil) {
                                    NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                    return;
                                }
                                if(results.count>0){
                                    NSMutableArray *arrfinal=[NSMutableArray array];
                                    for (GMSAutocompletePrediction* result in results) {
                                        NSDictionary *aTempDict =  [NSDictionary dictionaryWithObjectsAndKeys:result.attributedFullText.string,@"description",result.placeID,@"reference", nil];
                                        PlaceObject *placeObj=[[PlaceObject alloc]initWithPlaceName:[aTempDict objectForKey:@"description"]];
                                        placeObj.userInfo=aTempDict;
                                        [arrfinal addObject:placeObj];
                                        
                                    }
                                    // handler(arrfinal);
                                }else{
                                    // handler(nil);
                                }
                            }];
    }else{
        // handler(nil);
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


- (UITableViewCell *)locationSearchResultCellForIndexPath:(NSIndexPath *)indexPath {
    
//    ABCGoogleAutoCompleteResult *autoCompleteResult = [[ABCGooglePlacesAPIClient sharedInstance].searchResults objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tblContent dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
//    [cell.textLabel setText:autoCompleteResult.name];
//    [cell.detailTextLabel setText:autoCompleteResult.description];
    
    return cell;
}


#pragma mark - Table View Delegate Methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Properties

- (UITableViewCell *)loadingCell
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView addSubview:self.searchLoadingActivityIndicator ];
    
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
