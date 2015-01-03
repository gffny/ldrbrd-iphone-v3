//
//  LBLeaderboardWebVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 10/13/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBLeaderboardWebVC.h"
#import "LBRestFacade.h"
#import "LBConstant.h"

@interface LBLeaderboardWebVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LBLeaderboardWebVC

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
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString: webLeaderboardUrl]];
    [self.webView loadRequest:requestObj];
}
     
     
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dismissLeaderboard
{
    NSLog(@"dismissing leaderboard view");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
