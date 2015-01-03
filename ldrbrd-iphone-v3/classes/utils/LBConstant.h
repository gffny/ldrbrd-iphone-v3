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

static NSString * const localBaseURL = @"http://localhost:8080/";
static NSString * const restBaseURL = @"http://localhost:8080/rest/";
static NSString * const restScorecardURL = @"http://localhost:8080/rest/scorecard/";
static NSString * const webLeaderboardUrl = @"http://localhost:3000/competition/1/round/1/";

//static NSString * const localBaseURL = @"http://ec2-54-165-223-127.compute-1.amazonaws.com:8090/ldrbrd/";
//static NSString * const restBaseURL = @"http://ec2-54-165-223-127.compute-1.amazonaws.com:8090/ldrbrd/rest/";
//static NSString * const restScorecardURL = @"http://ec2-54-165-223-127.compute-1.amazonaws.com:8090/ldrbrd/rest/scorecard/";


@interface LBConstant : NSObject

@end
