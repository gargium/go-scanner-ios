//
//  ViewController.h
//  GoScanner
//
//  Created by Gargium on 7/17/16.
//  Copyright © 2016 Gargium. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import MapKit;

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, NSURLConnectionDelegate, UIGestureRecognizerDelegate> {
    
}
@property (strong, nonatomic) NSString *accessToken;
@property CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

