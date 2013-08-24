//
//  MyActivitiesViewController.h
//  callisto
//
//  Created by Cevaris on 8/15/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "UserActivityCell.h"
#import "UserRequest.h"

@interface MyActivitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate >

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
