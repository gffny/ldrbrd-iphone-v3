//
//  LBLandingVC.h
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 10/9/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBLandingVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UILabel *warningLabel;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end
