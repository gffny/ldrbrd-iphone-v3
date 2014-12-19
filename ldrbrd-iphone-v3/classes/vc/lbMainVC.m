//
//  lbMainVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 3/30/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBMainVC.h"
#import "LBPlayGolfVC.h"

@interface LBMainVC ()

@property (weak, nonatomic) IBOutlet UITableView * upcomingRoundTable;
@property (weak, nonatomic) IBOutlet UITableView * newsTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (strong, nonatomic) IBOutlet UIButton *playNowBtn;
@property (strong, nonatomic) IBOutlet UIButton *scheduleRoundBtn;

@end

@implementation LBMainVC

@synthesize upcomingRoundTable;
@synthesize newsTable;

- (void)playUpcomingRoundWithId:(NSString *)roundId
{
    //TODO get course, and competition data using the roundId
    [self performSegueWithIdentifier:@"seg_plyrnd" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 736)];
    [scroller setDelegate:self];

    [self.upcomingRoundTable setDataSource:self];
    [self.upcomingRoundTable setDelegate:self];
    
    [self.newsTable setDataSource:self];
    [self.newsTable setDelegate:self];

    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    
    if([[LBDataManager sharedInstance] scorecard] != nil) {
        [self.playNowBtn addTarget:self action:@selector(continueRoundBtnClckd:) forControlEvents:UIControlEventTouchUpInside];
        [self.playNowBtn setTitle:@"Continue Round" forState:UIControlStateNormal];
    } else {
        [self.playNowBtn addTarget:self action:@selector(playNowBtnClckd:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.scheduleRoundBtn addTarget:self action:@selector(scheduleRoundBtnClckd:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)playNowBtnClckd:(UIButton *)sender
{
    NSLog(@"play now button clicked");
    [self performSegueWithIdentifier:@"seg_plynw" sender:self];
}

- (void)continueRoundBtnClckd:(UIButton *)sender
{
    NSLog(@"continue round button clicked");
    [self performSegueWithIdentifier:@"seg_ctnRnd" sender:self];
}


- (void)scheduleRoundBtnClckd:(UIButton *)sender
{
    NSLog(@"schedule round button clicked");
    [self performSegueWithIdentifier:@"seg_schdlrnd" sender:self];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        // Custom initialization
        NSLog(@"loading main lbrdbrd-app view");
    }
    return self;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"seg_embdUpcmngRnds"])
    {
        //LBUpcomingRoundsTableVC *urtvc = (LBUpcomingRoundsTableVC *)segue.destinationViewController;
        //urtvc.parentVC = self;
    }
    else if ([segue.identifier isEqualToString:@"seg_ctnRnd"])
    {
        LBPlayGolfVC *playGolfVC = (LBPlayGolfVC *)segue.destinationViewController;
        [playGolfVC loadCourseInView: [[[LBDataManager sharedInstance] scorecard] course]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual: newsTable]) {
        return 1;
    } else if ([tableView isEqual: upcomingRoundTable]) {
        return 1;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual: newsTable]) {
        return 5;
    } else if ([tableView isEqual: upcomingRoundTable]) {
        return 5;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual: newsTable]) {
        static NSString *CellIdentifier = @"NewsItem";
        switch ( indexPath.row )
        {
            case 0:
                CellIdentifier = @"NewsItem1";
                break;
                
            case 1:
                CellIdentifier = @"NewsItem2";
                break;
                
            case 2:
                CellIdentifier = @"NewsItem3";
                break;
                
            case 3:
                CellIdentifier = @"NewsItem4";
                break;
                
            case 4:
                CellIdentifier = @"NewsItem5";
                break;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier];
        }
        return cell;
    } else { // if ([tableView isEqual: upcomingRoundTable]) {
        static NSString *CellIdentifier = @"UpcomingRound";
        switch ( indexPath.row )
        {
            case 0:
                CellIdentifier = @"UpcomingRound1";
                break;
                
            case 1:
                CellIdentifier = @"UpcomingRound2";
                break;
                
            case 2:
                CellIdentifier = @"UpcomingRound3";
                break;
                
            case 3:
                CellIdentifier = @"UpcomingRound4";
                break;
                
            case 4:
                CellIdentifier = @"UpcomingRound5";
                break;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Upcoming Rounds: didSelectRowAtIndexPath");
}

@end
