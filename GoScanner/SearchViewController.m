//
//  SearchViewController.m
//  GoScanner
//
//  Created by Gargium on 7/20/16.
//  Copyright © 2016 Gargium. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () {
    NSArray *_pickerData;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed: (155/255.0) green:(89/255.0) blue:(182/255.0) alpha:1]];
    [self.dirlabel setTextColor:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1]];
    [self.label setTextColor:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1]];
    [self.submitbtn setBackgroundColor:[UIColor colorWithRed:142/255.0 green:68/255.0 blue:173/255.0 alpha:1]];
    [_submitbtn setTitle:@"Show me!" forState:UIControlStateNormal];
    [_submitbtn setTitleColor:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1] forState:UIControlStateNormal];

    _dirlabel.numberOfLines = 2;
    _dirlabel.lineBreakMode = NSLineBreakByWordWrapping;
    //initialize data
    _pickerData = @[@"Bulbasaur:1",@"Ivysaur:2",@"Venusaur:3",@"Charmander:4",@"Charmeleon:5",@"Charizard:6",@"Squirtle:7",@"Wartortle:8",@"Blastoise:9",@"Caterpie:10",@"Metapod:11",@"Butterfree:12",@"Weedle:13",@"Kakuna:14",@"Beedrill:15",@"Pidgey:16",@"Pidgeotto:17",@"Pidgeot:18",@"Rattata:19",@"Raticate:20",@"Spearow:21",@"Fearow:22",@"Ekans:23",@"Arbok:24",@"Pikachu:25",@"Raichu:26",@"Sandshrew:27",@"Sandslash:28",@"Nidoran♀:29",@"Nidorina:30",@"Nidoqueen:31",@"Nidoran♂:32",@"Nidorino:33",@"Nidoking:34",@"Clefairy:35",@"Clefable:36",@"Vulpix:37",@"Ninetales:38",@"Jigglypuff:39",@"Wigglytuff:40",@"Zubat:41",@"Golbat:42",@"Oddish:43",@"Gloom:44",@"Vileplume:45",@"Paras:46",@"Parasect:47",@"Venonat:48",@"Venomoth:49",@"Diglett:50",@"Dugtrio:51",@"Meowth:52",@"Persian:53",@"Psyduck:54",@"Golduck:55",@"Mankey:56",@"Primeape:57",@"Growlithe:58",@"Arcanine:59",@"Poliwag:60",@"Poliwhirl:61",@"Poliwrath:62",@"Abra:63",@"Kadabra:64",@"Alakazam:65",@"Machop:66",@"Machoke:67",@"Machamp:68",@"Bellsprout:69",@"Weepinbell:70",@"Victreebel:71",@"Tentacool:72",@"Tentacruel:73",@"Geodude:74",@"Graveler:75",@"Golem:76",@"Ponyta:77",@"Rapidash:78",@"Slowpoke:79",@"Slowbro:80",@"Magnemite:81",@"Magneton:82",@"Farfetch'd:83",@"Doduo:84",@"Dodrio:85",@"Seel:86",@"Dewgong:87",@"Grimer:88",@"Muk:89",@"Shellder:90",@"Cloyster:91",@"Gastly:92",@"Haunter:93",@"Gengar:94",@"Onix:95",@"Drowzee:96",@"Hypno:97",@"Krabby:98",@"Kingler:99",@"Voltorb:100",@"Electrode:101",@"Exeggcute:102",@"Exeggutor:103",@"Cubone:104",@"Marowak:105",@"Hitmonlee:106",@"Hitmonchan:107",@"Lickitung:108",@"Koffing:109",@"Weezing:110",@"Rhyhorn:111",@"Rhydon:112",@"Chansey:113",@"Tangela:114",@"Kangaskhan:115",@"Horsea:116",@"Seadra:117",@"Goldeen:118",@"Seaking:119",@"Staryu:120",@"Starmie:121",@"Mr. Mime:122",@"Scyther:123",@"Jynx:124",@"Electabuzz:125",@"Magmar:126",@"Pinsir:127",@"Tauros:128",@"Magikarp:129",@"Gyarados:130",@"Lapras:131",@"Ditto:132",@"Eevee:133",@"Vaporeon:134",@"Jolteon:135",@"Flareon:136",@"Porygon:137",@"Omanyte:138",@"Omastar:139",@"Kabuto:140",@"Kabutops:141",@"Aerodactyl:142",@"Snorlax:143",@"Articuno:144",@"Zapdos:145",@"Moltres:146",@"Dratini:147",@"Dragonair:148",@"Dragonite:149",@"Mewtwo:150",@"Mew:151"];
    
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    [_label setText:[NSString stringWithFormat:_pickerData[row]]];
    return _pickerData[row];

}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"sample title";
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:_pickerData[row] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1]}];
    [_label setText:[NSString stringWithFormat:_pickerData[row]]];

    return attString;
    
}

- (IBAction)submitPressed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setObject:_label.text forKey:@"searchingFor"];
    [defaults synchronize];
    [self performSegueWithIdentifier:@"searchPressed" sender:self];
}
@end
