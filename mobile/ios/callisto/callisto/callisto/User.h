//
//  User.h
//  callisto
//
//  Created by Cevaris on 8/18/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSNumber *_id;
    NSString *email;
    NSString *password;
    NSString *authtoken;
    NSString *firstName;
    NSString *lastName;
    NSString *role;
    NSString *createdAt;
}

- (NSString *)description;

- (NSString*) name;

- (void) setId: (NSNumber*) val;
- (void) setEmail: (NSString *) val;
- (void) setFirstName: (NSString *) val;
- (void) setLastName: (NSString *) val;
- (void) setRole: (NSString *) val;
- (void) setAuthtoken: (NSString *) val;
- (void) setCreatedAt: (NSString *) val;

@end
