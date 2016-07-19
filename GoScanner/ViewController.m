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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//    [self.mapView setCenter:[_mapView.userLocation.coordinate animated:YES];
    
//    MKCoordinateSpan span = MKCoordinateSpanMake(30.5982f,0.0001f);
//    CLLocationCoordinate2D coordinate = {36, 90};
//    MKCoordinateRegion region = {coordinate, span};
//    MKCoordinateRegion regionThatFits = [self.mapView regionThatFits:region];
//    [self.mapView setRegion:regionThatFits animated:YES];
    

}
     
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion mapRegion ;
    mapRegion.center = _mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [_mapView setRegion:mapRegion animated: YES];
}


@end
