 //
//  LBPlayGolfNowVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 8/31/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBPlayGolfNowVC.h"
#import "LBRestFacade.h"
#import "LBPlayGolfVC.h"

@interface LBPlayGolfNowVC ()

@end

NSMutableArray *courseList;

@implementation LBPlayGolfNowVC

@synthesize coursePicker;
@synthesize courseName;
@synthesize parValue;
@synthesize teeColourValue;
@synthesize indexValue;
@synthesize descriptionValue;



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

    [LBRestFacade asynchRetrieveCourseListWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Retrieve Success %@", operation.responseString);
        if([responseObject isKindOfClass:[NSArray class]]) {
            // list of courses
            courseList = responseObject;
            [coursePicker reloadAllComponents];
            [self updateCourseInfo: [courseList objectAtIndex:0]];
            // todo update the dropdown menu of courses with the data here
        } else if ([responseObject isKindOfClass: [NSDictionary class]]) {
            // single course
            // todo update the course data in the view and disable the dropdown
        }
    } AndFailure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Retrieve Failure");
        // todo eh aaah
    }];

    [self.playGolfBtn addTarget:self action:@selector(playNowBtnClckd:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if(courseList != NULL) {
        return courseList.count;
    } else {
        return 0;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if(courseList != NULL) {
        return [[courseList objectAtIndex:row] valueForKey:@"name"];
    } else {
        return @"";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%@", [NSString stringWithFormat:@"Row Number %ld", row]);
    if(courseList != NULL) {
        [self updateCourseInfo: [courseList objectAtIndex: row]];
    }
}

-(void) updateCourseInfo: (NSDictionary *)course
{
    if(course != NULL) {
        [courseName setText: [self stringValueForCourse:course AndKey:@"name"]];
        [parValue setText: [self stringValueForCourse:course AndKey:@"par"]];
        [teeColourValue setText: [self stringValueForCourse:course AndKey:@"teeColour"]];
        [indexValue setText: [self stringValueForCourse:course AndKey:@"slopeIndex"]];
        [descriptionValue setText: @"name"];
    }
}

-(NSString *)stringValueForCourse: (NSDictionary *)course AndKey: (NSString *)key
{
    return [NSString stringWithFormat:@"%@", [course valueForKey: key]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    UIViewController *destVc = [segue destinationViewController];
    if([destVc isKindOfClass: [LBPlayGolfVC class]])
    {
        LBPlayGolfVC *playGolfVC = (LBPlayGolfVC *)destVc;
        [playGolfVC loadCourseInView: [[LBCourse alloc] init]];//initWithCourseDetails: [courseList objectAtIndex: [coursePicker selectedRowInComponent:0]]]];
    }
    // Pass the selected object to the new view controller.
}

- (void)playNowBtnClckd:(UIButton *)sender
{
    NSLog(@"play now button clicked");
    NSString *courseId = [[[LBCourse alloc] init] idString]; //initWithCourseDetails: [courseList objectAtIndex: [coursePicker selectedRowInComponent:0]]] courseId];
    [LBRestFacade asynchStartScorecardOnCourse: courseId withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            LBScorecard *scorecard = [[LBScorecard alloc] initWithDictionary:(NSDictionary*) responseObject error: nil];
            NSLog(@"Start Scorecard Success %@", [scorecard idString]);
            [[LBDataManager sharedInstance] setScorecard: scorecard];
            [self performSegueWithIdentifier:@"seg_plyrnd" sender:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Start Scorecard Failure");
    }];
}


@end
