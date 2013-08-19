//
//  LoginRequest.h
//  callisto
//
//  Created by Cevaris on 8/17/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "User.h"



@interface LoginRequest : NSObject{
    NSString *email;
    NSString *password;
}


- (void)setEmail:(NSString*) val;
- (void)setPassword:(NSString*) val;

- (void)sendRequest;

@end
