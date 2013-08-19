//
//  LoginViewController.m
//  callisto
//
//  Created by Cevaris on 8/15/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLogin:(id)sender {
    
    LoginRequest *login = [[LoginRequest alloc] init];
    [login setEmail:self.txtEmail.text];
    [login setPassword:self.txtPassword.text];
    NSLog(@"LoginRequest Result %d", [login sendRequest]);
       
    
    

}

-(IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

@end
