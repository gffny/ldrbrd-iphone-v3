//
//  LBDataManager.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/8/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBDataManager.h"

@interface LBDataManager ()

// hidden from other classes 
@property (nonatomic, retain) LBCourse *courseInPlay;

@end

@implementation LBDataManager

+(LBDataManager*) sharedInstance
{
    //Singleton Pattern courtesy of http://www.raywenderlich.com/46988/ios-design-patterns
    static LBDataManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LBDataManager alloc] init];
    });
    return _sharedInstance;
}

-(id) init
{
    self = [super init];
    if(self)
    {
        // set the the arrays!
    }
    return self;
}

-(void) resetScorecardData
{
    
    _courseInPlay = NULL;
    _primaryScoreArray = NULL;
    _scorecard = NULL;
}

-(void) initialiseCourse: (LBCourse *) course
{
    if(self)
    {
        _courseInPlay = course;
        _primaryScoreArray = [self initialiseScoreArray: course.courseHoleList.count];
    }
}

-(LBCourse *) course
{
    if(_scorecard != NULL && _scorecard.course != NULL)
    {
        return _scorecard.course;
    }
    else
    {
        return _courseInPlay;
    }
}

-(BOOL) isInRound
{
    if(_scorecard != NULL && _primaryScoreArray != NULL)
    {
        return YES;
    }
    return NO;
}

-(void) loadScoreArray: (NSArray *) holeScoreArray
{
    //is the holeScoreArray valid?
    if(holeScoreArray != NULL && holeScoreArray.count > 0) {
        // iterate through the array, setting the score for each hole
        for(int holeNumber = 0; holeNumber < holeScoreArray.count; holeNumber ++)
        {
            [self setScore: (NSNumber *) holeScoreArray[holeNumber] forHole: [NSNumber numberWithInt:holeNumber]];
        }
    }
}

-(NSInteger) getScoreForHole: (NSNumber *) holeNumber
{
    if(_primaryScoreArray != NULL && [holeNumber intValue] <= _primaryScoreArray.count)
    {
        NSNumber *score = [_primaryScoreArray objectAtIndex: [holeNumber integerValue]];
        return [score integerValue];
    }
    return [[NSNumber numberWithInt: 0] integerValue];
}

-(void) setScore: (NSNumber *) holeScore forHole: (NSNumber *) holeNumber
{
    if(_primaryScoreArray == NULL) {
        if(_scorecard.course != NULL && _scorecard.course.courseHoleList != NULL) {
            _primaryScoreArray = [self initialiseScoreArray: _scorecard.course.courseHoleList.count];
        } else {
            _primaryScoreArray = [self initialiseScoreArray: 18];
        }
    }
    [_primaryScoreArray replaceObjectAtIndex: [holeNumber integerValue] withObject: holeScore];
}

-(void) resetGolferScoreArray
{
    
}

-(NSMutableArray *) initialiseScoreArray: (long) size
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity: size];
    for(int i=0;i<size;i++)
    {
        [array setObject:[NSNumber numberWithInt:0] atIndexedSubscript:i];
    }
    return array;
}

-(void) handleGolferDigest:(NSDictionary *)golferDigest {
    //parse the json golfer profile digest response (profile, upcoming rounds (comp and non comp), existing scorecard, etc)
    LBGolfer* golferProfile = [[LBGolfer alloc] initWithDictionary:(NSDictionary *)[golferDigest objectForKey:@"golfer"] error:nil];
    [[LBDataManager sharedInstance] setGolferProfile:golferProfile];
    
    // parse golfer favourite course list
    
    NSArray<LBCourse>* favouriteCourseList = (NSArray<LBCourse>*)[LBCourse arrayOfModelsFromDictionaries:(NSArray*)[golferDigest objectForKey:@"favouriteCourseList"]];
    [[LBDataManager sharedInstance] setFavouriteCourseList:favouriteCourseList];
    
    // parse upcoming competitions list
    NSArray<LBCompetitionRound> *upcomingCompetitionRoundList = (NSArray<LBCompetitionRound>*)[LBCompetitionRound arrayOfModelsFromDictionaries:(NSArray*)[golferDigest objectForKey:@"upcomingCompetitionRoundList"]];
    [[LBDataManager sharedInstance] setUpcomingCompetitionRoundList: upcomingCompetitionRoundList];
    
    // parse last x scorecards list
    NSArray<LBScorecard> *lastXScorecardList = (NSArray<LBScorecard>*)[[NSArray alloc] initWithArray: (NSArray<LBScorecard>*)[golferDigest objectForKey:@"lastXScorecardList"]];
    [[LBDataManager sharedInstance] setLastXScorecardList: lastXScorecardList];
    
    // parse upcoming non-competition-round list
    NSArray *upcomingNonCompetitionRoundList = [[NSArray alloc] initWithArray: (NSArray*)[golferDigest objectForKey:@"upcomingNonCompetitionRoundList"]];
    [[LBDataManager sharedInstance] setUpcomingNonCompetitionRoundList: upcomingNonCompetitionRoundList];
    
    // check if there's an active scorecard
    LBScorecard *activeScorecard = [[LBScorecard alloc] initWithDictionary:[golferDigest objectForKey:@"activeScorecard"] error:nil];
    [[LBDataManager sharedInstance] setScorecard: activeScorecard];
}

@end
