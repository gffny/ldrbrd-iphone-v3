//
//  LBSignScorecardVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 10/13/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBSignScorecardVC.h"
#import "LBRestFacade.h"
#import "LBLeaderboardWebVC.h"

@interface LBSignScorecardVC ()

@property (strong, nonatomic) IBOutlet UIButton *sgnScrcrdBtn;

@property (nonatomic) BOOL isShowingLandscapeView;

@end

@implementation LBSignScorecardVC

@synthesize isShowingLandscapeView;

LBLeaderboardWebVC *leaderboardVC;

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

    [self.sgnScrcrdBtn addTarget:self action:@selector(sgnScrcrdBtnClckd:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
    isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)sgnScrcrdBtnClckd:(UIButton *)sender {
    
    NSLog(@"submit scorecard button clicked");
    [LBRestFacade asynchSgnScorecard:[[[LBDataManager sharedInstance] scorecard] idString] withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Scorecard Sign Success");
        [[LBDataManager sharedInstance] resetScorecardData];
        UINavigationController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
        self.view.window.rootViewController = first;
//        [self dismissViewControllerAnimated:YES completion:nil];
//        [self performSegueWithIdentifier:@"seg_fnshrnd" sender:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Scorecard Sign Failure");
        // check if there's a way to go back to the beginning of the scoring process, also introduce some validation before getting to this point
    }];
}

- (void)orientationChanged:(NSNotification *)notification
{
    NSLog(@"orientation notification recieved");
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
        !isShowingLandscapeView)
    {
        NSLog(@"changing device orientation");
        [self performSegueWithIdentifier:@"seg_dsplyLdrbrd" sender:self];
        isShowingLandscapeView = YES;
    }
    else if (UIDeviceOrientationIsPortrait(deviceOrientation) &&
             isShowingLandscapeView)
    {
        NSLog(@"orientation changed: returning to round summary");
        if(leaderboardVC != nil)
        {
            [leaderboardVC dismissLeaderboard];
        }
        isShowingLandscapeView = NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"seg_dsplyLdrbrd"])
    {
        leaderboardVC = [segue destinationViewController];
    }
}

@end
