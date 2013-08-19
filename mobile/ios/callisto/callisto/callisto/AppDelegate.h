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

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    User *user;
}

@property (strong, nonatomic) UIWindow *window;

@end
