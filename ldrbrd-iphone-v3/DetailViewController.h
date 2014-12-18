//
//  DetailViewController.h
//  ldrbrd-iphone-v3
//
//  Created by John D. Gaffney on 12/18/14.
//  Copyright (c) 2014 John D. Gaffney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

