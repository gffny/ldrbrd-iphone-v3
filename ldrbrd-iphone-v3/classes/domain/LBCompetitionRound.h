//
//  LBCompetitionRound.h
//  Leaderboard
//
//  Created by John D. Gaffney on 2/4/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "LBCourse.h"

@protocol LBCompetitionRound

@end

@interface LBCompetitionRound : JSONModel

@property (strong, nonatomic) NSDictionary<Ignore> *id;
@property (strong, nonatomic) NSString *idString;
@property (strong, nonatomic) NSString *roundNumber;
@property (strong, nonatomic) NSDate<Optional> *startDate;
@property (strong, nonatomic) NSDate<Optional> *teeTime;
@property (strong, nonatomic) NSString<Optional> *startDateDT;
@property (strong, nonatomic) NSString<Optional> *teeTimeDT;
@property (strong, nonatomic) NSDictionary<Optional> *competition;
@property (strong, nonatomic) LBCourse<Optional> *course;
@property (strong, nonatomic) NSString<Optional> *complete;
@property (strong, nonatomic) NSDictionary<Optional> *scoringFormat;

@end
