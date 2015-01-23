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
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
}

+ (UIFont *) LBSliderMedium
{
    return [UIFont fontWithName:@"HelveticaNeue-Condensed" size:16];
}

+ (UIFont *) LBSliderLarge
{
    return[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
}

@end