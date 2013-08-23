//
//  UserActivityViewController.h
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityViewController.h"
#import "UserViewController.h"

@interface UserActivityViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblActivityName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;


@end
