//
//  LBPlayGolfVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/25/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBDataManager.h"
#import "LBPlayGolfVC.h"
#import "LBGolfShotProfiler.h"
#import "LBCourse.h"
#import "LBLocationManager.h"
#import "LBRestFacade.h"
#import "LBScorecardUtils.h"
#import "UIColor+LBColours.h"
#import "UIFont+LBFont.h"

@interface LBPlayGolfVC ()

// UI Gestures
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *oneFingerSwipeLeft;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *oneFingerSwipeRight;
@property (nonatomic, strong) IBOutlet UIGestureRecognizer *touchBeganRecogniser;
@property (nonatomic, strong) IBOutlet UILongPressGestureRecognizer *lpGesture;

// HANDY
@property (nonatomic, strong) LBLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *flightPathArray;
@property (nonatomic) int holeScore;
@property (nonatomic) int holePar;
@property (nonatomic) int holePointer;
@property (nonatomic) BOOL isShowingLandscapeView;

// UI LABELS
@property (strong, nonatomic) IBOutlet UILabel *parLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *indexLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *holeScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorMessage;

// Slider LABELS
@property (weak, nonatomic) IBOutlet UILabel *slider1;
@property (weak, nonatomic) IBOutlet UILabel *slider2;
@property (weak, nonatomic) IBOutlet UILabel *slider3;
@property (weak, nonatomic) IBOutlet UILabel *slider4;
@property (weak, nonatomic) IBOutlet UILabel *slider5;
@property (weak, nonatomic) IBOutlet UILabel *slider6;
@property (weak, nonatomic) IBOutlet UILabel *slider7;
@property (weak, nonatomic) IBOutlet UILabel *slider8;
@property (weak, nonatomic) IBOutlet UILabel *slider9;

@end

@implementation LBPlayGolfVC

@synthesize isShowingLandscapeView;

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Initialise Gestures
    [self addGestureRecognisers];

    [self setLocationManager: [LBLocationManager sharedInstance]];
    NSLog(@"Playing scorecardId %@", [[[LBDataManager sharedInstance] scorecard] idString]);

    // Initialise Storage
    [self setFlightPathArray: [[NSMutableArray alloc] init]];
    LBScorecard *scorecard = [[LBDataManager sharedInstance] scorecard];
    LBCourseHole *firstIncompleteHole = (LBCourseHole*)[LBScorecardUtils firstIncompleteHole: [scorecard holeScoreArray] forScorecard: scorecard orLastHole: YES];
    [self setHolePointer: ((int) [firstIncompleteHole.holeNumber intValue]-1)];
    if(firstIncompleteHole.holeNumber.intValue > scorecard.holeScoreArray.count) {
        [[LBDataManager sharedInstance] setScore: @0 forHole: [NSNumber numberWithInt: [firstIncompleteHole.holeNumber intValue]]];
    }
    [self loadHoleIntoView: firstIncompleteHole];
    [[LBDataManager sharedInstance] loadScoreArray: [scorecard holeScoreArray]];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self hideError];
}

- (void)awakeFromNib
{
    isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void) loadCourseInView: (LBCourse *) courseToLoad
{
    [[LBDataManager sharedInstance] initialiseCourse:courseToLoad];
}

- (void) loadHoleIntoView: (LBCourseHole *) courseHole
{
    self.holePar = [courseHole.par intValue];
    [self.parLabel setText: [NSString stringWithFormat: @"%@", courseHole.par]];
    [self.distanceLabel setText: [NSString stringWithFormat: @" %@", courseHole.holeDistance]];
    [self.indexLabel setText: [NSString stringWithFormat: @"%@", courseHole.index]];
    [self.descriptionLabel setText: courseHole.holeDescription];
    [self.holeScoreLabel setText: [NSString stringWithFormat: @"%i", self.holeScore]];
    [self loadSliderPosition: [courseHole.holeNumber intValue]];
    [self decorateHoleScore];
}

