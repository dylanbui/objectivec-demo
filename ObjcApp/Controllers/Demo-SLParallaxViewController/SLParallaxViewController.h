//
//  SLParallaxViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 12/12/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>
// #import <INTULocationManager/INTULocationManager.h>

@protocol SLParallaxViewControllerDelegate <NSObject>

// Tap handlers
-(void)didTapOnMapView;
-(void)didTapOnTableView;
// TableView's move
-(void)didTableViewMoveDown;
-(void)didTableViewMoveUp;

@end

@interface SLParallaxViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate>

@property (nonatomic, weak)     id<SLParallaxViewControllerDelegate>    delegate;
@property (nonatomic, strong)   UITableView                         *tableView;
//@property (nonatomic, strong)   MKMapView                           *mapView;
@property (nonatomic, strong)   GMSMapView                          *mapView;
@property (nonatomic)           float                               heighTableView;
@property (nonatomic)           float                               heighTableViewHeader;
@property (nonatomic)           float                               minHeighTableViewHeader;
@property (nonatomic)           float                               minYOffsetToReach;
@property (nonatomic)           float                               default_Y_mapView;
@property (nonatomic)           float                               default_Y_tableView;
@property (nonatomic)           float                               Y_tableViewOnBottom;
@property (nonatomic)           float                               latitudeUserUp;
@property (nonatomic)           float                               latitudeUserDown;
@property (nonatomic)           BOOL                                regionAnimated;
@property (nonatomic)           BOOL                                userLocationUpdateAnimated;

// Move the map in terms of user location
// @minLatitude : subtract to the current user's latitude to move it on Y axis in order to view it when the map move
- (void)zoomToUserLocation:(MKUserLocation *)userLocation minLatitude:(float)minLatitude animated:(BOOL)anim;

@end
