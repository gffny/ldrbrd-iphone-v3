//
//  lbCourseHoleDto.h
//  Leaderboard
//
//  Created by John D. Gaffney on 2/4/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol LBCourseHole

@end

@interface LBCourseHole : JSONModel

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString<Optional> *version;
@property (strong, nonatomic) NSString *holeDistance;
@property (strong, nonatomic) NSString *holeDescription;
@property (strong, nonatomic) NSString *holeNumber;
@property (strong, nonatomic) NSString *holeImageId;
@property (strong, nonatomic) NSString *index;
@property (strong, nonatomic) NSString *par;
@property (strong, nonatomic) NSString<Ignore> *id;
@property (strong, nonatomic) NSString<Optional> *idString;

/*
 holeDescription = "Butter Brook GC 1";
 holeDistance = 517;
 holeImageId = " ";
 holeNumber = 1;
 id = "<null>";
 idString = "<null>";
 index = 8;
 name = "bbgc black1";
 par = 5;
 version = "<null>";
 */

@end
