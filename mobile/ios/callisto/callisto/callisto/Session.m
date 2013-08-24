//
//  Session.m
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "Session.h"

@implementation Session

NSString * const USER_EMAIL = @"USER_EMAIL";
NSString * const ACTIVITY_SERVICE = @"ACTIVITY_SERVICE";


+ (BOOL) hasSession {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *email = [defaults objectForKey:USER_EMAIL];

    NSLog(@"Email=%@", email);

    if (email != nil && email.length != 0)
        return TRUE;
    else
        return FALSE;
}

+(void) saveSession: (User* )user {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[user email] forKey:USER_EMAIL];
    [SSKeychain setPassword:[user authtoken] forService:ACTIVITY_SERVICE account:[user email]];
    NSLog(@"Saved Session Email=%@",[defaults objectForKey:USER_EMAIL]);
}

+(void) deleteSession {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USER_EMAIL];
    NSLog(@"Deleted Session");
}

+ (NSString*) loadSession:(NSString**)email authtoken:(NSString **)authtoken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    *email = [defaults objectForKey:USER_EMAIL];
    *authtoken = [SSKeychain passwordForService:ACTIVITY_SERVICE account:*email];
    
    return *authtoken;
}


@end
