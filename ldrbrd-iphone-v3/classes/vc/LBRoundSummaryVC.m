//
//  LBRoundSummaryViewController.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/12/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBRoundSummaryVC.h"
#import "LBScorecardUtils.h"
#import "LBLeaderboardWebVC.h"
#import "LBDataManager.h"
#import "LBRestFacade.h"
#import "LBDisplayUtils.h"

@interface LBRoundSummaryVC ()

//score
@property (strong, nonatomic) IBOutlet UILabel *par;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *toParValue;

//hole result count
@property (strong, nonatomic) IBOutlet UILabel *belowParCountValue;
@property (strong, nonatomic) IBOutlet UILabel *parCountValue;
@property (strong, nonatomic) IBOutlet UILabel *bogeyCountValue;
@property (strong, nonatomic) IBOutlet UILabel *bogeyPlusCountValue;

@property (nonatomic) BOOL isShowingLandscapeView;

@end

@implementation LBRoundSummaryVC

@synthesize submitScorecardBtn;
@synthesize summaryTable;
@synthesize isShowingLandscapeView;

LBCourse *course;
LBLeaderboardWebVC *leaderboardVC;

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadViewWithScoreArray: [[LBDataManager sharedInstance] primaryScoreArray] andCourse: [[LBDataManager sharedInstance] course]];
    self.summaryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.summaryTable.bounces = NO;
    course = [[LBDataManager sharedInstance] course];
    [self.submitScorecardBtn addTarget:self action:@selector(sbmtScrcrdBtnClckd:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)orientationChanged:(NSNotification *)notification
{
    NSLog(@"orientation notification recieved");
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
        !isShowingLandscapeView)
    {
        NSLog(@"orientation changed: displaying leaderboard");
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

- (void)sbmtScrcrdBtnClckd:(UIButton *)sender {

    NSLog(@"submit scorecard button clicked");
    [LBRestFacade asynchSubmitScorecard: [[LBDataManager sharedInstance] primaryScoreArray] andScorecardId:[[[LBDataManager sharedInstance] scorecard] idString] withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Scorecard Submit Success");
        // move to new screen
        [self performSegueWithIdentifier:@"seg_sgnscrcrd" sender:self];
        [LBDisplayUtils disableButton: self.submitScorecardBtn];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Scorecard Submit Failure");
        [LBDisplayUtils reenableButton: self.submitScorecardBtn];
        #warning surface error
    }];
}

- (void) loadViewWithScoreArray: (NSArray*) scoreArray andCourse: (LBCourse*) course {

    int coursePar = (int)[course.par integerValue];
    int score = [LBScorecardUtils countScore: scoreArray];
    self.par.text = course.par;
    self.score.text = [NSString stringWithFormat:@"%i", score];
    if(score - coursePar > 0) {
        self.toParValue.text = [NSString stringWithFormat:@"+%i", (score-coursePar)];
    } else {
        self.toParValue.text = [NSString stringWithFormat:@"%i", (score-coursePar)];
    }
    self.parCountValue.text = [NSString stringWithFormat:@"%i", [LBScorecardUtils countPar:scoreArray onCourse: course]];
    self.bogeyCountValue.text = [NSString stringWithFormat:@"%i", [LBScorecardUtils countBogey:scoreArray onCourse: course]];
    self.bogeyPlusCountValue.text = [NSString stringWithFormat:@"%i", [LBScorecardUtils countBogeyPlus:scoreArray onCourse: course]];
    self.belowParCountValue.text = [NSString stringWithFormat:@"%i", [LBScorecardUtils countBelowPar:scoreArray onCourse: course]];
    
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual: summaryTable]) {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual: summaryTable] && course != NULL) {
        return course.holeMap.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LBRoundSummaryHoleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSLog(@"%@", [NSString stringWithFormat:@" index path row %ld", [[NSNumber numberWithInteger: indexPath.row] longValue]]);
    LBCourseHole *courseHole = [course holeWithNumber: ((int)indexPath.row)+1];
    UILabel *holeLabel = (UILabel *)(UIImageView *)[cell viewWithTag:10];
    holeLabel.text = [NSString stringWithFormat:@"%li", (indexPath.row+1)];
    UILabel *parLabel = (UILabel *)(UIImageView *)[cell viewWithTag:20];
    parLabel.text = [NSString stringWithFormat:@"%@", courseHole.par];
    UILabel *indexLabel = (UILabel *)(UIImageView *)[cell viewWithTag:30];
    indexLabel.text = [NSString stringWithFormat:@"%@", courseHole.index];
    UILabel *scoreLabel = (UILabel *)(UIImageView *)[cell viewWithTag:40];
    scoreLabel.text = [NSString stringWithFormat:@"%li", (long)[[[[LBDataManager sharedInstance] primaryScoreArray]  objectAtIndex:indexPath.row] integerValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Upcoming Rounds: didSelectRowAtIndexPath");
}

@end

@interface LBRoundSummaryHoleCell()

@end

@implementation LBRoundSummaryHoleCell

@synthesize holeLabel;
@synthesize parLabel;
@synthesize indexLabel;
@synthesize scoreLabel;

@end
