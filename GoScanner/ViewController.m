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
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    currentTileNum = -1;
    
    pokedex = @[@"Bulbasaur:1",@"Ivysaur:2",@"Venusaur:3",@"Charmander:4",@"Charmeleon:5",@"Charizard:6",@"Squirtle:7",@"Wartortle:8",@"Blastoise:9",@"Caterpie:10",@"Metapod:11",@"Butterfree:12",@"Weedle:13",@"Kakuna:14",@"Beedrill:15",@"Pidgey:16",@"Pidgeotto:17",@"Pidgeot:18",@"Rattata:19",@"Raticate:20",@"Spearow:21",@"Fearow:22",@"Ekans:23",@"Arbok:24",@"Pikachu:25",@"Raichu:26",@"Sandshrew:27",@"Sandslash:28",@"Nidoran♀:29",@"Nidorina:30",@"Nidoqueen:31",@"Nidoran♂:32",@"Nidorino:33",@"Nidoking:34",@"Clefairy:35",@"Clefable:36",@"Vulpix:37",@"Ninetales:38",@"Jigglypuff:39",@"Wigglytuff:40",@"Zubat:41",@"Golbat:42",@"Oddish:43",@"Gloom:44",@"Vileplume:45",@"Paras:46",@"Parasect:47",@"Venonat:48",@"Venomoth:49",@"Diglett:50",@"Dugtrio:51",@"Meowth:52",@"Persian:53",@"Psyduck:54",@"Golduck:55",@"Mankey:56",@"Primeape:57",@"Growlithe:58",@"Arcanine:59",@"Poliwag:60",@"Poliwhirl:61",@"Poliwrath:62",@"Abra:63",@"Kadabra:64",@"Alakazam:65",@"Machop:66",@"Machoke:67",@"Machamp:68",@"Bellsprout:69",@"Weepinbell:70",@"Victreebel:71",@"Tentacool:72",@"Tentacruel:73",@"Geodude:74",@"Graveler:75",@"Golem:76",@"Ponyta:77",@"Rapidash:78",@"Slowpoke:79",@"Slowbro:80",@"Magnemite:81",@"Magneton:82",@"Farfetch'd:83",@"Doduo:84",@"Dodrio:85",@"Seel:86",@"Dewgong:87",@"Grimer:88",@"Muk:89",@"Shellder:90",@"Cloyster:91",@"Gastly:92",@"Haunter:93",@"Gengar:94",@"Onix:95",@"Drowzee:96",@"Hypno:97",@"Krabby:98",@"Kingler:99",@"Voltorb:100",@"Electrode:101",@"Exeggcute:102",@"Exeggutor:103",@"Cubone:104",@"Marowak:105",@"Hitmonlee:106",@"Hitmonchan:107",@"Lickitung:108",@"Koffing:109",@"Weezing:110",@"Rhyhorn:111",@"Rhydon:112",@"Chansey:113",@"Tangela:114",@"Kangaskhan:115",@"Horsea:116",@"Seadra:117",@"Goldeen:118",@"Seaking:119",@"Staryu:120",@"Starmie:121",@"Mr.",@"Mime:122",@"Scyther:123",@"Jynx:124",@"Electabuzz:125",@"Magmar:126",@"Pinsir:127",@"Tauros:128",@"Magikarp:129",@"Gyarados:130",@"Lapras:131",@"Ditto:132",@"Eevee:133",@"Vaporeon:134",@"Jolteon:135",@"Flareon:136",@"Porygon:137",@"Omanyte:138",@"Omastar:139",@"Kabuto:140",@"Kabutops:141",@"Aerodactyl:142",@"Snorlax:143",@"Articuno:144",@"Zapdos:145",@"Moltres:146",@"Dratini:147",@"Dragonair:148",@"Dragonite:149",@"Mewtwo:150",@"Mew:151"];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self startLocationManager];
    
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
    [self runTiles];


}

- (void) runTiles {
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
    NSString *post = [NSString stringWithFormat:@"userHash=%@&pwHash=%@&longitude=%@&latitude=%@&altitude=%@&radius=1.0&tileNum=%d",[defaults objectForKey:@"username"],[defaults objectForKey:@"password"],[defaults objectForKey:@"longitude"],[defaults objectForKey:@"latitude"],[defaults objectForKey:@"altitude"], currentTileNum];
    currentTileNum++;
    if (currentTileNum > 20) [timer invalidate];
    
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
    }
    [self parseData:data];
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
