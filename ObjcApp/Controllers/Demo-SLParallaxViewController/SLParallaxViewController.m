//
//  SLParallaxViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/12/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "SLParallaxViewController.h"

#define SCREEN_HEIGHT_WITHOUT_STATUS_BAR     [[UIScreen mainScreen] bounds].size.height - 20
#define SCREEN_WIDTH                         [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_STATUS_BAR                    20
#define Y_DOWN_TABLEVIEW                     SCREEN_HEIGHT_WITHOUT_STATUS_BAR - 40
#define DEFAULT_HEIGHT_HEADER                100.0f
#define MIN_HEIGHT_HEADER                    10.0f
#define DEFAULT_Y_OFFSET                     ([[UIScreen mainScreen] bounds].size.height == 480.0f) ? -200.0f : -250.0f
#define FULL_Y_OFFSET                        -200.0f
#define MIN_Y_OFFSET_TO_REACH                -30
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

@end

@implementation SLParallaxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    
    [self setupTableView];
    [self setupMapView];
}

// Set all view we will need
- (void)setup
{
    _heighTableViewHeader       = DEFAULT_HEIGHT_HEADER;
    _heighTableView             = SCREEN_HEIGHT_WITHOUT_STATUS_BAR;
    _minHeighTableViewHeader    = MIN_HEIGHT_HEADER;
    _default_Y_tableView        = HEIGHT_STATUS_BAR;
    _Y_tableViewOnBottom        = Y_DOWN_TABLEVIEW;
    _minYOffsetToReach          = MIN_Y_OFFSET_TO_REACH;
    _latitudeUserUp             = CLOSE_SHUTTER_LATITUDE_MINUS;
    _latitudeUserDown           = OPEN_SHUTTER_LATITUDE_MINUS;
    _default_Y_mapView          = DEFAULT_Y_OFFSET;
    _headerYOffSet              = DEFAULT_Y_OFFSET;
    _heightMap                  = 1000.0f;
    _regionAnimated             = YES;
    _userLocationUpdateAnimated = YES;
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
    GMSCameraPosition *newCameraPosition = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(10.764261, 106.656312)
                                                                          zoom:15];
    self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, self.default_Y_mapView, SCREEN_WIDTH, self.heighTableView)
                                     camera:newCameraPosition];
//    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate = self;
    [self.view insertSubview:self.mapView
                belowSubview: self.tableView];
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
                         self.mapView.frame                 = CGRectMake(0, FULL_Y_OFFSET, self.mapView.frame.size.width, self.heightMap);
                         self.tableView.frame               = CGRectMake(0, self.Y_tableViewOnBottom, self.tableView.frame.size.width, self.tableView.frame.size.height);
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
                         self.mapView.frame             = CGRectMake(0, self.default_Y_mapView, self.mapView.frame.size.width, self.heighTableView);
                         self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.headerYOffSet, self.view.frame.size.width, self.heighTableViewHeader)];
                         self.tableView.frame           = CGRectMake(0, self.default_Y_tableView, self.tableView.frame.size.width, self.tableView.frame.size.height);
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

#pragma mark - MapView Delegate

- (void)zoomToUserLocation:(MKUserLocation *)userLocation minLatitude:(float)minLatitude animated:(BOOL)anim
{
    if (!userLocation)
        return;
    
    
    
    
//    MKCoordinateRegion region;
//    CLLocationCoordinate2D loc  = userLocation.location.coordinate;
//    loc.latitude                = loc.latitude - minLatitude;
//    region.center               = loc;
//    region.span                 = MKCoordinateSpanMake(.05, .05);       //Zoom distance
//    region                      = [self.mapView regionThatFits:region];
//    [self.mapView setRegion:region
//                   animated:anim];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(_isShutterOpen)
        [self zoomToUserLocation:self.mapView.userLocation
                     minLatitude:self.latitudeUserDown
                        animated:self.userLocationUpdateAnimated];
    else
        [self zoomToUserLocation:self.mapView.userLocation
                     minLatitude:self.latitudeUserUp
                        animated:self.userLocationUpdateAnimated];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == self.tapTableViewGesture) {
        return _isShutterOpen;
    }
    return YES;
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
    [[cell textLabel] setText:@"Hello World !"];
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
