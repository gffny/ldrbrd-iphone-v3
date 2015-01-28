//
//  lbMainVC.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 3/30/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBMainVC : UIViewController<UITableViewDelegate, UITableViewDataSource,  UIScrollViewDelegate, UIAlertViewDelegate> {
    
    IBOutlet UIScrollView *scroller;
}

-(void) playUpcomingRoundWithId: (NSString *) roundId;

@end

