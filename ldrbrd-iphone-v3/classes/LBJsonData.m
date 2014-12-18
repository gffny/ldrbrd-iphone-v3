//
//  LBJsonData.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/6/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBJsonData.h"

@implementation LBJsonData

+(NSDictionary *) courseJson {
 
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dummycoursedata" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSLog(@"%@", jsonDict);

    return jsonDict;
}

@end
