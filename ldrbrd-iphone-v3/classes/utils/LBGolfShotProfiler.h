//
//  LBGolfShotProfiler.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/1/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBGolfShotProfiler : NSObject

typedef enum {
    PULLDRAW, PULL, PULLFADE, STRAIGHTDRAW, STRAIGHT, STRAIGHTFADE, PUSHDRAW, PUSH, PUSHFADE, UNRECOGNIZED
} LBGolfShotProfile;

+ (LBGolfShotProfile) profileShotWithPoints: (NSArray *) pointArray;

+ (LBGolfShotProfile) characterizeShotWithMatrix: (NSArray *) shotMatrix;

+ (int) findXpointFor: (CGFloat) y withPoints: (NSArray *) pointArray;

@end
