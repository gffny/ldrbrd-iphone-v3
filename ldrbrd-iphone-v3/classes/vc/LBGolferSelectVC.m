//
//  LBGolferSelectVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 11/13/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBGolferSelectVC.h"

@interface LBGolferSelectVC ()

@property (weak, nonatomic) IBOutlet UITableView *recentTable;
@property (weak, nonatomic) IBOutlet UITableView *societyTable;
@property (weak, nonatomic) IBOutlet UITableView *friendTable;

@end

NSMutableArray<LBGolfer> *recentGolferArray;
NSMutableArray<LBGolfer> *societyGolferArray;
NSMutableArray<LBGolfer> *friendGolferArray;


@implementation LBGolferSelectVC

@synthesize recentTable;
@synthesize societyTable;
@synthesize friendTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    recentGolferArray = (NSMutableArray<LBGolfer> *)[[NSMutableArray alloc] initWithCapacity:4];
    [recentGolferArray addObject: [LBGolfer golferWithFirstName: @"Colm" andLastName:@"Caffrey" andHandicap:@"7" andLastRound: @"10/12/2014" andProfileImageRef:@"https://www.cs.tcd.ie/postgraduate/mscnds/prospective/alumni/2006-2007/photos/ccaffrey.jpg"]];
    [recentGolferArray addObject: [LBGolfer golferWithFirstName: @"Eoin" andLastName:@"DeBarra" andHandicap:@"19" andLastRound: @"10/12/2014" andProfileImageRef:@"http://media-cache-ec0.pinimg.com/avatars/eoindeb_1337086653_140.jpg"]];
    [recentGolferArray addObject: [LBGolfer golferWithFirstName: @"Niall" andLastName:@"O'Connor" andHandicap:@"21" andLastRound: @"10/12/2014" andProfileImageRef:@"http://static.squarespace.com/static/541c4fd3e4b000f167fdfe1d/t/545971fae4b01dea9a202fa9/1415148026925/4921222956_c23a009a11_b.jpg"]];
    [recentGolferArray addObject: [LBGolfer golferWithFirstName: @"Mick" andLastName:@"O'Connor" andHandicap:@"17" andLastRound: @"10/12/2014" andProfileImageRef: @"https://pbs.twimg.com/profile_images/1550339346/MOC_Lineout_MIT_bigger.jpg"]];
    friendGolferArray = societyGolferArray = recentGolferArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual: societyTable]) {
    } else if ([tableView isEqual: recentTable]) {
    } else if ([tableView isEqual: friendTable]) {
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual: societyTable]) {
        return [societyGolferArray count];
    } else if ([tableView isEqual: recentTable]) {
        return [recentGolferArray count];
    } else if ([tableView isEqual: friendTable]) {
        return [friendGolferArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"golferCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath: indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if([tableView isEqual: recentTable]) {
        NSLog(@"%@", [NSString stringWithFormat:@" index path row %ld", [[NSNumber numberWithInteger: indexPath.row] longValue]]);
        LBGolfer *golfer = [recentGolferArray objectAtIndex:indexPath.row];
        UILabel *playerName = (UILabel *)[cell viewWithTag:10];
        playerName.text = [NSString stringWithFormat:@"%@ %@", golfer.firstName, golfer.lastName];
        UILabel *handicap = (UILabel *)[cell viewWithTag:20];
        handicap.text = [NSString stringWithFormat:@"handicap %@", golfer.handicap];
        UILabel *lastRoundDate = (UILabel *)[cell viewWithTag:30];
        lastRoundDate.text = [NSString stringWithFormat:@"last round %@", golfer.lastRoundDate];
        UIImageView *order = (UIImageView *)[cell viewWithTag:40];
        order.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: golfer.profileImageRef]]];
    }
    if([tableView isEqual: societyTable]) {
        NSLog(@"%@", [NSString stringWithFormat:@" index path row %ld", [[NSNumber numberWithInteger: indexPath.row] longValue]]);
        LBGolfer *golfer = [societyGolferArray objectAtIndex:indexPath.row];
        UILabel *playerName = (UILabel *)[cell viewWithTag:10];
        playerName.text = [NSString stringWithFormat:@"%@ %@", golfer.firstName, golfer.lastName];
        UILabel *handicap = (UILabel *)[cell viewWithTag:20];
        handicap.text = [NSString stringWithFormat:@"handicap %@", golfer.handicap];
        UILabel *lastRoundDate = (UILabel *)[cell viewWithTag:30];
        lastRoundDate.text = [NSString stringWithFormat:@"last round %@", golfer.lastRoundDate];
        UIImageView *order = (UIImageView *)[cell viewWithTag:40];
        order.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: golfer.profileImageRef]]];
    }
    if([tableView isEqual: friendTable]) {
        NSLog(@"%@", [NSString stringWithFormat:@"populating favourite table: row %ld", [[NSNumber numberWithInteger: indexPath.row] longValue]]);
        LBGolfer *golfer = [friendGolferArray objectAtIndex:indexPath.row];
        UILabel *playerName = (UILabel *)[cell viewWithTag:10];
        playerName.text = [NSString stringWithFormat:@"%@ %@", golfer.firstName, golfer.lastName];
        UILabel *handicap = (UILabel *)[cell viewWithTag:20];
        handicap.text = [NSString stringWithFormat:@"handicap %@", golfer.handicap];
        UILabel *lastRoundDate = (UILabel *)[cell viewWithTag:30];
        lastRoundDate.text = [NSString stringWithFormat:@"last round %@", golfer.lastRoundDate];
        UIImageView *order = (UIImageView *)[cell viewWithTag:40];
        order.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: golfer.profileImageRef]]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Upcoming Rounds: didSelectRowAtIndexPath");
    
    if([tableView isEqual: societyTable]) {
        
    } else if ([tableView isEqual: recentTable]) {

    } else if ([tableView isEqual: friendTable]) {

    }
}


@end
