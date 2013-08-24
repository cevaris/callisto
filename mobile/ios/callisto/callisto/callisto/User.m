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


+ (RKObjectMapping*) mapping {
    RKObjectMapping *mapper = [RKObjectMapping mappingForClass:[User class]];
    [mapper addAttributeMappingsFromDictionary:@{
        @"id": @"_id",
        @"email": @"email",
        @"authtoken": @"authtoken",
        @"first_name": @"firstName",
        @"last_name": @"lastName",
        @"role": @"role",
        @"created_at": @"createdAt"
     }];
    return mapper;
}

- (NSString*) name {
    return [NSString stringWithFormat: @"%@ %@", firstName, lastName];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"User: Id=%@ Name=%@ Email=%@ AuthToken=%@ Role=%@", _id, [self name], email, authtoken, role];
}


@end