-(void) loadSliderPosition: (int) holeNumber
{
    if(holeNumber == 1) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderLarge]];
        [self.slider2 setText: [NSString stringWithFormat:@"%i", 2]];
        [self.slider2 setFont: [UIFont LBSliderMedium]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 3]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"."]];
        [self.slider4 setFont: [UIFont LBSliderSmall]];
        [self.slider5 setText: [NSString stringWithFormat:@"."]];
        [self.slider5 setFont: [UIFont LBSliderSmall]];
        [self.slider6 setText: [NSString stringWithFormat:@"."]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"."]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 2) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderMedium]];
        [self.slider2 setText: [NSString stringWithFormat:@"%i", 2]];
        [self.slider2 setFont: [UIFont LBSliderLarge]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 3]];
        [self.slider3 setFont: [UIFont LBSliderMedium]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 4]];
        [self.slider4 setFont: [UIFont LBSliderSmall]];
        [self.slider5 setText: [NSString stringWithFormat:@"."]];
        [self.slider5 setFont: [UIFont LBSliderSmall]];
        [self.slider6 setText: [NSString stringWithFormat:@"."]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"."]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 3) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"%i", 2]];
        [self.slider2 setFont: [UIFont LBSliderMedium]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 3]];
        [self.slider3 setFont: [UIFont LBSliderLarge]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 4]];
        [self.slider4 setFont: [UIFont LBSliderMedium]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 5]];
        [self.slider5 setFont: [UIFont LBSliderSmall]];
        [self.slider6 setText: [NSString stringWithFormat:@"."]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"."]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 4) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 2]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"%i", 3]];
        [self.slider2 setFont: [UIFont LBSliderMedium]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 4]];
        [self.slider3 setFont: [UIFont LBSliderLarge]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 5]];
        [self.slider4 setFont: [UIFont LBSliderMedium]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 6]];
        [self.slider5 setFont: [UIFont LBSliderSmall]];
        [self.slider6 setText: [NSString stringWithFormat:@"."]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"."]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 5) {
        [self.slider1 setText: [NSString stringWithFormat:@"."]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"%i", 3]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 4]];
        [self.slider3 setFont: [UIFont LBSliderMedium]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 5]];
        [self.slider4 setFont: [UIFont LBSliderLarge]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 6]];
        [self.slider5 setFont: [UIFont LBSliderMedium]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 7]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"."]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 6) {
        [self.slider1 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"%i", 4]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 5]];
        [self.slider3 setFont: [UIFont LBSliderMedium]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 6]];
        [self.slider4 setFont: [UIFont LBSliderLarge]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 7]];
        [self.slider5 setFont: [UIFont LBSliderMedium]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 8]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"."]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 7) {
        [self.slider1 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"%i", 5]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 6]];
        [self.slider3 setFont: [UIFont LBSliderMedium]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 7]];
        [self.slider4 setFont: [UIFont LBSliderLarge]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 8]];
        [self.slider5 setFont: [UIFont LBSliderMedium]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 9]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"."]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 8) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 6]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 7]];
        [self.slider4 setFont: [UIFont LBSliderMedium]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 8]];
        [self.slider5 setFont: [UIFont LBSliderLarge]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 9]];
        [self.slider6 setFont: [UIFont LBSliderMedium]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 10]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 9) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 7]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 8]];
        [self.slider4 setFont: [UIFont LBSliderMedium]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 9]];
        [self.slider5 setFont: [UIFont LBSliderLarge]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 10]];
        [self.slider6 setFont: [UIFont LBSliderMedium]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 11]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 10) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 8]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 9]];
        [self.slider4 setFont: [UIFont LBSliderMedium]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 10]];
        [self.slider5 setFont: [UIFont LBSliderLarge]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 11]];
        [self.slider6 setFont: [UIFont LBSliderMedium]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 12]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 11) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 9]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 10]];
        [self.slider4 setFont: [UIFont LBSliderMedium]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 11]];
        [self.slider5 setFont: [UIFont LBSliderLarge]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 12]];
        [self.slider6 setFont: [UIFont LBSliderMedium]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 13]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 12) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"%i", 10]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 11]];
        [self.slider4 setFont: [UIFont LBSliderMedium]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 12]];
        [self.slider5 setFont: [UIFont LBSliderLarge]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 13]];
        [self.slider6 setFont: [UIFont LBSliderMedium]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 14]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"."]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 13) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 11]];
        [self.slider4 setFont: [UIFont LBSliderSmall]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 12]];
        [self.slider5 setFont: [UIFont LBSliderMedium]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 13]];
        [self.slider6 setFont: [UIFont LBSliderLarge]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 14]];
        [self.slider7 setFont: [UIFont LBSliderMedium]];
        [self.slider8 setText: [NSString stringWithFormat:@"%i", 15]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"."]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 14) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"%i", 12]];
        [self.slider4 setFont: [UIFont LBSliderSmall]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 13]];
        [self.slider5 setFont: [UIFont LBSliderMedium]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 14]];
        [self.slider6 setFont: [UIFont LBSliderLarge]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 15]];
        [self.slider7 setFont: [UIFont LBSliderMedium]];
        [self.slider8 setText: [NSString stringWithFormat:@"%i", 16]];
        [self.slider8 setFont: [UIFont LBSliderSmall]];
        [self.slider9 setText: [NSString stringWithFormat:@"."]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 15) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"."]];
        [self.slider4 setFont: [UIFont LBSliderSmall]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 13]];
        [self.slider5 setFont: [UIFont LBSliderSmall]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 14]];
        [self.slider6 setFont: [UIFont LBSliderMedium]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 15]];
        [self.slider7 setFont: [UIFont LBSliderLarge]];
        [self.slider8 setText: [NSString stringWithFormat:@"%i", 16]];
        [self.slider8 setFont: [UIFont LBSliderMedium]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 17]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 16) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"."]];
        [self.slider4 setFont: [UIFont LBSliderSmall]];
        [self.slider5 setText: [NSString stringWithFormat:@"%i", 14]];
        [self.slider5 setFont: [UIFont LBSliderSmall]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 15]];
        [self.slider6 setFont: [UIFont LBSliderMedium]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 16]];
        [self.slider7 setFont: [UIFont LBSliderLarge]];
        [self.slider8 setText: [NSString stringWithFormat:@"%i", 17]];
        [self.slider8 setFont: [UIFont LBSliderMedium]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderSmall]];
    } else if(holeNumber == 17) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"."]];
        [self.slider4 setFont: [UIFont LBSliderSmall]];
        [self.slider5 setText: [NSString stringWithFormat:@"."]];
        [self.slider5 setFont: [UIFont LBSliderSmall]];
        [self.slider6 setText: [NSString stringWithFormat:@"%i", 15]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 16]];
        [self.slider7 setFont: [UIFont LBSliderMedium]];
        [self.slider8 setText: [NSString stringWithFormat:@"%i", 17]];
        [self.slider8 setFont: [UIFont LBSliderLarge]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderMedium]];
    } else if(holeNumber == 18) {
        [self.slider1 setText: [NSString stringWithFormat:@"%i", 1]];
        [self.slider1 setFont: [UIFont LBSliderSmall]];
        [self.slider2 setText: [NSString stringWithFormat:@"."]];
        [self.slider2 setFont: [UIFont LBSliderSmall]];
        [self.slider3 setText: [NSString stringWithFormat:@"."]];
        [self.slider3 setFont: [UIFont LBSliderSmall]];
        [self.slider4 setText: [NSString stringWithFormat:@"."]];
        [self.slider4 setFont: [UIFont LBSliderSmall]];
        [self.slider5 setText: [NSString stringWithFormat:@"."]];
        [self.slider5 setFont: [UIFont LBSliderSmall]];
        [self.slider6 setText: [NSString stringWithFormat:@"."]];
        [self.slider6 setFont: [UIFont LBSliderSmall]];
        [self.slider7 setText: [NSString stringWithFormat:@"%i", 16]];
        [self.slider7 setFont: [UIFont LBSliderSmall]];
        [self.slider8 setText: [NSString stringWithFormat:@"%i", 17]];
        [self.slider8 setFont: [UIFont LBSliderMedium]];
        [self.slider9 setText: [NSString stringWithFormat:@"%i", 18]];
        [self.slider9 setFont: [UIFont LBSliderLarge]];
    }
}

