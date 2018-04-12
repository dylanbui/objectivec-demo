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
#import "DbPlaceSearchViewController.h"

@interface DemoTextSearchGGViewController ()

@end

@implementation DemoTextSearchGGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self navigationBarHiddenForThisController];
    
//    [_txtAutoCompletePlace setValue:[UIFont fontWithName:@"OpenSans-Italic" size:15] forKeyPath:@"_placeholderLabel.font"];
    
    // -- AutoCompletePlace Properties --
//    [self.txtAutoCompletePlace setValue:[UIFont fontWithName:@"OpenSans-Italic" size:15] forKeyPath:@"_placeholderLabel.font"];
    [self.txtAutoCompletePlace registerAutoCompleteCellClass:[AddressTableViewCell class] forCellReuseIdentifier:@"AddressTableViewCell"];
    [self.txtAutoCompletePlace registerAutoCompleteCellNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil]
                                    forCellReuseIdentifier:@"AddressTableViewCell"];
    
    self.txtAutoCompletePlace.placeSearchDelegate                 = self;
    self.txtAutoCompletePlace.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    self.txtAutoCompletePlace.autoCompleteShouldHideOnSelection   = YES;
    self.txtAutoCompletePlace.maximumNumberOfAutoCompleteRows     = 5;
    
//    self.txtAutoCompletePlace.autoCompleteRegularFontName =  @"OpenSans-Semibold";
//    self.txtAutoCompletePlace.autoCompleteBoldFontName = @"OpenSans";
    self.txtAutoCompletePlace.autoCompleteTableCornerRadius = 5.0;
    self.txtAutoCompletePlace.autoCompleteRowHeight = 50;
    self.txtAutoCompletePlace.autoCompleteTableCellTextColor = [UIColor colorWithWhite:0.131 alpha:1.000];
    self.txtAutoCompletePlace.autoCompleteFontSize = 16;
    self.txtAutoCompletePlace.autoCompleteTableBorderWidth = 1.0;
    self.txtAutoCompletePlace.autoCompleteTableBorderColor = [DbUtils colorWithHexString:@"#e0e0e0"]; //[UIColor colorWithWhite:0.131 alpha:0.8];
    self.txtAutoCompletePlace.showTextFieldDropShadowWhenAutoCompleteTableIsOpen = YES;
    self.txtAutoCompletePlace.autoCompleteShouldHideOnSelection = YES;
    self.txtAutoCompletePlace.autoCompleteShouldHideClosingKeyboard = YES;
    self.txtAutoCompletePlace.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    UIView *footerView = [[UIView alloc] initWithFrame:(CGRect){0, 0, 320, 50}];
    footerView.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:(CGRect){10, 10, 300, 30}];
    [btn setTitle:@"Click Me!" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // add targets and actions
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    
    self.txtAutoCompletePlace.footerView = footerView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // -- Conflicts with txtAutoCompletePlace when you choose row --
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
    
    CGRect tableFrame = (CGRect){
        17,
        self.txtAutoCompletePlace.bottom + 25,
        SCREEN_WIDTH - (17*2),
        (5 * 60) + 50
        //self.view.frame.size.height - (self.txtAutoCompletePlace.height + 10)
    };
     NSLog(@"tableFrame = %@", NSStringFromCGRect(tableFrame));
    self.txtAutoCompletePlace.autoCompleteTableFrame = tableFrame;
    //self.txtAutoCompletePlace.delegate = self;
}

- (IBAction)buttonClicked:(UIButton *)sender
{
    NSLog(@"%@", @"buttonClicked");
    [self.txtAutoCompletePlace closeAutoCompleteTableView];
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
//    self.txtAddress.text = responseDict.formattedAddress;
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

- (BOOL)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(AddressTableViewCell*)cell
    withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index
{
    // NSLog(@"%@", [placeObject.userInfo description]);
    NSString *address = [placeObject.userInfo objectForKey:@"description"];
    NSLog(@"address = %@", address);
    
    NSMutableArray *arrString = [[address componentsSeparatedByString:@","] mutableCopy];
    cell.lbl_1.text = [arrString firstObject];
    [arrString removeObjectAtIndex:0];
    cell.lbl_2.text = [DbUtils trimText:[arrString componentsJoinedByString:@", "]];

    [cell.img_1 setImage:[UIImage imageNamed:@"ic_pin_local"]];
    
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

@end
