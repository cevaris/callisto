//
//  LoginViewController.h
//  callisto
//
//  Created by Cevaris on 8/15/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginRequest.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)btnLogin:(id)sender;
- (IBAction)textFieldReturn:(id)sender;


@end
