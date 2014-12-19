//
//  LBPlayerSummaryView.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 11/11/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBPlayerSummaryView : UIView

@property (nonatomic, strong) UILabel *playerName;
@property (nonatomic, strong) UILabel *playerDetail;
@property (nonatomic, strong) UIImageView *playerImage;

- (void) initialisePlayerViewWithName: (NSString *) name AndDetail: (NSString *) detail AndImageUrl: (NSString *) url;

- (void) initaliseEmptyPlayerView;

- (void) addButtonHandler: (SEL) handlerMethod andTarget: (id) actionTarget;

- (void) showAddEditButton;

- (void) hideAddEditButton;

@end
