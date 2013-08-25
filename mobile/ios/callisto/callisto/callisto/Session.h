//
//  Session.h
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Security/Security.h>
#import "SSKeychain.h"
#import "SSKeychainQuery.h"

#import "User.h"
#import "LoginViewController.h"



@interface Session : NSObject

+ (BOOL) hasSession;

+(void) deleteSession;
+(void) saveSession: (User* )user;
+(NSString*) loadSession:(NSString**)email authtoken:(NSString **)authtoken;

@end
