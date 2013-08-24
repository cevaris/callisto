//
//  Session.m
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "Session.h"

@implementation Session

+(void) saveSession: (User* )user {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[user email] forKey:@"USER_EMAIL"];
    [SSKeychain setPassword:[user authtoken] forService:@"ACTIVITI_SERVICE" account:[user email]];
}

+ (User*) loadSession {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *email = [defaults objectForKey:@"USER_EMAIL"];
    
    NSString *authtoken = [SSKeychain passwordForService:@"ACTIVITI_SERVICE" account:email];
    
    [UserRequest sendRequest:email withAuthtoken:authtoken];
    
    return [[User alloc] init];
}


@end
