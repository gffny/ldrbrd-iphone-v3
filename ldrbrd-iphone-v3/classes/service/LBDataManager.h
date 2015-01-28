//
//  LBDataManager.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/8/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SWRevealViewController.h"
#import "LBScorecard.h"
#import "LBCourse.h"
#import "LBGolfer.h"
#import "LBCompetitionRound.h"

@interface LBDataManager : NSObject

/* SCORECARD INFO */
@property (nonatomic, strong) LBScorecard *scorecard;
@property (nonatomic, strong) NSMutableArray *primaryScoreArray;
@property (nonatomic, strong) NSMutableArray *glfr1ScoreArray;
@property (nonatomic, strong) NSMutableArray *glfr2ScoreArray;
@property (nonatomic, strong) NSMutableArray *glfr3ScoreArray;
@property (nonatomic, strong) NSMutableArray<LBGolfer> *golferArray;

/* GOLFER INFO */
@property (nonatomic, strong) LBGolfer *golferProfile;
@property (nonatomic, strong) NSDictionary *golfClubArray;
@property (nonatomic, strong) NSDictionary *newsItemArray;

/* LIST INFO */
@property (nonatomic, strong) NSArray<LBCourse> *favouriteCourseList;
@property (nonatomic, strong) NSArray *upcomingNonCompetitionRoundList;
@property (nonatomic, strong) NSArray<LBCompetitionRound> *upcomingCompetitionRoundList;
@property (nonatomic, strong) NSArray<LBScorecard> *lastXScorecardList;

@property (nonatomic) BOOL firstLoad;


/* SINGLETON FACTORY METHODS */
+(LBDataManager*) sharedInstance;

/* SCORECARD METHODS */
-(void) resetScorecardData;
-(void) initialiseCourse: (LBCourse *) course;
-(void) setScore: (NSNumber *) holeScore forHole: (NSNumber *) holeNumber;
-(LBCourse *) course;

-(BOOL) isInRound;
-(void) loadScoreArray: (NSArray *) holeScoreArray;
-(NSInteger) getScoreForHole: (NSNumber *) holeNumber;

-(void) handleGolferDigest: (NSDictionary *) golferDigest;

@end
