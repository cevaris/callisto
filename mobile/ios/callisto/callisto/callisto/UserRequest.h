//
//  UserRequest.h
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "User.h"

@interface UserRequest : NSObject {
    BOOL requestResult;
    NSString *email;
    NSString *authtoken;
}

- (void)setEmail:(NSString*) val;
- (void)setAuthtoken:(NSString*) val;

- (BOOL)sendRequest;


@end
