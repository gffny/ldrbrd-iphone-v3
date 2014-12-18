//
//  LBPlayGolfNowVC.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 8/31/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBPlayGolfNowVC : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (strong, nonatomic) IBOutlet UILabel *courseName;
@property (strong, nonatomic) IBOutlet UILabel *parValue;
@property (strong, nonatomic) IBOutlet UILabel *teeColourValue;
@property (strong, nonatomic) IBOutlet UILabel *indexValue;
@property (strong, nonatomic) IBOutlet UILabel *descriptionValue;
@property (strong, nonatomic) IBOutlet UIButton *playGolfBtn;

@end
