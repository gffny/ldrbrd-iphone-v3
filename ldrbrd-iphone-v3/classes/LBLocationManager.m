//
//  LBLocationManager.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/20/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBLocationManager.h"

@implementation LBLocationManager

+(LBLocationManager*) sharedInstance
{
    //Singleton Pattern courtesy of http://www.raywenderlich.com/46988/ios-design-patterns
    static LBLocationManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{_sharedInstance = [[LBLocationManager alloc] init];
    });
    return _sharedInstance;
}

-(void) currentLocation {
    //CLLocation *location = [locationManager location];
    NSLog(@"Detected Location : %f, %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
}

-(id) init {

    self = [super init];
    if(self) {

        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    }
    return self;
}

#pragma mark CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = [locations objectAtIndex:0];
}

@end
