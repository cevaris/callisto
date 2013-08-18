//
//  LoginRequest.m
//  callisto
//
//  Created by Cevaris on 8/17/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest



- (void)sendRequest {
    NSString *email = @"jim.kobol@gmail.com";
    NSString *password = @"adam2007";
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password,@"password", nil];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    

    RKURL *URL = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/mobile/ios/signin" queryParameters:queryParams];

//    [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [URL resourcePath], [URL query]] delegate:self];
}

@end
