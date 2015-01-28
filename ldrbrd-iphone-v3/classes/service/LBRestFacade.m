//
//  LBRestFacade.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/8/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBRestFacade.h"
#import "LBConstant.h"
#import "LBDataManager.h"
#import "LBGolfer.h"
#import "LBCourse.h"
#import "LBScorecard.h"
#import "LBCompetitionRound.h"

@implementation LBRestFacade

+(void) asynchBackendOnlineCheckWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    //Check if the backend is online
    
    //TODO Make the following four lines into a method
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager setRequestSerializer: requestSerializer];

    NSLog(@"%@", [NSString stringWithFormat: @"checking that %@health is online", restBaseURL]);
    [manager GET:[NSString stringWithFormat:@"%@health", restBaseURL] parameters:Nil success: success failure: failure];
}

+(void) asynchAuthenticateWithUsername:(NSString *) username andPassword:(NSString *) password withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successMethod failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure
{
    //TODO Make the following four lines into a method
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager setRequestSerializer: requestSerializer];
    
    [manager POST:[NSString stringWithFormat:@"%@j_spring_security_check?j_username=%@&j_password=%@", localBaseURL, username, password] parameters:Nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [LBRestFacade asynchRetrieveGolferDigestWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {

            //parse the json golfer profile digest response (profile, upcoming rounds (comp and non comp), existing scorecard, etc)
            [[LBDataManager sharedInstance] handleGolferDigest: (NSDictionary*)responseObject];
            // since this is loaded from the login, it will not need to be loaded again when the menu loads
            [[LBDataManager sharedInstance] setFirstLoad: true];
           
            successMethod(operation, responseObject);
        }
        failure:failure];
        
    } failure:failure];

}

+(void) asynchRetrieveGolferDigestWithSuccess: (void (^) (AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure {

    // do post login, load user profile, etc
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager setRequestSerializer: requestSerializer];
    [manager POST:[NSString stringWithFormat:@"%@profile/digest", restBaseURL] parameters:Nil success: success failure: failure];
}

+(void) asynchStartScorecardOnCourse: (NSString *) courseId withSuccess: (void (^) (AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure
{
    //TODO Make the following four lines into a method
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager setRequestSerializer: requestSerializer];

    
    [manager POST:[NSString stringWithFormat:@"%@start?courseId=%@", restScorecardURL, courseId] parameters:Nil success:success failure:failure];
}

+(void) asynchScoreHoleWithHoleNumber: (int) holeNumber WithHoleScore: (int) holeScore WithScorecardId: (NSString *) scorecardId
{
    //TODO REMOVE || YES when the NSUserDefaults is fixed!
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"continualScoring"] || YES) {
        // if continual scoring is turned on
        NSLog(@"Scoring hole %i for scorecard %@ with score %i", holeNumber, scorecardId, holeScore);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager setRequestSerializer: requestSerializer];
        
        [manager POST:[NSString stringWithFormat:@"%@scorehole?scorecardId=%@&holeNumber=%i&holeScore=%i", restScorecardURL, scorecardId, holeNumber, holeScore] parameters:Nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"score hole success; hole number %i - hole score %i - scorecard id %@", holeNumber, holeScore, scorecardId);

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"score hole failure");
            
        }];

    } else {
        NSLog(@"continual scoring is turned off");
    }
}

+(void) asynchSubmitScorecard:(NSArray *) scorecard andScorecardId:(NSString *) scorecardId withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure
{
    //TODO Make the following four lines into a method
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager setRequestSerializer: requestSerializer];
    
    NSMutableDictionary *scorecardSubmission = [[NSMutableDictionary alloc] init];
    [scorecardSubmission setObject:scorecard forKey:@"scorecardArray"];
    [scorecardSubmission setObject:scorecardId forKey:@"scorecardId"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:scorecardSubmission options:kNilOptions error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON String: %@", jsonString);

    [manager POST:[NSString stringWithFormat: @"%@submit", restScorecardURL] parameters:scorecardSubmission success:success failure:failure];
}

+(void) asynchSgnScorecard:(NSString *) scorecardId withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure {
    //TODO Make the following four lines into a method
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager setRequestSerializer: requestSerializer];
    
    NSMutableDictionary *scorecardSubmission = [[NSMutableDictionary alloc] init];
    [scorecardSubmission setObject:scorecardId forKey:@"scorecardId"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:scorecardSubmission options:kNilOptions error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON String: %@", jsonString);
    
    [manager POST:[NSString stringWithFormat:@"%@sign", restScorecardURL] parameters:scorecardSubmission success:success failure:failure];
}

+(void) asynchRetrieveCourseListWithSuccess:(void (^)(AFHTTPRequestOperation *, id)) success AndFailure :(void (^)(AFHTTPRequestOperation *, id))failure {
    
}

+(void) asynchPlayNextUpcomingRound: (LBCompetitionRound *) competitionRound withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure {
    NSLog(@"playing next competition round");
    //TODO Make the following four lines into a method
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager setRequestSerializer: requestSerializer];

    [manager POST:[NSString stringWithFormat:@"%@competition?competitionRoundId=%@", restScorecardURL, competitionRound.idString] parameters:Nil success:success failure:failure];
}


@end
