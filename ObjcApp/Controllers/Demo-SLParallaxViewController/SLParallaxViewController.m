//
//  SLParallaxViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/12/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "SLParallaxViewController.h"

#define SCREEN_HEIGHT_WITHOUT_STATUS_BAR     [[UIScreen mainScreen] bounds].size.height - 20
//#define SCREEN_WIDTH                         [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_STATUS_BAR                    20
#define Y_DOWN_TABLEVIEW                     SCREEN_HEIGHT_WITHOUT_STATUS_BAR - 35
#define DEFAULT_HEIGHT_HEADER                200.0f
#define MIN_HEIGHT_HEADER                    10.0f
#define DEFAULT_Y_OFFSET                     ([[UIScreen mainScreen] bounds].size.height == 480.0f) ? -200.0f : -250.0f
#define FULL_Y_OFFSET                        -200.0f
#define MIN_Y_OFFSET_TO_REACH                -100 // -50
#define OPEN_SHUTTER_LATITUDE_MINUS          .005
#define CLOSE_SHUTTER_LATITUDE_MINUS         .018


@interface SLParallaxViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic)   UITapGestureRecognizer  *tapMapViewGesture;
@property (strong, nonatomic)   UITapGestureRecognizer  *tapTableViewGesture;
@property (nonatomic)           CGRect                  headerFrame;
@property (nonatomic)           float                   headerYOffSet;
@property (nonatomic)           BOOL                    isShutterOpen;
@property (nonatomic)           BOOL                    displayMap;
@property (nonatomic)           float                   heightMap;

@property (nonatomic, strong)   UIImageView             *imgStaticPin;
@property (nonatomic, strong)   UIButton                *cmdCurrentLocation;

@end

@implementation SLParallaxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    
    [self setupTableView];
    [self setupMapView];
    
    
    // Allow UITableView under UINavigationBar
    // [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
//    UIEdgeInsets contentInset = self.tblContent.contentInset;
//    if (self.navigationController) {
//        contentInset.top = 64;
//    }
//    self.tableView.contentInset = contentInset;
}

// Set all view we will need
- (void)setup
{
    self.heighTableViewHeader       = DEFAULT_HEIGHT_HEADER;
    self.heighTableView             = SCREEN_HEIGHT_WITHOUT_STATUS_BAR;
    self.minHeighTableViewHeader    = MIN_HEIGHT_HEADER;
    self.default_Y_tableView        = HEIGHT_STATUS_BAR;
    self.Y_tableViewOnBottom        = Y_DOWN_TABLEVIEW;
    self.minYOffsetToReach          = MIN_Y_OFFSET_TO_REACH;
    self.latitudeUserUp             = CLOSE_SHUTTER_LATITUDE_MINUS;
    self.latitudeUserDown           = OPEN_SHUTTER_LATITUDE_MINUS;
    self.default_Y_mapView          = DEFAULT_Y_OFFSET;
    self.headerYOffSet              = DEFAULT_Y_OFFSET;
    self.heightMap                  = 1000.0f;
    self.regionAnimated             = YES;
    self.userLocationUpdateAnimated = YES;
}

- (void)setupTableView
{
    self.tableView                  = [[UITableView alloc]  initWithFrame: CGRectMake(0, 20, SCREEN_WIDTH, self.heighTableView)];
    self.tableView.tableHeaderView  = [[UIView alloc]       initWithFrame: CGRectMake(0.0, 0.0, self.view.frame.size.width, self.heighTableViewHeader)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    // Add gesture to gestures
    self.tapMapViewGesture      = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleTapMapView:)];
    self.tapTableViewGesture    = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleTapTableView:)];
    self.tapTableViewGesture.delegate = self;
    [self.tableView.tableHeaderView addGestureRecognizer:self.tapMapViewGesture];
    [self.tableView addGestureRecognizer:self.tapTableViewGesture];
    
    // Init selt as default tableview's delegate & datasource
    self.tableView.dataSource   = self;
    self.tableView.delegate     = self;
    [self.view addSubview:self.tableView];
}

- (void)setupMapView
{
    GMSCameraPosition *newCameraPosition = [GMSCameraPosition cameraWithTarget:PROPZY_LOCATION
                                                                          zoom:15];
    self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                     camera:newCameraPosition];
    
    self.mapView.center = self.tableView.tableHeaderView.center;
    self.mapView.centerY += 20;
    
    self.mapView.delegate = self;
    [self.view insertSubview:self.mapView
                belowSubview: self.tableView];
    
    self.imgStaticPin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_pin_local"]];
    self.imgStaticPin.center = self.mapView.center;

    [self.view insertSubview:self.imgStaticPin
                aboveSubview:self.mapView];
    
    self.cmdCurrentLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cmdCurrentLocation.alpha = 0;
    [self.cmdCurrentLocation setFrame:CGRectMake(0, 0, 75, 75)];
    // self.cmdCurrentLocation.center = CGPointMake(self.mapView.width - 100, self.mapView.height - 100);
    self.cmdCurrentLocation.center = CGPointMake(self.tableView.tableHeaderView.width - 50,
                                                 self.tableView.tableHeaderView.height - 40);
    [self.cmdCurrentLocation setBackgroundImage:[UIImage imageNamed:@"ic_location"] forState:UIControlStateNormal];
    // self.cmdCurrentLocation.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    // add targets and actions
    [self.cmdCurrentLocation addTarget:self action:@selector(btnCurrentLocation_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.cmdCurrentLocation];
    [self.view bringSubviewToFront:self.cmdCurrentLocation];

//    [self.view insertSubview:self.cmdCurrentLocation
//                aboveSubview:self.mapView];
}

