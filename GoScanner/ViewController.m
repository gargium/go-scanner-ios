//
//  ViewController.m
//  GoScanner
//
//  Created by Gargium on 7/17/16.
//  Copyright © 2016 Gargium. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startLocationManager];
    
    _mapView.delegate = self;

    
    [self.view addSubview:_mapView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) buttonLog: (id) sender {
    NSLog(@"logged");
}
- (void)startLocationManager
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];

    self.mapView.showsUserLocation = YES;
    self.mapView.showsCompass = YES;
    self.mapView.showsBuildings = YES;
    [_locationManager startUpdatingLocation];


}
     
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion mapRegion ;
    mapRegion.center = _mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.01;
    mapRegion.span.longitudeDelta = 0.01;
    
    [_mapView setRegion:mapRegion animated: YES];
}


@end
