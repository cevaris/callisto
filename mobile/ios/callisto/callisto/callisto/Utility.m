//
//  Utility.m
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "Utility.h"

@implementation Utility


+(void) showDefaultDialog: (NSString*)title text:(NSString*)text handler:(UIViewController*)view {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:text
                                                   delegate:view
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}


@end
