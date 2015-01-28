//
//  LBUIColour.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 3/26/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "UIColor+LBColours.h"

@implementation UIColor (LBColours)

+ (UIColor *)LBBlueColour
{
    static UIColor *darkBlueColour;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        darkBlueColour = [UIColor colorWithRed:14.0f/255.0f green:56.0f/255.0f blue:132.0f/255.0f alpha:1.0];
    });
    return darkBlueColour;
}

+ (UIColor *)LBGreyColour
{
    static UIColor *lightGreyColour;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lightGreyColour = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    });
    return lightGreyColour;
}

+ (UIColor *)LBOrangeColour
{
    static UIColor *lightYellowColour;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lightYellowColour = [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:0.0f/255.0f alpha:1.0];
    });
    return lightYellowColour;
}

+ (UIColor *) LBHoleScoreEagle
{
    static UIColor *lbHoleScoreEagle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbHoleScoreEagle = [UIColor colorWithRed:100.0f/255.0f green:150.0f/255.0f blue:50.0f/255.0f alpha:1.0];
    });
    return lbHoleScoreEagle;
}

+ (UIColor *) LBHoleScoreBirdie
{
    static UIColor *lbHoleScoreBirdie;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbHoleScoreBirdie = [UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:50.0f/255.0f alpha:1.0];
    });
    return lbHoleScoreBirdie;
}

+ (UIColor *) LBHoleScorePar
{
    static UIColor *lbHoleScorePar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbHoleScorePar = [UIColor colorWithRed:150.0f/255.0f green:125.0f/255.0f blue:0.0f/255.0f alpha:1.0];
    });
    return lbHoleScorePar;
}

+ (UIColor *) LBHoleScoreBogie
{
    static UIColor *lbHoleScoreBogie;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbHoleScoreBogie = [UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:40.0f/255.0f alpha:1.0];
    });
    return lbHoleScoreBogie;
}

+ (UIColor *) LBHoleScoreDBogie
{
    static UIColor *lbHoleScoreDBogie;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbHoleScoreDBogie = [UIColor colorWithRed:255.0f/255.0f green:100.0f/255.0f blue:0.0f/255.0f alpha:1.0];
    });
    return lbHoleScoreDBogie;
}

+ (UIColor *) LBHoleScoreDBogiePlus
{
    static UIColor *lbHoleScoreDBogiePlus;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbHoleScoreDBogiePlus = [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0];
    });
    return lbHoleScoreDBogiePlus;
}


@end
