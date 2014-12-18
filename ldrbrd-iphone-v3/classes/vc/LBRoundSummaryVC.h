//
//  LBRoundSummaryViewController.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 5/12/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBDataManager.h"

@interface LBRoundSummaryVC: UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
}

@property (strong, nonatomic) IBOutlet UIButton *submitScorecardBtn;
@property (weak, nonatomic) IBOutlet UITableView * summaryTable;

@end

@interface LBRoundSummaryHoleCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel* holeLabel;
@property (strong, nonatomic) IBOutlet UILabel* parLabel;
@property (strong, nonatomic) IBOutlet UILabel* indexLabel;
@property (strong, nonatomic) IBOutlet UILabel* scoreLabel;

@end