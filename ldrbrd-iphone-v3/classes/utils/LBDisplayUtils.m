//
//  LBDisplayUtils.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/12/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBDisplayUtils.h"
#import "UIColor+LBColours.h"

@implementation LBDisplayUtils

+(void)disableButton: (UIButton *)button {
    button.enabled = NO;
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

+(void)reenableButton: (UIButton *)button {
    button.enabled = YES;
    [button setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
}

@end
