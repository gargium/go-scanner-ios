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
    _pickerData = @[@"", @"Bulbasaur",@"Ivysaur",@"Venusaur",@"Charmander",@"Charmeleon",@"Charizard",@"Squirtle",@"Wartortle",@"Blastoise",@"Caterpie",@"Metapod",@"Butterfree",@"Weedle",@"Kakuna",@"Beedrill",@"Pidgey",@"Pidgeotto",@"Pidgeot",@"Rattata",@"Raticate",@"Spearow",@"Fearow",@"Ekans",@"Arbok",@"Pikachu",@"Raichu",@"Sandshrew",@"Sandslash",@"Nidoran♀",@"Nidorina",@"Nidoqueen",@"Nidoran♂",@"Nidorino",@"Nidoking",@"Clefairy",@"Clefable",@"Vulpix",@"Ninetales",@"Jigglypuff",@"Wigglytuff",@"Zubat",@"Golbat",@"Oddish",@"Gloom",@"Vileplume",@"Paras",@"Parasect",@"Venonat",@"Venomoth",@"Diglett",@"Dugtrio",@"Meowth",@"Persian",@"Psyduck",@"Golduck",@"Mankey",@"Primeape",@"Growlithe",@"Arcanine",@"Poliwag",@"Poliwhirl",@"Poliwrath",@"Abra",@"Kadabra",@"Alakazam",@"Machop",@"Machoke",@"Machamp",@"Bellsprout",@"Weepinbell",@"Victreebel",@"Tentacool",@"Tentacruel",@"Geodude",@"Graveler",@"Golem",@"Ponyta",@"Rapidash",@"Slowpoke",@"Slowbro",@"Magnemite",@"Magneton",@"Farfetch'd",@"Doduo",@"Dodrio",@"Seel",@"Dewgong",@"Grimer",@"Muk",@"Shellder",@"Cloyster",@"Gastly",@"Haunter",@"Gengar",@"Onix",@"Drowzee",@"Hypno",@"Krabby",@"Kingler",@"Voltorb",@"Electrode",@"Exeggcute",@"Exeggutor",@"Cubone",@"Marowak",@"Hitmonlee",@"Hitmonchan",@"Lickitung",@"Koffing",@"Weezing",@"Rhyhorn",@"Rhydon",@"Chansey",@"Tangela",@"Kangaskhan",@"Horsea",@"Seadra",@"Goldeen",@"Seaking",@"Staryu",@"Starmie",@"Mr. Mime",@"Scyther",@"Jynx",@"Electabuzz",@"Magmar",@"Pinsir",@"Tauros",@"Magikarp",@"Gyarados",@"Lapras",@"Ditto",@"Eevee",@"Vaporeon",@"Jolteon",@"Flareon",@"Porygon",@"Omanyte",@"Omastar",@"Kabuto",@"Kabutops",@"Aerodactyl",@"Snorlax",@"Articuno",@"Zapdos",@"Moltres",@"Dratini",@"Dragonair",@"Dragonite",@"Mewtwo",@"Mew"];
    
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_label setText:@""];
    

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
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"sample title";
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:_pickerData[row] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1]}];

    return attString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_label setText:[NSString stringWithFormat:_pickerData[row]]];
}

- (IBAction)submitPressed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setObject:_label.text forKey:@"searchingFor"];
    [defaults synchronize];
    [self performSegueWithIdentifier:@"searchPressed" sender:self];
}
@end
