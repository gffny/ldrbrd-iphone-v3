//
//  LBPlayerSummaryView.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 11/11/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBPlayerSummaryView.h"
#import "LBDataManager.h"
#import "LBCompetitionRoundView.h"
#import "LBCompetitionRound.h"

@implementation LBCompetitionRoundView

LBCompetitionRound *competitionRound;
UILabel *competitionName;
UILabel *courseName;
UILabel *date;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void) initialiseCompetitionRoundViewWithCompetition: (LBCompetitionRound *) compRoundToView{
    competitionRound = compRoundToView;
    competitionName = (UILabel *)[self viewWithTag:10];
    courseName = (UILabel *)[self viewWithTag:20];
    date = (UILabel *)[self viewWithTag:30];
    [courseName setText: competitionRound.course.courseName];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[competitionRound.startDateDT doubleValue]/1000];
    NSString *startDateStr = [startDate description];
    NSDate *teeTime = [NSDate dateWithTimeIntervalSince1970:[competitionRound.teeTimeDT doubleValue]/1000];
    NSString *teeTimeStr = [teeTime description];
    
    [competitionName setText: [NSString stringWithFormat:@"%@ (round %@)",(NSString *)[competitionRound.competition valueForKey:@"competitionName"], competitionRound.roundNumber]];
    [date setText:[NSString stringWithFormat:@"%@ %@", [startDateStr substringToIndex:10], [teeTimeStr substringWithRange:NSMakeRange(11, 5)]]];
}

- (void) initaliseEmptyCompetitionRoundView {
    
}

- (void) addNextRoundHandler: (SEL) handlerMethod andTarget: (id) actionTarget {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:actionTarget action:handlerMethod]];
}

- (void) addShowUpcomingRoundListHandler: (SEL) handlerMethod andTarget: (id) actionTarget {
    
}





@end
