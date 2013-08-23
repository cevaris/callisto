//
//  User.h
//  callisto
//
//  Created by Cevaris on 8/18/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString *email;
    NSString *password;
    NSString *authtoken;
    NSString *first_name;
    NSString *last_name;
    NSString *role;
    NSString *created_at;
}

- (NSString *)description;

- (void) setEmail: (NSString *) val;
- (void) setPassword: (NSString *) val;
- (void) setAuthtoken: (NSString *) val;

@end
