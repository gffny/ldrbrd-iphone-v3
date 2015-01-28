//
//  UIFont+LBFont.m
//  ldrbrd-iphone-v3
//
//  Created by John D. Gaffney on 1/22/15.
//  Copyright (c) 2015 John D. Gaffney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIFont+LBFont.h"

@implementation UIFont (LBFont)


+ (UIFont *) LBSliderSmall;
{
    static UIFont *lbSliderSmall;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbSliderSmall = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
    });
    return lbSliderSmall;
}

+ (UIFont *) LBSliderMedium
{
    static UIFont *lbSliderMedium;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbSliderMedium = [UIFont fontWithName:@"HelveticaNeue-Condensed" size:16];
    });
    return lbSliderMedium;
}

+ (UIFont *) LBSliderLarge
{
    static UIFont *lbSliderLarge;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbSliderLarge = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    });
    return lbSliderLarge;
    
}

+ (UIFont *) LBHoleScoreBasic
{
    static UIFont *lbHoleScoreBasic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lbHoleScoreBasic = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:80];
    });
    return lbHoleScoreBasic;
}

+ (UIFont *) LBHoleScoreEagle
{
    return [UIFont LBHoleScoreBasic];
}

+ (UIFont *) LBHoleScoreBirdie
{
    return [UIFont LBHoleScoreBasic];
}

+ (UIFont *) LBHoleScorePar
{
    return [UIFont LBHoleScoreBasic];
}

+ (UIFont *) LBHoleScoreBogie
{
    return [UIFont LBHoleScoreBasic];
}

+ (UIFont *) LBHoleScoreDBogie
{
    return [UIFont LBHoleScoreBasic];
}

+ (UIFont *) LBHoleScoreDBogiePlus
{
    return [UIFont LBHoleScoreBasic];
}

@end