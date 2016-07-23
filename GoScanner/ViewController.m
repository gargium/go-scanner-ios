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

@interface ViewController () {
    
    NSArray *pokedex;
    int currentTileNum;
    NSTimer *timer;
    UIActivityIndicatorView *spinner;
    UIBarButtonItem * scanButton;
    NSDictionary *rarityDex;
    int responseCounter;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    currentTileNum = -2;
    responseCounter = 0;
     pokedex = @[@"", @"Bulbasaur",@"Ivysaur",@"Venusaur",@"Charmander",@"Charmeleon",@"Charizard",@"Squirtle",@"Wartortle",@"Blastoise",@"Caterpie",@"Metapod",@"Butterfree",@"Weedle",@"Kakuna",@"Beedrill",@"Pidgey",@"Pidgeotto",@"Pidgeot",@"Rattata",@"Raticate",@"Spearow",@"Fearow",@"Ekans",@"Arbok",@"Pikachu",@"Raichu",@"Sandshrew",@"Sandslash",@"Nidoran♀",@"Nidorina",@"Nidoqueen",@"Nidoran♂",@"Nidorino",@"Nidoking",@"Clefairy",@"Clefable",@"Vulpix",@"Ninetales",@"Jigglypuff",@"Wigglytuff",@"Zubat",@"Golbat",@"Oddish",@"Gloom",@"Vileplume",@"Paras",@"Parasect",@"Venonat",@"Venomoth",@"Diglett",@"Dugtrio",@"Meowth",@"Persian",@"Psyduck",@"Golduck",@"Mankey",@"Primeape",@"Growlithe",@"Arcanine",@"Poliwag",@"Poliwhirl",@"Poliwrath",@"Abra",@"Kadabra",@"Alakazam",@"Machop",@"Machoke",@"Machamp",@"Bellsprout",@"Weepinbell",@"Victreebel",@"Tentacool",@"Tentacruel",@"Geodude",@"Graveler",@"Golem",@"Ponyta",@"Rapidash",@"Slowpoke",@"Slowbro",@"Magnemite",@"Magneton",@"Farfetch'd",@"Doduo",@"Dodrio",@"Seel",@"Dewgong",@"Grimer",@"Muk",@"Shellder",@"Cloyster",@"Gastly",@"Haunter",@"Gengar",@"Onix",@"Drowzee",@"Hypno",@"Krabby",@"Kingler",@"Voltorb",@"Electrode",@"Exeggcute",@"Exeggutor",@"Cubone",@"Marowak",@"Hitmonlee",@"Hitmonchan",@"Lickitung",@"Koffing",@"Weezing",@"Rhyhorn",@"Rhydon",@"Chansey",@"Tangela",@"Kangaskhan",@"Horsea",@"Seadra",@"Goldeen",@"Seaking",@"Staryu",@"Starmie",@"Mr. Mime",@"Scyther",@"Jynx",@"Electabuzz",@"Magmar",@"Pinsir",@"Tauros",@"Magikarp",@"Gyarados",@"Lapras",@"Ditto",@"Eevee",@"Vaporeon",@"Jolteon",@"Flareon",@"Porygon",@"Omanyte",@"Omastar",@"Kabuto",@"Kabutops",@"Aerodactyl",@"Snorlax",@"Articuno",@"Zapdos",@"Moltres",@"Dratini",@"Dragonair",@"Dragonite",@"Mewtwo",@"Mew"];
    
