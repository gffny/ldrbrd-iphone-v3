//
//  lbCourseDto.h
//  Leaderboard
//
//  Created by John D. Gaffney on 2/4/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "LBCourseHole.h"

@protocol LBCourse

@end

@interface LBCourse : JSONModel

@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDictionary<Ignore> *club;
@property (strong, nonatomic) NSString *teeColour;
@property (strong, nonatomic) NSString *slopeIndex;
@property (strong, nonatomic) NSString *par;
@property (strong, nonatomic) NSArray<LBCourseHole, Optional> *courseHoleList;
@property (strong, nonatomic) NSString *courseName;
@property (strong, nonatomic) NSString<Optional> *courseImageRef;
@property (assign, nonatomic) NSString<Ignore> *nineHole;
@property (strong, nonatomic) NSDictionary<Ignore> *id;
@property (strong, nonatomic) NSString *idString;

-(NSMutableDictionary*) holeMap;

-(LBCourseHole*) holeWithNumber: (int) holeNumber;

@end
