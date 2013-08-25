//
//  AppDelegate.h
//  callisto
//
//  Created by Cevaris on 8/13/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
