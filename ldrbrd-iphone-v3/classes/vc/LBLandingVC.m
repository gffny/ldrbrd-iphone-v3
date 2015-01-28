//
//  LBLandingVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 10/9/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBLandingVC.h"
#import "LBRestFacade.h"
#import "LBUserDefaults.h"
#import "LBDisplayUtils.h"

@interface LBLandingVC ()

@end

@implementation LBLandingVC

@synthesize username;
@synthesize password;
@synthesize warningLabel;
@synthesize loginButton;

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
    NSLog(@"Continual scoring is turned %@", [LBUserDefaults continualScoring] ? @"ON" : @"OFF");
    NSLog([[[NSUserDefaults standardUserDefaults] objectForKey:@"continualScoring"] boolValue] ? @"Yes" : @"No");
    [self.username setText: [[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    // Do any additional setup after loading the view.
    [LBRestFacade asynchBackendOnlineCheckWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [warningLabel setText: @"Backend Online"];
        [super viewDidLoad];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Backend Offline");
        //SOMEHOW SHOW THE BACKEND IS OFFLINE
        [warningLabel setText: @"Backend Offline"];
        //Maybe have an offline mode?!
        //[loginButton setEnabled:NO];
        [super viewDidLoad];
        
    }];
    
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginAction:(UIButton *)sender
{
    NSLog(@"%@", username.text);
    [LBRestFacade asynchAuthenticateWithUsername:username.text andPassword:password.text withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[NSUserDefaults standardUserDefaults] setObject:username.text forKey:@"username"];
        NSLog(@"Auth Success");
        // move to new screen
        [self dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"seg_auth" sender:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Auth Failure");
        if(error != NULL) {
            NSLog(@"%ld", (long)[error code]);
            NSLog(@"%@", [error description]);
            [warningLabel setText: [NSString stringWithFormat: @"authentication failed: %@", [error description]]];
        } else {
            [warningLabel setText: @"authentication failed"];
        }
        [LBDisplayUtils reenableButton:self.loginButton];
    }];
    [LBDisplayUtils disableButton:self.loginButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