- (void) handleGesture:(UILongPressGestureRecognizer *)gesture
{
    if([gesture state] == UIGestureRecognizerStateBegan)
    {
        // clear flightPath array
        [self.flightPathArray removeAllObjects];
        [self showErrorTitle:@"Navigation Instructions" withMessage:@"Double Tap to add shot \nSwipe left or right to move between holes"];
    }
    [[LBLocationManager sharedInstance] currentLocation];
    CGPoint location = [gesture locationInView:gesture.view];
    [self.flightPathArray addObject:[NSValue valueWithCGPoint:location]];
    if([gesture state] == UIGestureRecognizerStateEnded || [gesture state] == UIGestureRecognizerStateFailed)
    {
        self.holeScore++;
        [self decorateHoleScore];
        [self.holeScoreLabel setText: [NSString stringWithFormat: @"%i", self.holeScore]];
        [self hideError];
        //LBGolfShotProfile *shotProfile = [LBGolfShotProfiler profileShotWithPoints: self.flightPathArray];
    }
    // add score to hole @ gps location
}

- (IBAction) showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer
{
    self.holeScore++;
    [self.holeScoreLabel setText: [NSString stringWithFormat: @"%i", self.holeScore]];
    [self decorateHoleScore];
    [self hideError];
    // add score to hole @ gps location
}

