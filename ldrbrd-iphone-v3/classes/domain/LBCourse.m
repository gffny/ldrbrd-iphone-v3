//
//  lbCourseDto.m
//  Leaderboard
//
//  Created by John D. Gaffney on 2/4/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBCourse.h"
#import "LBCourseHole.h"

@implementation LBCourse

NSMutableDictionary *courseHoleMap;

-(NSMutableDictionary*) holeMap
{
    if(!courseHoleMap)
    {
        courseHoleMap = [[NSMutableDictionary alloc] init];
        for (LBCourseHole *courseHole in self.courseHoleList)
        {
            [courseHoleMap setObject:courseHole forKey: [courseHole holeNumber]];
        }
    }
    return courseHoleMap;
}

-(LBCourseHole*) holeWithNumber: (int) holeNumber
{
    if(!courseHoleMap)
    {
        courseHoleMap = [self holeMap];
    }
    return [courseHoleMap objectForKey: [NSString stringWithFormat: @"%i", holeNumber]];
}

@end
