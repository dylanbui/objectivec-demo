//
//  MapDrawingViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/3/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "MapDrawingViewController.h"
#import "CanvasView.h"
#import "CanvasImageView.h"

@interface MapDrawingViewController () {
    CLLocationCoordinate2D currentLocation;
}

@property (weak, nonatomic) IBOutlet GMSMapView *vwMap;

//@property (nonatomic, strong) NSMutableArray *coordinates;
//@property (nonatomic, strong) NSMutableArray *polygonPoints;
@property (weak, nonatomic) IBOutlet UIButton *drawPolygonButton;
@property (nonatomic) BOOL isDrawingPolygon;

@property (nonatomic, strong) CanvasView *canvasView;
@property (nonatomic, strong) CanvasImageView *canvasImageView;

@property (nonatomic, strong) GMSMutablePath *arrCoordinate;


@end

@implementation MapDrawingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.coordinates = [[NSMutableArray alloc] init];
    self.arrCoordinate = [GMSMutablePath path];
    
    //    self.canvasView.backgroundColor = [UIColor redColor];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    currentLocation = LOS_ANGELES_POINT; //CLLocationCoordinate2DMake(self.userSession.latitude ,self.userSession.longitude);
    
    GMSCameraPosition *newCameraPosition = [GMSCameraPosition cameraWithTarget:currentLocation
                                                                          zoom:15];
    // -- Create map if not exist --

    //self.vwMap = [GMSMapView mapWithFrame:(CGRect){0,0,self.view.frame.size} camera:newCameraPosition];
    
    [self.vwMap setCamera:newCameraPosition];
    [self.vwMap animateToCameraPosition:newCameraPosition];
    
//    self.canvasView = [[CanvasView alloc] initWithFrame:self.vwMap.frame];
//    self.canvasView.userInteractionEnabled = YES;
//    self.canvasView.delegate = self;
    
    self.canvasImageView = [[CanvasImageView alloc] initWithFrame:self.vwMap.frame];
    self.canvasImageView.userInteractionEnabled = YES;
    self.canvasImageView.delegate = self;
    
    
}

- (IBAction)didTouchUpInsideDrawButton:(UIButton*)sender
{
    if(self.isDrawingPolygon == NO) {
        
        // -- Xoa toan bo map bao gom ca marker --
        [self.vwMap clear];
        
        self.isDrawingPolygon = YES;
        [self.drawPolygonButton setTitle:@"Done" forState:UIControlStateNormal];
        [self.arrCoordinate removeAllCoordinates];
        
//        [self.view addSubview:self.canvasView];
//        [self.view bringSubviewToFront:self.canvasView];
        
        [self.view addSubview:self.canvasImageView];
        [self.view bringSubviewToFront:self.canvasImageView];
        
    } else {
        
        NSInteger numberOfPoints = [self.arrCoordinate count];
        
        if (numberOfPoints > 2)
        {
            GMSPolygon *polygon = [GMSPolygon polygonWithPath:self.arrCoordinate];
            polygon.fillColor = [UIColor colorWithRed:0.25 green:0 blue:0 alpha:0.05];
            polygon.strokeColor = [UIColor blackColor];
            polygon.strokeWidth = 2;
            polygon.map = self.vwMap;
            
            // -- Focus to map --
            [self focusMapToShowAllCoordinate:self.arrCoordinate];
        }
        
        self.isDrawingPolygon = NO;
        [self.drawPolygonButton setTitle:@"draw" forState:UIControlStateNormal];
//        self.canvasView.image = nil;
//        [self.canvasView removeFromSuperview];
        
        self.canvasImageView.image = nil;
        [self.canvasImageView removeFromSuperview];
        
    }
}

- (void)touchesBegan:(UITouch*)touch
{
    CGPoint location = [touch locationInView:self.vwMap];
    
    CGPoint mapViewPoint = [self.vwMap convertPoint:location toView:self.vwMap];
    CLLocationCoordinate2D coordinate = [self.vwMap.projection coordinateForPoint:mapViewPoint];
    [self.arrCoordinate addCoordinate:coordinate];
}

- (void)touchesMoved:(UITouch*)touch
{
    CGPoint location = [touch locationInView:self.vwMap];
    
    CGPoint mapViewPoint = [self.vwMap convertPoint:location toView:self.vwMap];
    CLLocationCoordinate2D coordinate = [self.vwMap.projection coordinateForPoint:mapViewPoint];
    [self.arrCoordinate addCoordinate:coordinate];
}

- (void)touchesEnded:(UITouch*)touch
{
    CGPoint location = [touch locationInView:self.vwMap];
    
    CGPoint mapViewPoint = [self.vwMap convertPoint:location toView:self.vwMap];
    CLLocationCoordinate2D coordinate = [self.vwMap.projection coordinateForPoint:mapViewPoint];
    [self.arrCoordinate addCoordinate:coordinate];
    
    // [self didTouchUpInsideDrawButton:nil];
}


- (void)focusMapToShowAllCoordinate:(GMSMutablePath *)mutablePath
{
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithPath:mutablePath];
    
    [self.vwMap animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
    
    GMSMutablePath *rectPath = [GMSMutablePath path];
    CLLocationCoordinate2D northEast = bounds.northEast;
    CLLocationCoordinate2D southWest = bounds.southWest;
    CLLocationCoordinate2D southEast = CLLocationCoordinate2DMake(southWest.latitude, northEast.longitude);
    CLLocationCoordinate2D northWest = CLLocationCoordinate2DMake(northEast.latitude, southWest.longitude);
    
    [rectPath addCoordinate:northWest]; // Tay Bac
    [rectPath addCoordinate:northEast]; // Dong Bac
    [rectPath addCoordinate:southEast]; // Dong Nam
    [rectPath addCoordinate:southWest]; // Tay Nam
    
    GMSPolygon *polygon = [GMSPolygon polygonWithPath:rectPath];
    polygon.fillColor = [UIColor colorWithRed:0.25 green:0 blue:0 alpha:0.05];
    polygon.strokeColor = [UIColor redColor];
    polygon.strokeWidth = 2;
    polygon.map = self.vwMap;
}

@end
