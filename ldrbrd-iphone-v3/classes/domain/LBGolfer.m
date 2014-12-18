//
//  LBGolfer.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 10/14/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBGolfer.h"

@implementation LBGolfer

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:
            @{ @"id" : @"golferId",
               @"idString" : @"idString",
               @"firstName" : @"firstName",
               @"lastName" : @"lastName",
               @"password" : @"password",
               @"emailAddress" : @"emailAddress",
               @"profileHandle" : @"profileHandle",
               @"profileImageRef" : @"profileImageRef",
               @"failedLoginAttemptsCount" : @"failedLoginAttemptsCount",
               @"favouriteCourseList" : @"favouriteCourseList",
               @"handDominanceValue" : @"handDominanceValue",
               @"handedness" : @"handedness",
               @"handicap" : @"handicap",
               @"lastLogin" : @"lastLogin",
               @"lastLoginDT" : @"lastLoginDT",
               @"enabled" : @"enabled"
            }];
}

+(LBGolfer*) golferWithFirstName: (NSString *) firstName andLastName: (NSString *)lastName andHandicap: (NSString *)handicap andLastRound: (NSString *)lastRound andProfileImageRef:(NSString *)url {
    
    LBGolfer *golfer = [[LBGolfer alloc] init];
    [golfer setFirstName: firstName];
    [golfer setLastName: lastName];
    [golfer setHandicap: handicap];
    [golfer setLastRoundDate: lastRound];
    [golfer setProfileImageRef: url];
    return golfer;
}

@end
