//
//  LBScorecardUtils.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/12/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBScorecard.h"
#import "LBCourse.h"

@interface LBScorecardUtils : NSObject

+(BOOL) isScoreArrayComplete: (NSMutableArray *) scoreArray forScorecard: (LBScorecard *) scorecard;

+(LBCourseHole *) firstIncompleteHole: (NSArray *) scoreArray forScorecard: (LBScorecard *) scorecard orLastHole: (BOOL) sendLastHole;

+(int) countScore: (NSArray*) scoreArray;

+(int) countBelowPar: (NSArray*) scoreArray onCourse: (LBCourse *) course;

+(int) countBogeyPlus: (NSArray*) scoreArray onCourse: (LBCourse *) course;

+(int) countBogey: (NSArray*) scoreArray onCourse: (LBCourse *) course;

+(int) countPar: (NSArray*) scoreArray onCourse: (LBCourse *) course;

+(NSArray<LBCourse> *) distinctCourseListFromScorecardArray: (NSArray<LBScorecard> *) scorecardList;

@end