- (void) oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer
{

    // go forward hole
    if(self.holePointer < [[[[LBDataManager sharedInstance] course] holeMap] count])
    {
        NSLog(@"storing the score %i for hole %i", self.holeScore, [self actualHoleNumber]);
        // set score in local memory
        [[LBDataManager sharedInstance] setScore: [NSNumber numberWithInt:self.holeScore] forHole: [NSNumber numberWithInt: self.holePointer]];
        // score hole to backend
        [LBRestFacade asynchScoreHoleWithHoleNumber: [self actualHoleNumber] WithHoleScore: self.holeScore WithScorecardId: [[[LBDataManager sharedInstance] scorecard] idString]];
        if(self.holePointer < ([[[[LBDataManager sharedInstance] course] holeMap] count]-1))
        {
            self.holePointer++;
            NSLog(@"going to hole %i", [self actualHoleNumber]);
            if([[LBDataManager sharedInstance] getScoreForHole: [NSNumber numberWithInt: self.holePointer]])
            {
                [self setHoleScore: [[NSNumber numberWithInteger:[[LBDataManager sharedInstance] getScoreForHole: [NSNumber numberWithInt: self.holePointer]]] intValue]];
            }
            else
            {
                self.holeScore = 0;
            }
            [self loadHoleIntoView: [[[LBDataManager sharedInstance] course] holeWithNumber: [self actualHoleNumber]]];
        }
        else
        {
            // segue to review
            if([LBScorecardUtils isScoreArrayComplete: [[LBDataManager sharedInstance] primaryScoreArray] forScorecard: [[LBDataManager sharedInstance] scorecard]]) {
                [self performSegueWithIdentifier:@"seg_shwsmmry" sender:self];
            } else {
                [self showErrorTitle: [NSString stringWithFormat: @"%@", @"Scorecard Incomplete"] withMessage: [NSString stringWithFormat: @"%@", @"Hole does not have a valid score\n"]];
                LBCourseHole *errorHole = [LBScorecardUtils firstIncompleteHole:[[LBDataManager sharedInstance] primaryScoreArray] forScorecard: [[LBDataManager sharedInstance] scorecard] orLastHole:NO];
                self.holePointer = ([errorHole.holeNumber intValue] - 1);
                [self loadHoleIntoView: errorHole];
            }
        }
    }
}

