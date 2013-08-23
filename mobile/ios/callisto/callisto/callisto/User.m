//
//  User.m
//  callisto
//
//  Created by Cevaris on 8/18/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "User.h"

@implementation User

- (void) setEmail: (NSString *) val {
    email = val;
}
- (void) setPassword: (NSString *) val {
    password = val;    
}
- (void) setAuthtoken: (NSString *) val {
    authtoken = val;    
}

- (NSString *)description {
    return [NSString stringWithFormat: @"User: Email=%@ Password=%@, AuthToken=%@", email, password, authtoken];
}


@end
