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
    
    self.txtEmail.text = @"jim.kobol@gmail.com";
    self.txtPassword.text = @"adam2007";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLogin:(id)sender {
    [self sendLoginRequest];
    
}

-(IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}



- (void) sendLoginRequest {
    
    NSString *email = [[self txtEmail] text];
    NSString *password = [[self txtPassword] text];
    
    NSAssert(email != (id)[NSNull null] || email.length != 0, @"Email is not set");
    NSAssert(password != (id)[NSNull null] || password.length != 0, @"Password is not set");
    
    
    NSDictionary *package = [NSDictionary dictionaryWithObjectsAndKeys: password, @"password", email, @"email", nil];

    
    RKObjectMapping* userMapper = [User mapper];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapper method:RKRequestMethodPOST pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:IOS_URL]];
    
    NSURL *url = [NSURL URLWithString:IOS_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"signin"
                                                      parameters:package];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Request Successful, response '%@'", mappingResult.array);
        NSArray *result =  [mappingResult array];
        if([result count] > 0) {
            User *user = [result objectAtIndex:0];
            NSLog(@"User'%@'", user);
            [Session saveSession:user];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        [Utility showDefaultDialog:@"Login Error" text:@"Invalid Email/Password"];
        
    }];
    
    [manager enqueueObjectRequestOperation:operation];
    
}

@end
