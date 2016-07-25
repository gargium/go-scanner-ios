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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    [_pwdField setDelegate:self];
    [_username setDelegate:self];
    
    _pwdField.secureTextEntry = YES;
    [self.view setBackgroundColor:[UIColor colorWithRed: (46/255.0) green:(204/255.0) blue:(113/255.0) alpha:1]];
    
    [_submitBtn setBackgroundColor:[UIColor colorWithRed: (39/255.0) green:(174/255.0) blue:(96/255.0) alpha:1]];
    [_submitBtn setTitle:@">" forState:UIControlStateNormal];
    
    [_username setBorderStyle:UITextBorderStyleNone];
    [_pwdField setBorderStyle:UITextBorderStyleNone];
    [_username setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14]];
    [_pwdField setFont:[UIFont fontWithName:@"Montserrat-Regular" size:14]];
    
    
    [_username setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [_pwdField setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [_username setTextColor:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1]];
    [_pwdField setTextColor:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1]];


}

-(void)dismissKeyboard {
    [_username resignFirstResponder];
    [_pwdField resignFirstResponder];
}

-(void)autoLogin {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def synchronize];
    
    if ([def objectForKey:@"username"] && [def objectForKey:@"password"]) {
        NSLog(@"user already logged in, auto logging in ...");
        [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    }
}
-(void)viewDidAppear:(BOOL)animated {
    //[self autoLogin];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please create a new Trainer Club account before using this service to avoid your own being linked with this unofficial app." preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Create New Account" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.pokemon.com"]];
//    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    
    // post to /login and verify details
    NSString *post = [NSString stringWithFormat:@"userHash=%@&pwHash=%@",_username.text, _pwdField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://pogo-scanner-server.herokuapp.com/api/login"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Request made successfully");
    } else {
        NSLog(@"Connection could not be made");
    }

    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [self submitBtnClicked:self];
    return YES;
}


# pragma - Delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data
{
    // check if request was for login
    NSString *path = [[[connection currentRequest] URL] path];
    if ([path isEqualToString:@"/api/login"])
    {
        NSError *jsonParsingError = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        
        NSInteger statusCode = [[dic objectForKey:@"status"] integerValue];
        if (jsonParsingError) NSLog(@"%@", jsonParsingError);
        
        if (statusCode == 300)
        {
            [self performSegueWithIdentifier:@"loginSuccess" sender:self];
            
            NSLog(@"bye");
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_username.text forKey:@"username"];
            [defaults setObject:_pwdField.text forKey:@"password"];
            [defaults synchronize];
            NSLog(@"stored username: %@", [defaults objectForKey:@"username"]);
            NSLog(@"stored password: %@", [defaults objectForKey:@"password"]);
        }
        else {
            NSString *alertTitle = @"Error";
            NSString *alertMsg = @"Login error";
            
            if (statusCode == 200) { // incorrect user/pw
                alertMsg = @"Not a valid Pokemon Trainer Club account. Sign up for one on the official Pokemon website.";
            }
            else if (statusCode == 201) // inactivated count
            {
                alertTitle = @"Uh oh!";
                alertMsg = @"Looks like this Trainer Club account has not been activated. Please confirm using the email received when you signed up.";
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

@end
