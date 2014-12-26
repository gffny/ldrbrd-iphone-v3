//
//  LBUserDefaults.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/8/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBUserDefaults.h"

@interface LBUserDefaults ()

@end

@implementation LBUserDefaults 

-(id) init
{
    self = [super init];
    if(self)
    {
        // set the the arrays!
    }
    return self;
}

+(NSUserDefaults *) instance
{
    return [[NSUserDefaults alloc] initWithSuiteName:@"group.com.gffny.ldrbrd"];
}

+(BOOL) continualScoring  {
    return [[[LBUserDefaults instance] objectForKey:@"continualScoring"] boolValue];
}

@end
