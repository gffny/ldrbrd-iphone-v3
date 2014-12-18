//
//  LBPlayerSummaryView.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 11/11/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBPlayerSummaryView.h"

@implementation LBPlayerSummaryView

UIImageView *playerImageView;
UILabel *playerName;
UILabel *playerDetails;
UIButton *addEditButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) initialisePlayerViewWithName: (NSString *) name AndDetail: (NSString *) detail AndImageUrl: (NSString *) url {
    playerImageView = (UIImageView *)[self viewWithTag:10];
    playerImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    playerImageView.hidden = FALSE;
    playerName = (UILabel*)[self viewWithTag:20];
    playerName.text = name;
    playerName.hidden = FALSE;
    playerDetails = (UILabel*)[self viewWithTag:30];
    playerDetails.text = detail;
    playerDetails.hidden = FALSE;
    addEditButton = (UIButton*)[self viewWithTag:40];
    addEditButton.hidden = TRUE;
}

- (void) initaliseEmptyPlayerView {
    playerImageView = (UIImageView *)[self viewWithTag:10];
    playerImageView.hidden = TRUE;
    playerName = (UILabel*)[self viewWithTag:20];
    playerName.hidden = TRUE;
    playerDetails = (UILabel*)[self viewWithTag:30];
    playerDetails.hidden = TRUE;
    addEditButton = (UIButton*)[self viewWithTag:40];
    addEditButton.hidden = TRUE;
}

- (void) addButtonHandler: (SEL) handlerMethod andTarget: (id) actionTarget {
    [(UIButton*)[self viewWithTag:40] addTarget:actionTarget action:handlerMethod forControlEvents:UIControlEventTouchUpInside];
}

- (void) showAddEditButton {
    [(UIButton*)[self viewWithTag:40] setHidden: FALSE];
}

- (void) hideAddEditButton {
    [(UIButton*)[self viewWithTag:40] setHidden:TRUE];
}



@end
