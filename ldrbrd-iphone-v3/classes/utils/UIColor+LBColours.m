//
//  lbUIColour.m
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

@end
