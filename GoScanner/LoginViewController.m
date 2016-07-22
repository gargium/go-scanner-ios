//
//  LoginViewController.m
//  GoScanner
//
//  Created by Gargium on 7/21/16.
//  Copyright © 2016 Gargium. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // TODO(developer) Configure the sign-in button look/feel
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    _pwdField.secureTextEntry = YES;
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitBtnClicked:(id)sender {
    if ([_username.text isEqualToString:@" "] || [_username.text isEqualToString:@""]|| [_pwdField.text isEqualToString:@" "] || [_pwdField.text isEqualToString:@""]) {
        NSLog(@"hi");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Both fields must not be empty." preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    
    NSLog(@"bye");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_username.text forKey:@"username"];
    [defaults setObject:_pwdField.text forKey:@"password"];
    [defaults synchronize];
    NSLog(@"stored username: %@", [defaults objectForKey:@"username"]);
    NSLog(@"stored password: %@", [defaults objectForKey:@"password"]);
    
}
@end
