//
//  LoginViewController.h
//  GoScanner
//
//  Created by Gargium on 7/21/16.
//  Copyright © 2016 Gargium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitBtnClicked:(id)sender;

@end
