//
//  LBRestFacade.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/8/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "LBCompetitionRound.h"

@interface LBRestFacade : NSObject

+(void) asynchBackendOnlineCheckWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+(void) asynchAuthenticateWithUsername:(NSString *) username andPassword:(NSString *) password withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

+(void) asynchStartScorecardOnCourse: (NSString *) courseId withSuccess: (void (^) (AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

+(void) asynchScoreHoleWithHoleNumber: (int) holeNumber WithHoleScore: (int) holeScore WithScorecardId: (NSString *) scorecardId;

+(void) asynchSubmitScorecard:(NSArray *) scorecard andScorecardId:(NSString *) scorecardId withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

+(void) asynchSgnScorecard:(NSString *) scorecardId withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

+(void) asynchRetrieveCourseListWithSuccess: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success AndFailure:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) failure;

+(void) asynchRetrieveGolferDigestWithSuccess: (void (^) (AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

+(void) asynchPlayNextUpcomingRound: (LBCompetitionRound *) competitionRound withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

@end
