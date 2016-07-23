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
    UIView *onboarding;
    UILabel *welcome;
    UITextView *legend;
    UITextView *legendDesc;
    UITextView *done;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self showOnboarding];
    
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

- (void) showOnboarding {
    onboarding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [onboarding setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [onboarding setUserInteractionEnabled:YES];
    [self.navigationController.view addSubview:onboarding];
    NSLog(@"made subview");
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod)];
    tapped.delegate = self;
    tapped.numberOfTapsRequired = 1;
    [onboarding addGestureRecognizer:tapped];
    [self setUpOnboardingText];
}

- (void) setUpOnboardingText {
    
    //legend of rarity, red - very rare, blue - rare, green - uncommon, white - common, grey- very common
    //legend of hit "scan button" to start finding pokemon
    //prompt user to dismiss screen by tapping it.
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    float padding = 20.0;
    float effective_w = width - 2*padding;
    float yMargin = (.10 * height);
    
    welcome = [[UILabel alloc] initWithFrame:CGRectMake(padding, yMargin, effective_w, 20)];
    [welcome setText:@"Welcome to Go Scanner!"];
    [welcome setTextAlignment:NSTextAlignmentCenter];
    [welcome setTextColor:[UIColor whiteColor]];
    [onboarding addSubview:welcome];
    
    legendDesc = [[UITextView alloc] initWithFrame:CGRectMake(padding, yMargin+80, effective_w, 70)];
    [legendDesc setText:@"Go Scanner will find Pokémon and\ndisplay their locations with color coded pins. Tap the pin to see the Pokémon."];
    legend = [[UITextView alloc] initWithFrame:CGRectMake(padding, yMargin+200, effective_w, 200)];
    done = [[UITextView alloc] initWithFrame:CGRectMake(padding, height-100-padding, effective_w, 100)];
    [done setText:@"Hit the 'Scan' button to start catching Pokémon! Tap anywhere to dismiss this screen."];
    [done setTextAlignment:NSTextAlignmentCenter];
    [done setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [done setTextColor:[UIColor whiteColor]];
    [done setEditable:NO];
    [legendDesc setEditable:NO];
    [done setFont:[UIFont fontWithName:@"Montserrat-Regular" size:16]];
    [welcome setTextAlignment:NSTextAlignmentCenter];
    [legendDesc setTextAlignment:NSTextAlignmentCenter];
    [legendDesc setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [legend setTextColor:[UIColor whiteColor]];
    [welcome setTextColor:[UIColor whiteColor]];
    [legendDesc setTextColor:[UIColor whiteColor]];
    [legendDesc setFont:[UIFont fontWithName:@"Montserrat-Regular" size:16]];
    [welcome setFont:[UIFont fontWithName:@"Montserrat-Regular" size:24]];
    
    
    //set the colors
    NSString *text = @"Red: Very rare\n\nBlue: Rare\n\nGreen: Uncommon\n\nBrown: Common\n\nGrey: Very Common";
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(Red)" options:kNilOptions error:nil];
    NSRange range = NSMakeRange(0 ,text.length);
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Blue)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Green)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Brown)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Grey)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Very rare)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Rare)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Uncommon)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Common)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:subStringRange];
    }];
    regex = [NSRegularExpression regularExpressionWithPattern:@"(Very Common)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:subStringRange];
    }];
    
    [legend setAttributedText:mutableAttributedString];
    [legend setFont:[UIFont fontWithName:@"Montserrat-Regular" size:16]];
    [legend setEditable:NO];
    [legend setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [legend setTextAlignment:NSTextAlignmentCenter];

    [onboarding addSubview:welcome];
    [onboarding addSubview:legend];
    [onboarding addSubview:legendDesc];
    [onboarding addSubview:done];
    
    
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ((touch.view==onboarding && onboarding) || (touch.view==welcome && onboarding)  || (touch.view==legend && onboarding)  || (touch.view==legendDesc && onboarding) ||(touch.view==done && onboarding) ) {
        NSLog(@"detected a touch");
        return YES;
    }
    NSLog(@"didnt see a touch");
    return NO;
}

-(void)tapMethod {
    [onboarding removeFromSuperview];
    onboarding=nil;
    NSLog(@"removed onboard");
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
                pinView.pinTintColor = [UIColor redColor];
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
