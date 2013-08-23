//
//  Utility.m
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "Utility.h"
#import "User.h"
#import <Security/Security.h>
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#import "UserRequest.h"

@implementation Utility


+(void) setUserKeychainAuthToken: (User* )user {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[user email] forKey:@"USER_EMAIL"];
    [SSKeychain setPassword:[user authtoken] forService:@"ACTIVITI_SERVICE" account:[user email]];
}

+ (User*) getUserKeychainAuthToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *email = [defaults objectForKey:@"USER_EMAIL"];
    
    NSString *authtoken = [SSKeychain passwordForService:@"ACTIVITI_SERVICE" account:email];
    
    UserRequest *userRequest = [[UserRequest alloc] init];
    [userRequest setEmail:email];
    [userRequest setAuthtoken:authtoken];
    NSLog(@"LoginRequest Result %d", [userRequest sendRequest]);
    
    return [[User alloc] init];
}



+(void) showDefaultDialog: (NSString*)title text:(NSString*)text {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:text
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}


@end
