//
//  User.m
//  callisto
//
//  Created by Cevaris on 8/18/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "User.h"

@implementation User


- (NSString*) name {
    return [NSString stringWithFormat: @"%@ %@", firstName, lastName];
}
- (void) setId: (NSInteger* ) val {
    _id = val;
}

- (void) setFirstName:(NSString *)val {
    firstName = val;
}

- (void) setLastName:(NSString *)val {
    lastName = val;
}

- (void) setCreatedAt:(NSString *)val {
    createdAt = val;
}

- (void) setRole:(NSString *)val {
    role = val;
}

- (void) setEmail: (NSString *) val {
    email = val;
}
- (void) setAuthtoken: (NSString *) val {
    authtoken = val;    
}

- (NSString *)description {
    return [NSString stringWithFormat: @"User: Name=%@ Email=%@ AuthToken=%@ Role=%@", [self name], email, authtoken, role];
}


@end
