//
//  User.h
//  callisto
//
//  Created by Cevaris on 8/18/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface User : NSObject 


@property (nonatomic, assign) NSNumber *_id;
@property (nonatomic, assign) NSString *email;

@property (nonatomic, assign) NSString *authtoken;
@property (nonatomic, assign) NSString *firstName;
@property (nonatomic, assign) NSString *lastName;
@property (nonatomic, assign) NSString *role;
@property (nonatomic, assign) NSString *createdAt;

+ (RKObjectMapping*) mapping;

- (NSString *)description;
- (NSString*) name;

@end
