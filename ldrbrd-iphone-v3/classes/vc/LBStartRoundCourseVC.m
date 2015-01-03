//
//  LBCourseSelectVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 11/5/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBStartRoundCourseVC.h"
#import "LBScorecardUtils.h"
#import "LBDataManager.h"

@interface LBStartRoundCourseVC ()

@property (weak, nonatomic) IBOutlet UITableView *recentTable;
@property (weak, nonatomic) IBOutlet UITableView *searchTable;
@property (weak, nonatomic) IBOutlet UITableView *favouriteTable;

@end

@implementation LBStartRoundCourseVC

@synthesize recentTable;
@synthesize searchTable;
@synthesize favouriteTable;

NSArray *recentCourseList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [recentTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [searchTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [favouriteTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    recentCourseList = [LBScorecardUtils distinctCourseListFromScorecardArray: [[LBDataManager sharedInstance] lastXScorecardList]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual: searchTable]) {
    } else if ([tableView isEqual: recentTable]) {
    } else if ([tableView isEqual: favouriteTable]) {
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual: searchTable]) {
        return 0;
    } else if ([tableView isEqual: recentTable]) {
        return 5;
    } else if ([tableView isEqual: favouriteTable]) {
        return [[[LBDataManager sharedInstance] favouriteCourseList] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"courseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath: indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if([tableView isEqual: recentTable]) {
        NSLog(@"%@", [NSString stringWithFormat:@" index path row %ld", [[NSNumber numberWithInteger: indexPath.row] longValue]]);
        UILabel *courseLabel = (UILabel *)[cell viewWithTag:10];
        courseLabel.text = [NSString stringWithFormat:@"Course Name %li", indexPath.row];
        UILabel *bestScore = (UILabel *)[cell viewWithTag:20];
        bestScore.text = [NSString stringWithFormat:@"best score 44 (9 holes)"];
        UILabel *lastRoundDate = (UILabel *)[cell viewWithTag:30];
        lastRoundDate.text = [NSString stringWithFormat:@"last round 10/04/2014"];
        UILabel *order = (UILabel *)[cell viewWithTag:40];
        order.text = [NSString stringWithFormat:@"%li", indexPath.row];
    }
    if([tableView isEqual: searchTable]) {
        NSLog(@"%@", [NSString stringWithFormat:@" index path row %ld", [[NSNumber numberWithInteger: indexPath.row] longValue]]);
    }
    if([tableView isEqual: favouriteTable]) {
        NSLog(@"%@", [NSString stringWithFormat:@"populating favourite table: row %ld", [[NSNumber numberWithInteger: indexPath.row] longValue]]);
        LBCourse *course = (LBCourse *)[[[LBDataManager sharedInstance] favouriteCourseList] objectAtIndex: indexPath.row];
        UILabel *courseLabel = (UILabel *)[cell viewWithTag:10];
        courseLabel.text = course.courseName;
        UILabel *bestScore = (UILabel *)[cell viewWithTag:20];
        bestScore.text = [NSString stringWithFormat:@"best score 44 (9 holes)"];
        UILabel *lastRoundDate = (UILabel *)[cell viewWithTag:30];
        lastRoundDate.text = [NSString stringWithFormat:@"last round 10/04/2014"];
        UILabel *order = (UILabel *)[cell viewWithTag:40];
        order.text = [NSString stringWithFormat:@"%li", indexPath.row];
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
    
    if([tableView isEqual: searchTable]) {
        // need to set the course with actual data
        [[LBDataManager sharedInstance] initialiseCourse: [[[LBDataManager sharedInstance] favouriteCourseList] objectAtIndex:1]];
    } else if ([tableView isEqual: recentTable]) {
        // need to set the course with actual data
        [[LBDataManager sharedInstance] initialiseCourse: [[[LBDataManager sharedInstance] favouriteCourseList] objectAtIndex:1]];
    } else if ([tableView isEqual: favouriteTable]) {
        // set the course in play as the nth on the list of the favourite
        [[LBDataManager sharedInstance] initialiseCourse: [[[LBDataManager sharedInstance] favouriteCourseList] objectAtIndex:indexPath.row]];
    }
    [self performSegueWithIdentifier:@"seg_plynw2" sender:self];
}

#pragma mark UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search for value %@", searchBar.text);
    //TODO actually hit a service with 
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    //TODO maybe use this to bookmark favourites in future?!
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"do not search for value %@", searchBar.text);    
}

- (BOOL)shouldAutorotate {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        return NO;
    }
    return YES;
}

@end
