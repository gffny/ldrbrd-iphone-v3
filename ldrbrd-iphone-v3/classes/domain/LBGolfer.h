//
//  LBGolfer.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 10/14/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "JSONModel.h"
#import "LBCourse.h"

@protocol LBGolfer
@end

@interface LBGolfer : JSONModel

@property (strong, nonatomic) NSString *golferId;// = 1;
@property (strong, nonatomic) NSString<Ignore> *idString;
@property (strong, nonatomic) NSString *firstName;// = John;
@property (strong, nonatomic) NSString *lastName;// = Gaffney;
@property (strong, nonatomic) NSString<Ignore> *password;// = "<null>";
@property (strong, nonatomic) NSString *emailAddress;//= "gaffney.ie@gmail.com";
@property (strong, nonatomic) NSString *profileHandle;// = gffny;
@property (strong, nonatomic) NSString<Optional> *profileImageRef;// = "<null>";

@property (assign, nonatomic) NSString<Optional> *enabled;// = 1;
@property (strong, nonatomic) NSString *failedLoginAttemptsCount;// = 0;
@property (strong, nonatomic) NSArray<Ignore> *favouriteCourseList;// = "<null>";
@property (strong, nonatomic) NSString<Ignore> *handDominanceValue;// = RIGHT;
@property (strong, nonatomic) NSString *handedness;// = RIGHT;
@property (strong, nonatomic) NSString *handicap;// = 26;

@property (strong, nonatomic) NSString<Optional> *lastLogin;// = "<null>";
@property (strong, nonatomic) NSString<Ignore> *lastLoginDT;// = "<null>";
@property (strong, nonatomic) NSString<Optional> *lastRoundDate;

+(LBGolfer*) golferWithFirstName: (NSString *) firstName andLastName: (NSString *)lastName andHandicap: (NSString *)handicap andLastRound: (NSString *)lastRound andProfileImageRef: (NSString *) url;

@end