     rarityDex = [[NSDictionary alloc] initWithObjects:@[@(-1), @(2), @(4), @(4), @(2), @(3), @(4), @(2), @(4), @(4), @(0), @(1), @(3), @(0), @(1), @(3), @(0), @(2), @(3), @(0), @(1), @(0), @(2), @(0), @(2), @(2), @(4), @(1), @(3), @(1), @(2), @(4), @(1), @(2), @(4), @(2), @(4), @(2), @(4), @(2), @(4), @(0), @(1), @(1), @(2), @(4), @(1), @(3), @(1), @(3), @(1), @(3), @(2), @(4), @(2), @(4), @(2), @(4), @(2), @(4), @(2), @(3), @(4), @(2), @(3), @(4), @(2), @(3), @(4), @(2), @(3), @(4), @(1), @(3), @(2), @(3), @(4), @(2), @(4), @(2), @(4), @(2), @(4), @(5), @(1), @(3), @(2), @(3), @(2), @(4), @(2), @(4), @(2), @(3), @(4), @(4), @(2), @(4), @(1), @(3), @(2), @(4), @(2), @(4), @(2), @(4), @(3), @(3), @(4), @(1), @(3), @(2), @(3), @(4), @(2), @(3), @(1), @(3), @(1), @(3), @(1), @(3), @(4), @(4), @(4), @(3), @(3), @(3), @(3), @(1), @(4), @(4), @(5), @(2), @(4), @(4), @(4), @(4), @(4), @(4), @(4), @(4), @(4), @(4), @(4), @(4), @(4), @(3), @(4), @(4), @(5), @(5)] forKeys:@[@"", @"Bulbasaur",@"Ivysaur",@"Venusaur",@"Charmander",@"Charmeleon",@"Charizard",@"Squirtle",@"Wartortle",@"Blastoise",@"Caterpie",@"Metapod",@"Butterfree",@"Weedle",@"Kakuna",@"Beedrill",@"Pidgey",@"Pidgeotto",@"Pidgeot",@"Rattata",@"Raticate",@"Spearow",@"Fearow",@"Ekans",@"Arbok",@"Pikachu",@"Raichu",@"Sandshrew",@"Sandslash",@"Nidoran♀",@"Nidorina",@"Nidoqueen",@"Nidoran♂",@"Nidorino",@"Nidoking",@"Clefairy",@"Clefable",@"Vulpix",@"Ninetales",@"Jigglypuff",@"Wigglytuff",@"Zubat",@"Golbat",@"Oddish",@"Gloom",@"Vileplume",@"Paras",@"Parasect",@"Venonat",@"Venomoth",@"Diglett",@"Dugtrio",@"Meowth",@"Persian",@"Psyduck",@"Golduck",@"Mankey",@"Primeape",@"Growlithe",@"Arcanine",@"Poliwag",@"Poliwhirl",@"Poliwrath",@"Abra",@"Kadabra",@"Alakazam",@"Machop",@"Machoke",@"Machamp",@"Bellsprout",@"Weepinbell",@"Victreebel",@"Tentacool",@"Tentacruel",@"Geodude",@"Graveler",@"Golem",@"Ponyta",@"Rapidash",@"Slowpoke",@"Slowbro",@"Magnemite",@"Magneton",@"Farfetch'd",@"Doduo",@"Dodrio",@"Seel",@"Dewgong",@"Grimer",@"Muk",@"Shellder",@"Cloyster",@"Gastly",@"Haunter",@"Gengar",@"Onix",@"Drowzee",@"Hypno",@"Krabby",@"Kingler",@"Voltorb",@"Electrode",@"Exeggcute",@"Exeggutor",@"Cubone",@"Marowak",@"Hitmonlee",@"Hitmonchan",@"Lickitung",@"Koffing",@"Weezing",@"Rhyhorn",@"Rhydon",@"Chansey",@"Tangela",@"Kangaskhan",@"Horsea",@"Seadra",@"Goldeen",@"Seaking",@"Staryu",@"Starmie",@"Mr. Mime",@"Scyther",@"Jynx",@"Electabuzz",@"Magmar",@"Pinsir",@"Tauros",@"Magikarp",@"Gyarados",@"Lapras",@"Ditto",@"Eevee",@"Vaporeon",@"Jolteon",@"Flareon",@"Porygon",@"Omanyte",@"Omastar",@"Kabuto",@"Kabutops",@"Aerodactyl",@"Snorlax",@"Articuno",@"Zapdos",@"Moltres",@"Dratini",@"Dragonair",@"Dragonite",@"Mewtwo",@"Mew"]];
    // Do any additional setup after loading the view, typically from a nib.
    [self startLocationManager];
    
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    scanButton = [[UIBarButtonItem alloc] initWithTitle:@"Scan" style:UIBarButtonItemStylePlain target:self action:@selector(runTiles)];
    [self navigationItem].leftBarButtonItem = scanButton;

}

