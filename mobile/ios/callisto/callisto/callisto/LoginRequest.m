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



- (void)sendRequest {
    
    NSAssert(email != (id)[NSNull null] || email.length != 0, @"Email is not set");
    NSAssert(password != (id)[NSNull null] || password.length != 0, @"Password is not set");
    
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    NSString *email = @"jim.kobol@gmail.com";
//    NSString *password = @"adam2007";
    NSURL *url = [NSURL URLWithString:@"http://rails:3000/mobile/ios/"];

    // Activity Indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  
    NSDictionary *package = [NSDictionary dictionaryWithObjectsAndKeys: password, @"password", email, @"email", nil];


    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:package
//                                                       options:NSJSONWritingPrettyPrinted // or 0
//                                                         error:&error];
//    NSString *jsonString = [[NSString alloc] init];
//    if (!jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"Successfull JSON serialization: %@", jsonString);
//    }
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
//    
//    NSLog(@"Successfull POST serialization: %@", requestData);
//    
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody: requestData];
    
//    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
//    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
//        // This is the success block
//        NSLog(@"Successfull in Restkit");
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        // This is the failure block
//        NSLog(@"Error in Restkit");
//    }];
//    [operation start];
    
//    RKObjectRequestOperation *operation =
//    [objectManager objectRequestOperationWithRequest:request
//                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
//     {
//         // Success handler.
////         NSLog(@"%@", [mappingResult firstObject]);
//         NSLog(@"Successfull in Restkit");
//     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//         // Error handler.
//         NSLog(@"Error in Restkit %@", error);
//     }];
//    
//    // enqueue operation
//    [RKObjectManager.sharedManager enqueueObjectRequestOperation:operation];
//    
//    // monitor upload progress
//    [operation.HTTPRequestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        NSLog(@"bytesWritten: %d, totalBytesWritten: %lld, totalBytesExpectedToWrite: %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
//    }];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    [httpClient postPath:@"signin" parameters:package success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];

    
}

@end
