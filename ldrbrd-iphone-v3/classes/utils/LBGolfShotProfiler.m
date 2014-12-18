//
//  LBGolfShotProfiler.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/1/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBGolfShotProfiler.h"

@implementation LBGolfShotProfiler

+ (LBGolfShotProfile) profileShotWithPoints: (NSArray *) pointArray {
    // get the first and last y coordinates, and the first x coordinate (that will be the vertical line used to compare the flight of the "ball")
    CGPoint firstPoint = [[pointArray objectAtIndex:0] CGPointValue];
    CGPoint lastPoint = [[pointArray lastObject] CGPointValue];

    if(firstPoint.y > lastPoint.y) {
        int height = firstPoint.y - lastPoint.y;
        NSMutableArray *comparisonMatrix = [[NSMutableArray alloc] initWithCapacity:7];

        // divine the n incremental points (probably 7) along the x-axis upon which the shot will be characterised
        // sequentially search through the pointsArray, to elicit the corresponding y-axis value for each intersection with the ball path
        
        // [y1 = y0+(height*0.3)]
        [comparisonMatrix addObject:[NSNumber numberWithInt:[self findXpointFor: firstPoint.y-(height*0.3) withPoints:pointArray]]];
        // [y2 = y0+(height*0.55)]
        [comparisonMatrix addObject:[NSNumber numberWithInt:[self findXpointFor: firstPoint.y-(height*0.55) withPoints:pointArray]]];
        // [y3 = y0+(height*0.7)]
        [comparisonMatrix addObject:[NSNumber numberWithInt:[self findXpointFor: firstPoint.y-(height*0.7) withPoints:pointArray]]];
        // [y4 = y0+(height*0.8)]
        [comparisonMatrix addObject:[NSNumber numberWithInt:[self findXpointFor: firstPoint.y-(height*0.8) withPoints:pointArray]]];
        // [y5 = y0+(height*0.9)]
        [comparisonMatrix addObject:[NSNumber numberWithInt:[self findXpointFor: firstPoint.y-(height*0.9) withPoints:pointArray]]];
        // [y6 = y0+(height*0.95)]
        [comparisonMatrix addObject:[NSNumber numberWithInt:[self findXpointFor: firstPoint.y-(height*0.95) withPoints:pointArray]]];
        // [y7 = y0+height]
        [comparisonMatrix addObject:[NSNumber numberWithInt:[self findXpointFor: firstPoint.y-(height) withPoints:pointArray]]];
        // compare the 1xn matrix of the ball flight profile, to a list of 1xn array of previously characterised ball flight profiles (straight, draw, fade, hook, slice, etc)
        return [self characterizeShotWithMatrix: comparisonMatrix];
    }
    return UNRECOGNIZED;
}

+ (LBGolfShotProfile) characterizeShotWithMatrix: (NSArray *) shotMatrix {
    // build a decision tree
    
    // if 1st point negative (left)
        // if 2nd point more left
            // if 3rd, 4th, 5th, 6th, 7th point continue left then STRAIGHT-LEFT..
            // if 3rd and 4th more left, but 5th, 6th, and 7th less left then PULL-FADE...
            // if 3rd and 4th marginally left or straight, but 5th, 6th, 7th increasingly left then PULL-DRAW
        //...
    //....
    return UNRECOGNIZED;
}

+ (int) findXpointFor: (CGFloat) y withPoints: (NSMutableArray *) pointArray {
    // go through the list of points and check if the point is within 5, then 4, 3, 2, 1 etc of the y, then trim the points array
    CGFloat initalX = [[pointArray objectAtIndex: 0] CGPointValue].x;
    for(int i=0; i < pointArray.count; i++) {
        // look back through the array!
        CGPoint potentialX = [[pointArray objectAtIndex:i] CGPointValue];
        if(potentialX.y - y < 15 && potentialX.y - y > 0) {
            //trim the array?
            if(i+1 < pointArray.count) {
                potentialX = [[pointArray objectAtIndex:i+1] CGPointValue];
                if(potentialX.y - y < 10 && potentialX.y - y > 0) {
                    if(i+2 < pointArray.count) {
                        potentialX = [[pointArray objectAtIndex:i+2] CGPointValue];
                        if(potentialX.y - y < 5 && potentialX.y - y > 0) {
                            NSLog(@"x axis %f y axis %f", [[pointArray objectAtIndex: i+2] CGPointValue].x - initalX, y);
                            return ([[pointArray objectAtIndex: i+2] CGPointValue].x - initalX);
                        }
                    }
                    NSLog(@"x axis %f y axis %f", [[pointArray objectAtIndex: i] CGPointValue].x - initalX, y);
                    return ([[pointArray objectAtIndex: i+1] CGPointValue].x - initalX);
                }
            }
            NSLog(@"x axis %f y axis %f", [[pointArray objectAtIndex: i] CGPointValue].x - initalX, y);
            return ([[pointArray objectAtIndex: i] CGPointValue].x - initalX);
        }
    }
    NSLog(@"couldn't find x coordinate for y %f", y);
    return 0;
}

@end
