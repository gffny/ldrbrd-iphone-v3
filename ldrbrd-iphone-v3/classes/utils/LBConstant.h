//
//  LBConstant.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/9/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//static NSString * const localBaseURL = @"http://172.27.7.84:8090/";
//static NSString * const restBaseURL = @"http://172.27.7.84:8090/rest/";
//static NSString * const restScorecardURL = @"http://172.27.7.84:8090/rest/scorecard/";

//static NSString * const localBaseURL = @"http://localhost:8080/";
//static NSString * const restBaseURL = @"http://localhost:8080/rest/";
//static NSString * const restScorecardURL = @"http://localhost:8080/rest/scorecard/";
//static NSString * const webLeaderboardUrl = @"http://localhost:3000/competition/1/round/1/";

static NSString * const localBaseURL = @"http://ec2-54-148-91-221.us-west-2.compute.amazonaws.com:8080/ldrbrd-rest-api/";
static NSString * const restBaseURL = @"http://ec2-54-148-91-221.us-west-2.compute.amazonaws.com:8080/ldrbrd-rest-api/rest/";
static NSString * const restScorecardURL = @"http://ec2-54-148-91-221.us-west-2.compute.amazonaws.com:8080/ldrbrd-rest-api/rest/scorecard/";
static NSString * const webLeaderboardUrl = @"http://ec2-54-148-91-221.us-west-2.compute.amazonaws.com:3000/competition/1/round/1/";

@interface LBConstant : NSObject

@end
