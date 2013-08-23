//
//  UserActivityViewController.m
//  callisto
//
//  Created by Cevaris on 8/23/13.
//  Copyright (c) 2013 Callisto. All rights reserved.
//

#import "UserActivityViewController.h"

@interface UserActivityViewController ()

@end

@implementation UserActivityViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(lblTapGesture:)];
    [[self lblActivityName] addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(lblTapGesture:)];
    [[self lblUserName] addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;

    
    
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) lblTapGesture:(UIGestureRecognizer *)sender {
    
    
    
    NSInteger tag = [[(UIGestureRecognizer *)sender view] tag];
    
//    NSLog(@"SelectedTag=%d, ActivityTag=%d, UserTag=%d", tag, [[self lblActivityName] tag], [[self lblUserName] tag]);
    
    if(tag == [[self lblActivityName] tag]) {
        ActivityViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (tag == [[self lblUserName] tag]) {
        
        UserViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    } 
   

    
    
}


@end
