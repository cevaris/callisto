//
//  User.m
//  callisto
//
//  Created by Cevaris on 8/18/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic userId;
@dynamic email;
@dynamic authtoken;
@dynamic createdAt;
@dynamic role;
@dynamic lastName;
@dynamic firstName;


+ (RKObjectMapping*) mapper {
    RKObjectMapping *mapperObj = [RKObjectMapping mappingForClass:[User class]];
    [mapperObj addAttributeMappingsFromDictionary:@{
        @"id": @"userId",
        @"email": @"email",
        @"authtoken": @"authtoken",
        @"first_name": @"firstName",
        @"last_name": @"lastName",
        @"role": @"role",
        @"created_at": @"createdAt"
     }];
    return mapperObj;
}

- (NSString*) name {
    return [NSString stringWithFormat: @"%@ %@", [self firstName], [self lastName]];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"User: Id=%@ Name=%@ Email=%@ AuthToken=%@ Role=%@",
            [self userId], [self name], [self email], [self authtoken], [self role]];
}


@end