#pragma mark - Internal Methods

- (void)handleTapMapView:(UIGestureRecognizer *)gesture {
    if(!self.isShutterOpen){
        // Move the tableView down to let the map appear entirely
        [self openShutter];
        // Inform the delegate
        if([self.delegate respondsToSelector:@selector(didTapOnMapView)]){
            [self.delegate didTapOnMapView];
        }
    }
}

- (void)handleTapTableView:(UIGestureRecognizer *)gesture {
    if(self.isShutterOpen){
        // Move the tableView up to reach is origin position
        [self closeShutter];
        // Inform the delegate
        if([self.delegate respondsToSelector:@selector(didTapOnTableView)]){
            [self.delegate didTapOnTableView];
        }
    }
}

// Move DOWN the tableView to show the "entire" mapView
- (void)openShutter
{
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.tableView.tableHeaderView     = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.frame.size.width, self.minHeighTableViewHeader)];
//                         self.mapView.frame                 = CGRectMake(0, FULL_Y_OFFSET, self.mapView.frame.size.width, self.heightMap);
//                         NSLog(@"self.mapView.frame = %@", NSStringFromCGRect(self.mapView.frame));
                         
                         self.tableView.frame               = CGRectMake(0, self.Y_tableViewOnBottom, self.tableView.frame.size.width, self.tableView.frame.size.height);
//                         NSLog(@"self.tableView.frame = %@", NSStringFromCGRect(self.tableView.frame));
                         
                         self.mapView.centerX = self.tableView.frame.size.width/2;
                         self.mapView.centerY = self.Y_tableViewOnBottom/2 + 20;
                         
                         self.imgStaticPin.center = self.mapView.center;
                         self.cmdCurrentLocation.alpha = 1.0;
                         self.cmdCurrentLocation.center = CGPointMake(self.tableView.tableHeaderView.width - 50,
                                                                      self.Y_tableViewOnBottom - 40);
                     }
                     completion:^(BOOL finished){
                         // Disable cells selection
                         [self.tableView setAllowsSelection:NO];
                         self.isShutterOpen = YES;
                         [self.tableView setScrollEnabled:NO];
                         // Center the user 's location
//                         [self zoomToUserLocation:self.mapView.userLocation
//                                      minLatitude:self.latitudeUserDown
//                                         animated:self.regionAnimated];
                         
                         // Inform the delegate
                         if([self.delegate respondsToSelector:@selector(didTableViewMoveDown)]){
                             [self.delegate didTableViewMoveDown];
                         }
                     }];
}

// Move UP the tableView to get its original position
- (void)closeShutter
{
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
//                         self.mapView.frame             = CGRectMake(0, self.default_Y_mapView, self.mapView.frame.size.width, self.heighTableView);
                         self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.headerYOffSet, self.view.frame.size.width, self.heighTableViewHeader)];
                         
                         self.mapView.center = self.tableView.tableHeaderView.center;
                         self.mapView.centerY += 20;
                         
                         self.tableView.frame = CGRectMake(0, self.default_Y_tableView, self.tableView.frame.size.width, self.tableView.frame.size.height);
                         
                         self.imgStaticPin.center = self.mapView.center;
                         self.cmdCurrentLocation.alpha = 0.0;
                         self.cmdCurrentLocation.center = CGPointMake(self.tableView.tableHeaderView.width - 50,
                                                                      self.tableView.tableHeaderView.height - 40);
                     }
                     completion:^(BOOL finished){
                         // Enable cells selection
                         [self.tableView setAllowsSelection:YES];
                         self.isShutterOpen = NO;
                         [self.tableView setScrollEnabled:YES];
                         [self.tableView.tableHeaderView addGestureRecognizer:self.tapMapViewGesture];
                         // Center the user 's location
//                         [self zoomToUserLocation:self.mapView.userLocation
//                                      minLatitude:self.latitudeUserUp
//                                         animated:self.regionAnimated];
                         
                         // Inform the delegate
                         if([self.delegate respondsToSelector:@selector(didTableViewMoveUp)]){
                             [self.delegate didTableViewMoveUp];
                         }
                     }];
}

