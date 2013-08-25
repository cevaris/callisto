//
//  User.h
//  callisto
//
//  Created by Cevaris on 8/18/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface User : NSManagedObject 


@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * authtoken;
@property (nonatomic, retain) NSString * createdAt;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * firstName;

+ (RKObjectMapping*) mapper;

- (NSString *)description;
- (NSString*) name;

@end