- (void) oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer
{
    // go back hole
    if(self.holePointer > 0)
    {
        NSLog(@"storing the score %i for hole %i", self.holeScore, [self actualHoleNumber]);
        // set score in local memory
        [[LBDataManager sharedInstance] setScore: [NSNumber numberWithInt:self.holeScore] forHole: [NSNumber numberWithInt: self.holePointer]];
        // score hole to backend
        [LBRestFacade asynchScoreHoleWithHoleNumber: 1 WithHoleScore: 1 WithScorecardId: [NSString stringWithFormat:@"%i", 1]];
        self.holePointer--;
        NSLog(@"going to hole %i", [self actualHoleNumber]);
        if([[LBDataManager sharedInstance] getScoreForHole: [NSNumber numberWithInt: self.holePointer]])
        {
            [self setHoleScore: [[NSNumber numberWithInteger:[[LBDataManager sharedInstance] getScoreForHole: [NSNumber numberWithInt: self.holePointer]]] intValue]];
        }
        else
        {
            self.holeScore = 0;
        }
        [self loadHoleIntoView: [[[LBDataManager sharedInstance] course] holeWithNumber: [self actualHoleNumber]]];
    }
    [self hideError];
}

- (void) addGestureRecognisers
{
    // Create and initialize a tap gesture
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGestureForTapRecognizer:)];
    self.tapRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:self.tapRecognizer];
    
    // Create and initialize swipe left gesture
    self.oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    [self.oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:self.oneFingerSwipeLeft];
    
    // Create and initialize swipe right gesture
    self.oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeRight:)];
    [self.oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:self.oneFingerSwipeRight];
    
    // Create and initialise the long press gesture
    self.lpGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer: self.lpGesture];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(int) actualHoleNumber
{
    return self.holePointer+1;
}

-(void) hideError
{
    [self.errorLabel setAlpha: 0];
    [self.errorMessage setAlpha: 0];
}

-(void) showErrorTitle: (NSString *)title withMessage: (NSString *) message
{
    [self.errorLabel setAlpha: 1];
    [self.errorMessage setAlpha: 1];
    [self.errorLabel setText: title];
    [self.errorMessage setText: message];
}

-(void) decorateHoleScore
{
    if(self.holeScore < (self.holePar - 1)) {
        // eagle
        [self.holeScoreLabel setFont: [UIFont LBHoleScoreEagle]];
        [self.holeScoreLabel setTextColor: [UIColor LBHoleScoreEagle]];
    } else if(self.holeScore < (self.holePar)) {
        // birdie
        [self.holeScoreLabel setFont: [UIFont LBHoleScoreBirdie]];
        [self.holeScoreLabel setTextColor: [UIColor LBHoleScoreBirdie]];
    } else if(self.holeScore == (self.holePar)) {
        // par
        [self.holeScoreLabel setFont:[UIFont LBHoleScorePar]];
        [self.holeScoreLabel setTextColor: [UIColor LBHoleScorePar]];
    } else if(self.holeScore == (self.holePar+1)) {
        // bogie
        [self.holeScoreLabel setFont:[UIFont LBHoleScoreBogie]];
        [self.holeScoreLabel setTextColor: [UIColor LBHoleScoreBogie]];
    } else if(self.holeScore == self.holePar+2) {
        // double bogie
        [self.holeScoreLabel setFont:[UIFont LBHoleScoreDBogie]];
        [self.holeScoreLabel setTextColor: [UIColor LBHoleScoreDBogie]];
    } else if (self.holeScore > self.holePar+2) {
        // double bogie+
        [self.holeScoreLabel setFont:[UIFont LBHoleScoreDBogiePlus]];
        [self.holeScoreLabel setTextColor: [UIColor LBHoleScoreDBogiePlus]];
    }
}

-(void) setHoleToView:(int)holeNumber
{
    [self setHolePointer:holeNumber];
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
        NSLog(@"orientation changed: returning to golf gaming");
        [self.navigationController popViewControllerAnimated:TRUE];
        isShowingLandscapeView = NO;
    }
}

@end
