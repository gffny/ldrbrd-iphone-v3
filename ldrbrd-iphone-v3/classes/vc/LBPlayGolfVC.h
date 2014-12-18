//
//  LBPlayGolfVC.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 4/25/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SWRevealViewController.h"
#import "LBDataManager.h"

@interface LBPlayGolfVC : UIViewController

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context;
- (void) loadCourseInView: (LBCourse *) courseToLoad;
- (void) setHoleToView: (int) holeNumber;

@end
