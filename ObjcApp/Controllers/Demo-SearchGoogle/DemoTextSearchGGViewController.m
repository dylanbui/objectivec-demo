//
//  DemoTextSearchGGViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/9/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DemoTextSearchGGViewController.h"
#import "UIView+LayoutHelper.h"
#import "AddressTableViewCell.h"
#import "SuggestionAddressItemTableViewCell.h"
#import "DbPlaceSearchViewController.h"

@interface DemoTextSearchGGViewController ()

@end

@implementation DemoTextSearchGGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self navigationBarHiddenForThisController];
    
    // -- Conflicts with txtAutoCompletePlace when you choose row --
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
    
    // -- AutoCompletePlace Properties --
//    [self.txtAutoCompletePlace setValue:[UIFont fontWithName:@"OpenSans-Italic" size:15] forKeyPath:@"_placeholderLabel.font"];
    [self.txtAutoCompletePlace registerAutoCompleteCellClass:[SuggestionAddressItemTableViewCell class]
                                      forCellReuseIdentifier:@"SuggestionAddressItemTableViewCell"];
    [self.txtAutoCompletePlace registerAutoCompleteCellNib:[UINib nibWithNibName:@"SuggestionAddressItemTableViewCell" bundle:nil]
                                    forCellReuseIdentifier:@"SuggestionAddressItemTableViewCell"];
    
    self.txtAutoCompletePlace.placeSearchDelegate                 = self;
    self.txtAutoCompletePlace.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    self.txtAutoCompletePlace.autoCompleteShouldHideOnSelection   = YES;
    // -- Cho hien ra 20 item, nhung khung view chi hien 5 --
    [self.txtAutoCompletePlace setMaximumNumberOfAutoCompleteRows:20]; // pai dung cach nay
    
//    self.txtAutoCompletePlace.autoCompleteRegularFontName =  @"OpenSans-Semibold";
//    self.txtAutoCompletePlace.autoCompleteBoldFontName = @"OpenSans";
    self.txtAutoCompletePlace.autoCompleteTableCornerRadius = 5.0;
    self.txtAutoCompletePlace.autoCompleteRowHeight = 55;
    self.txtAutoCompletePlace.autoCompleteTableCellTextColor = [UIColor colorWithWhite:0.131 alpha:1.000];
    self.txtAutoCompletePlace.autoCompleteFontSize = 16;
    self.txtAutoCompletePlace.autoCompleteTableBorderWidth = 1.0;
    self.txtAutoCompletePlace.autoCompleteTableBorderColor = [DbUtils colorWithHexString:@"#e0e0e0"]; //[UIColor colorWithWhite:0.131 alpha:0.8];
    self.txtAutoCompletePlace.showTextFieldDropShadowWhenAutoCompleteTableIsOpen = YES;
    self.txtAutoCompletePlace.autoCompleteShouldHideOnSelection = YES;
    
    //self.autoCompleteTableView;
//    self.txtAutoCompletePlace.autoCompleteKeyboardDismissModeOnDrag = YES;
    //self.txtAutoCompletePlace.autoCompleteShouldHideClosingKeyboard = NO;
    self.txtAutoCompletePlace.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    // -- headerView --
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRect){0, 0, 320, 50}];
    headerView.backgroundColor = [UIColor lightGrayColor];
    UIButton *btnHeader = [[UIButton alloc] initWithFrame:(CGRect){10, 10, 300, 30}];
    btnHeader.tag = 1;
    [btnHeader setTitle:@"Header Click Me!" forState:UIControlStateNormal];
    [btnHeader setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnHeader.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // add targets and actions
    [btnHeader addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnHeader];
    self.txtAutoCompletePlace.headerView = headerView;

    // -- footerView --
    UIView *footerView = [[UIView alloc] initWithFrame:(CGRect){0, 0, 320, 50}];
    footerView.backgroundColor = [UIColor lightGrayColor];
    UIButton *btnFooter = [[UIButton alloc] initWithFrame:(CGRect){10, 10, 300, 30}];
    btnFooter.tag = 2;
    [btnFooter setTitle:@"Footer Click Me!" forState:UIControlStateNormal];
    [btnFooter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnFooter.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    // add targets and actions
    [btnFooter addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnFooter];
    self.txtAutoCompletePlace.footerView = footerView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    // -- Conflicts with txtAutoCompletePlace when you choose row --
//    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
    
    CGRect tableFrame = (CGRect){
        self.txtAutoCompletePlace.left,
        self.vwAddress.bottom + 5,
        self.txtAutoCompletePlace.width,
        (5 * self.txtAutoCompletePlace.autoCompleteRowHeight) + 50 + 50
        // chieu cao chi cho hien 5 + header + footer height
    };
     NSLog(@"tableFrame = %@", NSStringFromCGRect(tableFrame));
    self.txtAutoCompletePlace.autoCompleteTableFrame = tableFrame;
    //self.txtAutoCompletePlace.delegate = self;
}

- (IBAction)buttonClicked:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);
    // [self.txtAutoCompletePlace closeAutoCompleteTableView];
    [self.txtAutoCompletePlace resignFirstResponder];
}