- (void) runTiles {
    [scanButton setTitle:@""];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    scanButton.customView = spinner;
    scanButton.enabled = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(postRequestFor)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void) postRequestFor{
    //POST request attempt lol
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    NSString *post = [NSString stringWithFormat:@"userHash=%@&pwHash=%@&longitude=%@&latitude=%@&altitude=%@&tile_1=%d&tile_2=%d",[defaults objectForKey:@"username"],[defaults objectForKey:@"password"],[defaults objectForKey:@"longitude"],[defaults objectForKey:@"latitude"],[defaults objectForKey:@"altitude"], currentTileNum+1, currentTileNum];
    currentTileNum += 2;
    if (currentTileNum > 19) {
        [timer invalidate];

    }
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://pogo-scanner-server.herokuapp.com/api/scan"]];
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

- (void) parseData:(NSData*)data {
    NSError *jsonParsingError = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
    
    NSNumber *responseCode = [dic objectForKey:@"code"];
    if (jsonParsingError) NSLog(@"%@", jsonParsingError);
    if (responseCode.integerValue == 300) {
        NSArray *report = [dic objectForKey:@"reports"];
        for (int i = 0; i < [report count]; i++) {
            NSDictionary *poke_report = [report objectAtIndex:i];
            NSNumber *poke_name = [poke_report objectForKey:@"name"];
            NSNumber *poke_lat = [poke_report objectForKey:@"lat"];
            NSNumber *poke_long = [poke_report objectForKey:@"long"];
            NSNumber *poke_duration = [poke_report objectForKey:@"duration"];
            if (poke_name) {
                NSLog(@"found a name %@", poke_name);
                NSLog(@"found a lat %@", poke_lat);
                NSLog(@"found a long %@", poke_long);
                NSLog(@"found a duration %@", poke_duration);
                [self drawMarkersForLat:poke_lat.doubleValue lon:poke_long.doubleValue title:[pokedex objectAtIndex:poke_name.integerValue]];
            }
        }
    } else {
        NSLog(@"Response Code: %@", responseCode);
    }

}


- (void) drawMarkersForLat:(double)lat lon:(double)lon title:(NSString*)title{
    NSUserDefaults *defaullts = [NSUserDefaults standardUserDefaults];
    [defaullts synchronize];
    NSString *search = [defaullts objectForKey:@"searchingFor"];
    if (search != nil) {
        if ([title isEqualToString:search]) {
            CLLocationCoordinate2D  ctrpoint;
            ctrpoint.latitude = lat;
            ctrpoint.longitude =lon;
            MKPointAnnotation *addAnnotation = [[MKPointAnnotation alloc] init];
            [addAnnotation setCoordinate:ctrpoint];
            [addAnnotation setTitle:title];
            [_mapView addAnnotation:addAnnotation];
            //add annotation to an array in order to remove before second scan is called
            NSLog(@"search completed");
            return;
        }
    }
    CLLocationCoordinate2D  ctrpoint;
    ctrpoint.latitude = lat;
    ctrpoint.longitude =lon;
    MKPointAnnotation *addAnnotation = [[MKPointAnnotation alloc] init];
    [addAnnotation setCoordinate:ctrpoint];
    [addAnnotation setTitle:title];
  
    [_mapView addAnnotation:addAnnotation];
    
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
    if (data) {
        NSLog(@"got data back: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        responseCounter++;
    }
    [self parseData:data];
    if (responseCounter > 19) {
        [spinner stopAnimating];
        scanButton.customView = nil;
        [scanButton setTitle:@"Scan"];
        [scanButton setEnabled:YES];
    }
    
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"got error back: %@", error);
    }
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationidentifier"];
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    } else if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKPointAnnotation *p_a = annotation;
        NSNumber *rarity = [rarityDex objectForKey:p_a.title];
        NSLog(@"Rarity: %@", rarity.stringValue);
        //add a subtitle to the annotation to tell user how rare it is
        switch (rarity.integerValue) {
            case 5:
            {
                pinView.pinTintColor = [UIColor blackColor];
                [p_a setSubtitle:@"Unfindable"];
                break;
            }
            case 4: {
                pinView.pinTintColor = [UIColor purpleColor];
                [p_a setSubtitle:@"Very Rare"];
                break;
            }
            case 3: {
                pinView.pinTintColor = [UIColor blueColor];
                [p_a setSubtitle:@"Rare"];
                break;
            }
            case 2: {
                pinView.pinTintColor = [UIColor greenColor];
                [p_a setSubtitle:@"Uncommon"];
                break;
            }
            case 1: {
                pinView.pinTintColor = [UIColor brownColor];
                [p_a setSubtitle:@"Common"];
                break;
            }
            default: {
                pinView.pinTintColor = [UIColor grayColor];
                [p_a setSubtitle:@"Very Common"];
            }
                break;
        }
        pinView.canShowCallout = YES;
    }
    return pinView;
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
    
- (IBAction)scanBtn:(id)sender {
}
@end
