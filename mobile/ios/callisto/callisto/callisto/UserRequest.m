//
//  UserRequest.m
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "UserRequest.h"

@implementation UserRequest

- (void)setEmail:(NSString*) val {
    email = val;
}
- (void)setAuthtoken:(NSString*) val{
    authtoken = val;
}

- (BOOL)sendRequest {
    
    NSAssert(email != (id)[NSNull null] || email.length != 0, @"Email is not set");
    NSAssert(authtoken != (id)[NSNull null] || authtoken.length != 0, @"AuthToken is not set");
    
    NSURL *url = [NSURL URLWithString:@"http://rails:3000/mobile/ios/"];
    
    // Activity Indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
    NSDictionary *package = [NSDictionary dictionaryWithObjectsAndKeys: authtoken, @"password", email, @"email", nil];
    
    
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
            requestResult = TRUE;
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
//        [Utility showDefaultDialog:@"Auto login Error" text:@"Invalid Email/Password"];
        requestResult = FALSE;
    }];
    
    [manager enqueueObjectRequestOperation:operation];
    
    // Return result
    return requestResult;
    
}


@end
