//
//  LBSignScorecardVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 10/13/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBSignScorecardVC.h"
#import "LBRestFacade.h"

@interface LBSignScorecardVC ()

@property (strong, nonatomic) IBOutlet UIButton *sgnScrcrdBtn;
@end

@implementation LBSignScorecardVC

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


@end
