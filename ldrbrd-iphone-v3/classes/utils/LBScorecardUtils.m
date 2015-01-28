//
//  LBScorecardUtils.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/12/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBScorecardUtils.h"

@implementation LBScorecardUtils

+(BOOL) isScoreArrayComplete: (NSMutableArray *) scoreArray forScorecard: (LBScorecard *) scorecard {
    // check if the scorecard is valid
    if(scoreArray != NULL) {
        // check each hole is not 0
        for(int i = 0; i<scoreArray.count; i++) {
            if(((int)[[scoreArray objectAtIndex:i] integerValue]) < 1) {
                return FALSE;
            }
        }
        // check that the score array and course hole count match
        if(scorecard != NULL && scorecard.course != NULL && scorecard.course.courseHoleList != NULL && scorecard.course.courseHoleList.count != scoreArray.count) {
                return FALSE;
        }
        return TRUE;
    }
    return FALSE;
}

+(LBCourseHole *) firstIncompleteHole: (NSArray *) scoreArray forScorecard: (LBScorecard *) scorecard orLastHole: (BOOL) sendLastHole
{
    // check if the scorecard is valid
    if(scoreArray != NULL && scorecard != NULL && scorecard.course != NULL && scorecard.course.courseHoleList != NULL) {
        // check each hole is not 0
        for(int i = 0; i<scoreArray.count; i++) {
            if((int)[[scoreArray objectAtIndex:i] intValue] < 1 ) {
                return [scorecard.course.courseHoleList objectAtIndex: i];
            } else if (i == scorecard.course.courseHoleList.count && sendLastHole) {
                return [scorecard.course.courseHoleList lastObject];
            }
        }
        // if none of the scoreArray holes are incomplete, is the courseHoleList length = scoreArray length?
        if(scoreArray.count < scorecard.course.courseHoleList.count) {
            return [scorecard.course.courseHoleList objectAtIndex: scoreArray.count];
        }
    }
    return nil;
}

+(int) countScore: (NSArray *) scoreArray {
    int countVal = 0;
    for(int i=0; i<scoreArray.count; i++) {
        countVal += [[scoreArray objectAtIndex:i] integerValue];
    }
    return countVal;
}

+(int) countBelowPar: (NSArray*) scoreArray onCourse: (LBCourse *) course {
    // check the params are not null
    if(scoreArray != NULL && course != NULL && course.courseHoleList != NULL) {
        // check that the scorecard score array and the course hole list count match
        if(scoreArray.count <= course.courseHoleList.count) {
            // initialise a count and start counting
            int count = 0;
            for(int i=0; i<scoreArray.count; i++) {

                if([[scoreArray objectAtIndex:i] integerValue] - [[[course holeWithNumber:i+1] par] integerValue] < 0) {
                    count+=1;
                }
            }
            return count;
        }
    }
    return -1;
}

+(int) countPar: (NSArray*) scoreArray onCourse: (LBCourse *) course {
    // check the params are not null
    if(scoreArray != NULL && course != NULL && course.courseHoleList != NULL) {
        // check that the scorecard score array and the course hole list count match
        if(scoreArray.count <= course.courseHoleList.count) {
            // initialise a count and start counting
            int count = 0;
            for(int i=0; i<scoreArray.count; i++) {
                
                if([[scoreArray objectAtIndex:i] integerValue] - [[[course holeWithNumber:i+1] par] integerValue] == 0) {
                    count+=1;
                }
            }
            return count;
        }
    }
    return -1;
}

+(int) countBogey: (NSArray*) scoreArray onCourse: (LBCourse *) course {
    // check the params are not null
    if(scoreArray != NULL && course != NULL && course.courseHoleList != NULL) {
        // check that the scorecard score array and the course hole list count match
        if(scoreArray.count <= course.courseHoleList.count) {
            // initialise a count and start counting
            int count = 0;
            for(int i=0; i<scoreArray.count; i++) {
                
                if([[scoreArray objectAtIndex:i] integerValue] - [[[course holeWithNumber:i+1] par] integerValue] == 1) {
                    count+=1;
                }
            }
            return count;
        }
    }
    return -1;
}

+(int) countBogeyPlus: (NSArray*) scoreArray onCourse: (LBCourse *) course {
    // check the params are not null
    if(scoreArray != NULL && course != NULL && course.courseHoleList != NULL) {
        // check that the scorecard score array and the course hole list count match
        if(scoreArray.count <= course.courseHoleList.count) {
            // initialise a count and start counting
            int count = 0;
            for(int i=0; i<scoreArray.count; i++) {
                
                if([[scoreArray objectAtIndex:i] integerValue] - [[[course holeWithNumber:i+1] par] integerValue] > 1) {
                    count+=1;
                }
            }
            return count;
        }
    }
    return -1;
}

+(NSArray<LBCourse> *) distinctCourseListFromScorecardArray: (NSArray<LBScorecard> *) scorecardList
{
    NSMutableArray<LBCourse> *distinctCourseList = (NSMutableArray<LBCourse> *)[[NSMutableArray alloc] init];
    // iterate through the scorecard list
    for(LBScorecard *scorecard in scorecardList) {
        // check if the scorecard and it's course are not null
        if(scorecard != NULL && scorecard.course != NULL && ![distinctCourseList containsObject:scorecard.course]) {
            [distinctCourseList addObject:scorecard.course];
        }
    }
    return distinctCourseList;
}


@end