#pragma mark -
#pragma mark GMSMapViewDelegate
#pragma mark -

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    return NO;
}

-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    // -- Tam khong su dung --
    //    if (processScheduleGetAddress) {
    //        [processScheduleGetAddress invalidate];
    //        processScheduleGetAddress = nil;
    //    }
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position
{
    NSLog(@"[position description] = %@", [position description]);
    
    // -- Khi di chuyen pin, thay doi vi tri he thong --
    //    self.userSession.latitude = position.target.latitude;
    //    self.userSession.longitude = position.target.longitude;
    
    // -- DucBui : 05/08 --
//    self.userSession.lastedLatitude = position.target.latitude;
//    self.userSession.lastedLongitude = position.target.longitude;
    
    //    if ([DbUtils stringEmpty:self.userSession.lastedAddress]) {
    //        [self getAddress];
    //    }
}

- (IBAction)btnCurrentLocation_Click:(UIButton *)sender
{
    // -- Show UpdateAddress View --
//    [self showUpdateAddressView];
    
    //    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    //    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse timeout:10.0
    //                                         block:^(CLLocation *location, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
    //                                             currentLocation = CLLocationCoordinate2DMake(location.coordinate.latitude ,location.coordinate.longitude);
    //                                             self.userSession.latitude = location.coordinate.latitude;
    //                                             self.userSession.longitude = location.coordinate.longitude;
    //
    //                                             [self loadNewMarkerAndMoveTo:currentLocation];
    //                                             [self getAddress];
    //                                         }];
    
    // -- Lay lai dia chi ban dau --
//    currentLocation = CLLocationCoordinate2DMake(self.userSession.latitude ,self.userSession.longitude);
    
//    [self loadNewMarkerAndMoveTo:currentLocation];
//    [self getAddress];
    
    NSLog(@"%@", @"btnCurrentLocation_Click");
    
    GMSCameraPosition *newCameraPosition = [GMSCameraPosition cameraWithTarget:PROPZY_LOCATION
                                                                          zoom:self.mapView.camera.zoom];
    [self.mapView animateToCameraPosition:newCameraPosition];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == self.tapTableViewGesture) {
        return _isShutterOpen;
    }
    return YES;
}

#pragma mark - Table view Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset > 0) {  // Scrolling Up -> normal behavior
        return;
    }
   
    // -- Animation option 1 : con loi, phai xu ly them --
//    self.mapView.centerY = (self.tableView.tableHeaderView.centerY+20) - ((scrollOffset / 2));
//    self.imgStaticPin.center = self.mapView.center;

    // -- Animation option 2 : scale --
    // this is just a demo method on how to compute the scale factor based on the current contentOffset
    float scale = 1.0f + fabs(scrollView.contentOffset.y)  / scrollView.frame.size.height;
    //Cap the scaling between zero and 1
    scale = MAX(0.0f, scale);
    // Set the scale to the imageView
    self.mapView.transform = CGAffineTransformMakeScale(scale, scale);
    
    // check if the Y offset is under the minus Y to reach
    if (self.tableView.contentOffset.y < self.minYOffsetToReach) {
        if(!self.displayMap)
            self.displayMap = YES;
    } else {
        if(self.displayMap)
            self.displayMap = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.displayMap)
        [self openShutter];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier;
    if(indexPath.row == 0){
        identifier = @"firstCell";
        // Add some shadow to the first cell
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:identifier];
            
            CGRect cellBounds       = cell.layer.bounds;
            CGRect shadowFrame      = CGRectMake(cellBounds.origin.x, cellBounds.origin.y, tableView.frame.size.width, 10.0);
            CGPathRef shadowPath    = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
            cell.layer.shadowPath   = shadowPath;
            [cell.layer setShadowOffset:CGSizeMake(-2, -2)];
            [cell.layer setShadowColor:[[UIColor grayColor] CGColor]];
            [cell.layer setShadowOpacity:.75];
        }
    }
    else{
        identifier = @"otherCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:identifier];
    }
    [[cell textLabel] setText:[NSString stringWithFormat:@"Hello World ! - %ld", indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //first get total rows in that section by current indexPath.
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
    
    //this is the last row in section.
    if(indexPath.row == totalRow -1){
        // get total of cells's Height
        float cellsHeight = totalRow * cell.frame.size.height;
        // calculate tableView's Height with it's the header
        float tableHeight = (tableView.frame.size.height - tableView.tableHeaderView.frame.size.height);
        
        // Check if we need to create a foot to hide the backView (the map)
        if((cellsHeight - tableView.frame.origin.y)  < tableHeight){
            // Add a footer to hide the background
            int footerHeight = tableHeight - cellsHeight;
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footerHeight)];
            [tableView.tableFooterView setBackgroundColor:[UIColor whiteColor]];
        }
    }
}



@end
