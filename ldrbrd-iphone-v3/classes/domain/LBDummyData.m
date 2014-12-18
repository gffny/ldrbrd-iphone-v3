//
//  LBDummyData.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/7/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBDummyData.h"
#import "LBJsonData.h"

@implementation LBDummyData

+ (LBCourse *) dummyCourse {
//    LBCourse *course = [LBCourse courseWithProperties: [LBJsonData courseJson]];
//    [course setCourseName: @"Fresh Pond"];
    return [[LBCourse alloc] init];
}

@end
