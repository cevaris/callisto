//
//  User.m
//  callisto
//
//  Created by Cevaris on 8/18/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize email;
@synthesize authtoken;
@synthesize _id;
@synthesize firstName;
@synthesize lastName;
@synthesize createdAt;
@synthesize role;



- (NSString*) name {
    return [NSString stringWithFormat: @"%@ %@", firstName, lastName];
}

//- (NSString*) email {
//    return [self email];
//}
//- (NSString*) authtoken {
//    return [self authtoken];
//}
//
//- (void) setId: (NSNumber *) val {
//    _id = val;
//}
//
//- (void) setFirstName:(NSString *)val {
//    firstName = val;
//}
//
//- (void) setLastName:(NSString *)val {
//    lastName = val;
//}
//
//- (void) setCreatedAt:(NSString *)val {
//    createdAt = val;
//}
//
//- (void) setRole:(NSString *)val {
//    role = val;
//}
//
//- (void) setEmail: (NSString *) val {
//    email = val;
//}
//- (void) setAuthtoken: (NSString *) val {
//    authtoken = val;    
//}

- (NSString *)description {
    return [NSString stringWithFormat: @"User: Id=%@ Name=%@ Email=%@ AuthToken=%@ Role=%@", _id, [self name], email, authtoken, role];
}


@end
