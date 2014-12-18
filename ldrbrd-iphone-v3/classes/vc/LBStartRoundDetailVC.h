//
//  LBCourseSelectScrnTwoVC.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 11/6/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBCourseDescription.h"
#import "LBPlayerSummaryView.h"

@interface LBStartRoundDetailVC : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet LBCourseDescription *courseDetail;
@property (strong, nonatomic) IBOutlet LBPlayerSummaryView *firstPlayerSummary;
@property (strong, nonatomic) IBOutlet LBPlayerSummaryView *secondPlayerSummary;
@property (strong, nonatomic) IBOutlet LBPlayerSummaryView *thirdPlayerSummary;
@property (strong, nonatomic) IBOutlet LBPlayerSummaryView *fourthPlayerSummary;
@property (strong, nonatomic) IBOutlet UIButton *startRoundButton;

@property (nonatomic) CGFloat previousScrollViewYOffset;

@end
