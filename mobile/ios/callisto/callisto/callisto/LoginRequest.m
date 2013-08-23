//
//  LoginRequest.m
//  callisto
//
//  Created by Cevaris on 8/17/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (void)setEmail:(NSString*) val {
    email = val;
}
- (void)setPassword:(NSString*) val{
    password = val;
}

- (BOOL)sendRequest {
    
    NSAssert(email != (id)[NSNull null] || email.length != 0, @"Email is not set");
    NSAssert(password != (id)[NSNull null] || password.length != 0, @"Password is not set");
    
//    User *user = [User new];
//    [user setPassword:password];
//    [user setEmail:email];
    

//    NSString *email = @"jim.kobol@gmail.com";
//    NSString *password = @"adam2007";
    NSURL *url = [NSURL URLWithString:@"http://rails:3000/mobile/ios/"];

    // Activity Indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
    NSDictionary *package = [NSDictionary dictionaryWithObjectsAndKeys: password, @"password", email, @"email", nil];
    

    RKObjectMapping* articleMapping = [RKObjectMapping mappingForClass:[User class]];
    [articleMapping addAttributeMappingsFromDictionary:@{
        @"id": @"_id",
        @"email": @"email",
        @"authtoken": @"authtoken",
        @"first_name": @"firstName",
        @"last_name": @"lastName",
        @"role": @"role",
        @"created_at": @"createdAt"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping method:RKRequestMethodPOST pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://rails:3000/mobile/ios/"]];

    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"signin"
                                                      parameters:package];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];

    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Request Successful, response '%@'", mappingResult.array);
        NSArray *result =  [mappingResult array];
        if([result count] > 0) {
            User *user = [result objectAtIndex:0];
            NSLog(@"User'%@'", user);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        [Utility showDefaultDialog:@"Login Error" text:@"Invalid Email/Password" ];
        
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error"
//                                                        message:@"Invalid Email/Password"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];

    }];
    
    
    [manager enqueueObjectRequestOperation:operation];

    // Return result
    return requestResult;
    
}

@end
