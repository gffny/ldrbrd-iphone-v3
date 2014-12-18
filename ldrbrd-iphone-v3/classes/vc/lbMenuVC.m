//
//  MenuViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "LBMenuVC.h"
#import "SWRevealViewController.h"

@implementation SWUITableViewCell
@end

@implementation LBMenuVC

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // configure the destination view controller:
    if ( [segue.destinationViewController isKindOfClass: [UIViewController class]] &&
        [sender isKindOfClass:[UITableViewCell class]] )
    {
        //UILabel* c = [(SWUITableViewCell *)sender label];
        //NSLog(c.text);
        //ColorViewController* cvc = segue.destinationViewController;
        
        //cvc.color = c.textColor;
        //cvc.text = c.text;
    }

    // configure the segue.
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        SWRevealViewControllerSegue* rvcs = (SWRevealViewControllerSegue*) segue;
        
        SWRevealViewController* rvc = self.revealViewController;
        NSAssert( rvc != nil, @"oops! must have a revealViewController" );
        
        NSAssert( [rvc.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );

        rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc)
        {
            //UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:dvc];
            //[rvc pushFrontViewController:nc animated:YES];
        };
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"title";

    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"title";
            break;

        case 1:
            CellIdentifier = @"home";
            break;

        case 2:
            CellIdentifier = @"play";
            break;

        case 3:
            CellIdentifier = @"profile";
            break;

        case 4:
            CellIdentifier = @"settings";
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
 
    return cell;
}

@end