- (IBAction)btnSearch_Click:(id)sender
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(10.794369, 106.680117);
    
    DbPlaceSearchViewController *vcl = [[DbPlaceSearchViewController alloc] init];
    vcl.apiKey = @"AIzaSyBK_MVp9sT3n-klZ4BIMnKHi1cjHJyYNFA";
    vcl.currentLocation = location;
    vcl.didReturnPlace = ^(DbPlaceSearchViewController *owner, GooglePlaceDetail *place) {
        NSLog(@"Tra ve = %@", place.formattedAddress);
    };
//    [vcl addSubViewPlaceSearch];
    
    [self.navigationController pushViewController:vcl animated:YES];
}

- (IBAction)btnGMSAutocomplete_Click:(id)sender
{
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    
//    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(10.794369, 106.680117);
//    
//    DbPlaceSearchViewController *vcl = [[DbPlaceSearchViewController alloc] init];
//    vcl.apiKey = @"AIzaSyBK_MVp9sT3n-klZ4BIMnKHi1cjHJyYNFA";
//    vcl.currentLocation = location;
//    vcl.didReturnPlace = ^(DbPlaceSearchViewController *owner, GooglePlaceDetail *place) {
//        NSLog(@"Tra ve = %@", place.formattedAddress);
//    };
//    //    [vcl addSubViewPlaceSearch];
//    
//    [self.navigationController pushViewController:vcl animated:YES];
}



#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict
{
    [self.view endEditing:YES];
    NSLog(@"SELECTED ADDRESS :%@",responseDict);
    NSLog(@"%@", responseDict.formattedAddress);
    
//    // -- Remove old marker, move to new marker --
//    currentLocation = responseDict.coordinate;
//    [self loadNewMarkerAndMoveTo:currentLocation];
//
    self.txtAutoCompletePlace.text = responseDict.formattedAddress;
//
//    // -- Save to user session --
//    //    self.userSession.address = responseDict.formattedAddress;
//    //    self.userSession.latitude = responseDict.coordinate.latitude;
//    //    self.userSession.longitude = responseDict.coordinate.longitude;
//
//    self.userSession.lastedAddress = responseDict.formattedAddress;
//    self.userSession.lastedLatitude = responseDict.coordinate.latitude;
//    self.userSession.lastedLongitude = responseDict.coordinate.longitude;
//    [self convertAddress];
//
//    // -- Show UpdateAddress View --
//    [self showUpdateAddressView];
}

- (void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField { }

- (void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField { }

- (BOOL)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(SuggestionAddressItemTableViewCell*)cell
    withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index
{
    // NSLog(@"%@", [placeObject.userInfo description]);
    NSString *address = [placeObject.userInfo objectForKey:@"description"];
    NSLog(@"address = %@", address);
    
    NSMutableArray *arrString = [[address componentsSeparatedByString:@","] mutableCopy];
    cell.lblMainAddress.text = [arrString firstObject];
    [arrString removeObjectAtIndex:0];
    cell.lblSubAddress.text = [DbUtils trimText:[arrString componentsJoinedByString:@", "]];
    
    return NO;
    
//    if(index % 2 == 0){
//        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
//    }else{
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//    }
//    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text
//{
//    if (![text length] && range.length && range.length != 1) {
//        return NO;
//    }
//    return YES;
//}

// Handle the user's selection.
#pragma mark GMSAutocompleteViewControllerDelegate
#pragma mark -

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


@end
