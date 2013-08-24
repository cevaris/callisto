//
//  UserRequest.m
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "UserRequest.h"

@implementation UserRequest


+ (BOOL) sendRequest: (NSString*)email withAuthtoken:(NSString*)authtoken {
    
    NSAssert(email != (id)[NSNull null] || email.length != 0, @"Email is not set");
    NSAssert(authtoken != (id)[NSNull null] || authtoken.length != 0, @"AuthToken is not set");
    
    NSURL *url = [NSURL URLWithString:@"http://rails:3000/mobile/ios/"];
    
    // Activity Indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
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
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:@"user"
                                                      parameters:nil];
    
    [request setValue:authtoken forHTTPHeaderField:@"DATA_AUTHTOKEN"];
    [request setValue:email forHTTPHeaderField:@"DATA_EMAIL"];
    
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
        //        [Utility showDefaultDialog:@"Auto login Error" text:@"Invalid Email/Password"];
    }];
    
    [manager enqueueObjectRequestOperation:operation];
    
    // Return result
    return FALSE;
    
}


@end
