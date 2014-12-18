//
//  LBDataManager.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/8/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBCourse.h"
#import "LBGolfer.h"
#import "LBScorecard.h"

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
@property (nonatomic, strong) NSArray *upcomingCompetitionEntryList;
@property (nonatomic, strong) NSArray<LBScorecard> *lastXScorecardList;


/* SINGLETON FACTORY METHODS */
+(LBDataManager*) sharedInstance;

/* SCORECARD METHODS */
-(void) resetScorecardData;
-(void) initialiseCourse: (LBCourse *) course;
-(void) setScore: (NSNumber *) holeScore forHole: (NSNumber *) holeNumber;
-(LBCourse *) course;

-(BOOL) isInRound;
-(NSInteger) getScoreForHole: (NSNumber *) holeNumber;

@end
