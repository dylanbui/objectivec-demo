//
//  DemoLocationViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 5/4/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DemoLocationViewController.h"
#import "DbLocationManager.h"
#import <GoogleMaps/GoogleMaps.h>

@interface DemoLocationViewController () // <DbLocationManagerDelegate> //use this if you want to get response from delegate not from block

@property(nonatomic, weak) IBOutlet UITextView *logTextView;
@property (nonatomic, strong) IBOutlet GMSMapView *vwMap;
@end

@implementation DemoLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //DbLocationManager *manager = [DbLocationManager sharedInstance];
    // manager.delegate = self; //not mandatory here, just to get the delegate calls
    
    self.vwMap.settings.rotateGestures = NO;
    self.vwMap.settings.allowScrollGesturesDuringRotateOrZoom = NO;
    self.vwMap.layer.cornerRadius = 6.0f;
    CLLocationCoordinate2D defaultPosition = CLLocationCoordinate2DMake(10.772154, 106.704367);
    GMSCameraPosition *newCameraPosition = [GMSCameraPosition cameraWithTarget:defaultPosition zoom:12];
    [self.vwMap animateToCameraPosition:newCameraPosition];
}


- (IBAction)getCurrentLocation:(id)sender
{
    DbLocationManager *manager = [DbLocationManager sharedInstance];
    [manager requestLocation:^(CLLocation *currentLocation, DbLocationAccuracy achievedAccuracy, DbLocationStatus status) {
        
//        DbLocationStatusServicesNotDetermined,
//        /** User has explicitly denied this app permission to access location services. */
//        DbLocationStatusServicesDenied,
//        /** User does not have ability to enable location services (e.g. parental controls, corporate policy, etc). */
//        DbLocationStatusServicesRestricted,
        
        NSLog(@"Location status = %ld", status);
//        if (! CLLocationCoordinate2DIsValid(currentLocation.coordinate)) {
//
//        }
        
        if (_isValidLocationCoordinate2D(currentLocation.coordinate)) {
            // -- luon luon chay --
            NSLog(@"%@", @" Hang ngon xai di");

        } else {
            NSLog(@"%@", @"Location la [EMPTY] , ko xai duoc");
        }
        
//        DbLocationStatusServicesDenied,
//        /** User does not have ability to enable location services (e.g. parental controls, corporate policy, etc). */
//        DbLocationStatusServicesRestricted,
//        /** User has turned off location services device-wide (for all apps) from the system Settings app. */
//        DbLocationStatusServicesDisabled,
        
        // Khi khong cho phep DbLocationStatus == DbLocationStatusServicesDenied
        // Khi tat location DbLocationStatus == DbLocationStatusServicesDisabled
        
        if (status == DbLocationStatusServicesNotDetermined
            || status == DbLocationStatusServicesDenied
            || status == DbLocationStatusServicesRestricted) {
            [DbUtils showAlertMessage1ButtonWithController:self title:@"Thong bao" message:@"Khong co location"
                                               buttonTitle:@"OK" tapBlock:nil];
            return;
        }
        
        [self logtext:[NSString stringWithFormat:@"Current Location: %@", currentLocation.description]];
        [self showInMapsWithDictionary:currentLocation title:@"Current Location"];
    }];

//    [manager getCurrentLocationWithCompletion:^(BOOL success, NSDictionary *latLongAltitudeDictionary, NSError *error) {
//        [self logtext:[NSString stringWithFormat:@"Current Location: %@", latLongAltitudeDictionary.description]];
//        [self showInMapsWithDictionary:latLongAltitudeDictionary title:@"Current Location"];
//    }];
    //[manager getCurrentLocationWithDelegate:self]; //can be used
}


- (IBAction)getContiniousLocation:(id)sender
{
//    DbLocationManager *manager = [DbLocationManager sharedManager];
//    [manager getContiniousLocationWithDelegate:self];
}

- (IBAction)getSignificantLocationChange:(id)sender
{
//    DbLocationManager *manager = [DbLocationManager sharedManager];
//    [manager getSingificantLocationChangeWithDelegate:self];
}

- (IBAction)stopGettingLocation
{
//    DbLocationManager *manager = [DbLocationManager sharedManager];
//    [manager stopGettingLocation];
}

- (void)showInMapsWithDictionary:(CLLocation*)currentLocation title:(NSString*)title
{
    GMSCameraPosition *newCameraPosition = [GMSCameraPosition cameraWithTarget:currentLocation.coordinate zoom:15];
    [self.vwMap animateToCameraPosition:newCameraPosition];
    
    [self.vwMap clear];
    GMSMarker *endMarker = [[GMSMarker alloc] init];
    endMarker.position = currentLocation.coordinate;
    endMarker.title = title;
    endMarker.map = self.vwMap;
}

- (void)logtext:(NSString*)text
{
    self.logTextView.text = text;
}

#pragma mark-  Other methods

-(void)showLocalNotification:(NSString*)notificationBody withDate:(NSDate*)notificationDate
{
    UIApplication *app                = [UIApplication sharedApplication];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate  = notificationDate;
    notification.timeZone  = [NSTimeZone defaultTimeZone];
    notification.alertBody = notificationBody;
    notification.soundName = UILocalNotificationDefaultSoundName;
    //notification.applicationIconBadgeNumber = badgeCount;
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    //[userInfo setValue:eventType forKey:@"event_type"];
    [notification setUserInfo:userInfo];
    [app scheduleLocalNotification:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

