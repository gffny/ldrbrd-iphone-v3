//
//  LBPlayerSummaryView.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 11/11/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBCompetitionRound.h"

@interface LBCompetitionRoundView : UIView

- (void) initialiseCompetitionRoundViewWithCompetition: (LBCompetitionRound *) competitionRound;

- (void) initaliseEmptyCompetitionRoundView;

- (void) addNextRoundHandler: (SEL) handlerMethod andTarget: (id) actionTarget;

- (void) addShowUpcomingRoundListHandler: (SEL) handlerMethod andTarget: (id) actionTarget;

@end
