//
//  LBLocationManager.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/20/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBLocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

+(LBLocationManager*) sharedInstance;

-(void) currentLocation;

@end
