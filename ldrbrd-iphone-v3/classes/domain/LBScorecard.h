//
//  LBScorecard.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 10/13/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SWRevealViewController.h"
#import "JSONModel.h"
#import "LBCourse.h"

@protocol LBScorecard

@end

@interface LBScorecard : JSONModel

@property NSString<Ignore> *id;
@property NSString *idString;
@property NSString *courseDocumentId;
@property LBCourse *course;
@property NSString *roundDate;
@property NSArray *holeScoreArray;
@property NSString<Ignore> *roundDateDT;
@property NSString<Optional> *active;
@property NSString<Optional> *handicap;
@property NSString<Optional> *conditions;
@property NSString<Optional> *scorecardNotes;

@end
