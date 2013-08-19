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
    NSURL *url = [NSURL URLWithString:@"http://rails:3000/"];
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password,@"password", nil];
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    
//    [objectManager.router.routeSet addRoute:[RKRoute
//                                             routeWithClass:[User class]
//                                             pathPattern:@"/signin"
//                                             method:RKRequestMethodPOST]];

    // Activity Indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    RKRequestDescriptor *responseDescriptor;
  
    NSDictionary *user = [[NSDictionary alloc] initWithObjectsAndKeys:password, @"password", email, @"email", nil];
    NSDictionary *package = [[NSDictionary alloc] initWithObjectsAndKeys:user, @"session", nil];

    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:package
                                                       options:NSJSONWritingPrettyPrinted // or 0
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] init];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        // This is the success block
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        // This is the failure block
    }];
    [operation start];
    

    
}

@end
