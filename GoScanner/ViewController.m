//
//  ViewController.m
//  GoScanner
//
//  Created by Gargium on 7/17/16.
//  Copyright © 2016 Gargium. All rights reserved.


//pogo-scanner-server.herokuapp.com/api/scan/post/
/*
 userHash:shivandyrak
 pwHash:degenerates
 longitude:-121.89
 latitude:37.34
 altitude:13.0
 radius:1.0
 tileNum:-1*/


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
    
    //POST request attempt lol
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    NSString *post = [NSString stringWithFormat:@"userHash:%@&pwHash:%@&longitude:%@&latitude:%@&altitude:%@",[defaults objectForKey:@"username"],[defaults objectForKey:@"password"],[defaults objectForKey:@"longitude"],[defaults objectForKey:@"latitude"],[defaults objectForKey:@"altitude"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"pogo-scanner-server.herokuapp.com/api/scan/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }


    


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
    _locationManager.distanceFilter = 1000.0; //whenever we move
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
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

//**************POST DATA METHODS********
//Delegate method to receive data from server
// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}


//***************LOCATION METHODS*******
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    NSLog(@"altitude: %f", newLocation.altitude);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults synchronize];
        [defaults setDouble:currentLocation.coordinate.latitude forKey:@"latitude"];
        [defaults setDouble:currentLocation.coordinate.longitude forKey:@"longitude"];
        [defaults setDouble:currentLocation.altitude forKey:@"altitude"];
    }
    else {
        NSLog(@"coord was null");
    }
}


@end
