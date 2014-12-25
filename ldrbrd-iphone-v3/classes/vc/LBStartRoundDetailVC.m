//
//  LBCourseSelectScrnTwoVC.m
//  ldrbrd-iphone-v2
//
//  Created by John D. Gaffney on 11/6/14.
//  Copyright (c) 2014 gffny.com. All rights reserved.
//

#import "LBStartRoundDetailVC.h"
#import "LBGolferSelectVC.h"
#import "LBRestFacade.h"

@interface LBStartRoundDetailVC ()

@end

@implementation LBStartRoundDetailVC

@synthesize courseDetail;
@synthesize firstPlayerSummary;
@synthesize secondPlayerSummary;
@synthesize thirdPlayerSummary;
@synthesize fourthPlayerSummary;

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
    // Do any additional setup after loading the view.
    [self initialiseViewWithCourse: [[LBDataManager sharedInstance] course]];
    [self initializePlayerSummaryView];
    [self.scrollView setScrollEnabled: YES];
    [self.scrollView setContentSize:CGSizeMake(320, 700)];
    [self setPreviousScrollViewYOffset: 1.0f];
    [self.startRoundButton addTarget:self action:@selector(startRoundClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initialiseViewWithCourse: (LBCourse *) course {
    // check course is not null and then set the values
    if (course != NULL) {
        UILabel *courseName = (UILabel *)[courseDetail viewWithTag:10];
        courseName.text = course.name;
        UILabel *par = (UILabel *)[courseDetail viewWithTag:20];
        par.text = course.par;
        UILabel *distance = (UILabel *)[courseDetail viewWithTag:30];
        distance.text = @"todo!";
        UILabel *index = (UILabel *)[courseDetail viewWithTag:40];
        index.text = course.slopeIndex;
        UILabel *description = (UILabel *)[courseDetail viewWithTag:50];
        description.text = @"todo!! this is going to be where the description is going to go...";
    }
}

- (void) initializePlayerSummaryView {
    
    // set the first player as the current user!
    [firstPlayerSummary initialisePlayerViewWithName:@"John Gaffney (16)" AndDetail:@"Home Club: Fresh Pond. Last Round: 86/18 @ Butterbrook" AndImageUrl:@"http://images.ak.instagram.com/profiles/profile_215923613_75sq_1397131660.jpg"];
    [secondPlayerSummary initaliseEmptyPlayerView];
    [secondPlayerSummary showAddEditButton];
    [secondPlayerSummary addButtonHandler: @selector(showPlayerSelect:) andTarget:self];
//    [secondPlayerSummary addButtonHandler: @selector(firstAddEditHandler:) andTarget:self];
    [thirdPlayerSummary initaliseEmptyPlayerView];
//    [thirdPlayerSummary addButtonHandler: @selector(secondAddEditHandler:) andTarget:self];
    [thirdPlayerSummary addButtonHandler: @selector(showPlayerSelect:) andTarget:self];
    [fourthPlayerSummary initaliseEmptyPlayerView];
//    [fourthPlayerSummary addButtonHandler: @selector(thirdAddEditHandler:) andTarget:self];
    [fourthPlayerSummary addButtonHandler: @selector(showPlayerSelect:) andTarget:self];
}

- (void) showPlayerSelect: (UIButton *) sender {
    NSLog(@"show player select");
    [self performSegueWithIdentifier:@"seg_slctglfr" sender:self];
}

- (void) firstAddEditHandler:(UIButton *)sender {
    NSLog(@"It worked: first handler!");
    [secondPlayerSummary initialisePlayerViewWithName:@"Colm Caffrey (7)" AndDetail:@"Home Club: Fresh Pond. Last Round: 86/18 @ Butterbrook" AndImageUrl:@"https://www.cs.tcd.ie/postgraduate/mscnds/prospective/alumni/2006-2007/photos/ccaffrey.jpg"];
    [thirdPlayerSummary showAddEditButton];
    // move scroll view down 60px
    CGPoint currentOffset = self.scrollView.contentOffset;
    currentOffset.y = currentOffset.y+60;
    [self.scrollView setContentOffset:currentOffset animated:YES];
}

- (void) secondAddEditHandler:(UIButton *)sender {
    NSLog(@"It worked: second handler!");
    [thirdPlayerSummary initialisePlayerViewWithName:@"Eoin DeBarra (19)" AndDetail:@"Home Club: Fresh Pond. Last Round: 86/18 @ Butterbrook" AndImageUrl:@"http://media-cache-ec0.pinimg.com/avatars/eoindeb_1337086653_140.jpg"];
    [fourthPlayerSummary showAddEditButton];
    // move scroll view down 60px
    CGPoint currentOffset = self.scrollView.contentOffset;
    currentOffset.y = currentOffset.y+60;
    [self.scrollView setContentOffset:currentOffset animated:YES];
}

- (void) thirdAddEditHandler:(UIButton *)sender {
    NSLog(@"It worked: third handler!");
    [fourthPlayerSummary initialisePlayerViewWithName:@"Niall O'Connor (21)" AndDetail:@"Home Club: Fresh Pond. Last Round: 86/18 @ Butterbrook" AndImageUrl:@"http://static.squarespace.com/static/541c4fd3e4b000f167fdfe1d/t/545971fae4b01dea9a202fa9/1415148026925/4921222956_c23a009a11_b.jpg"];
    // move scroll view to bottom
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startRoundClicked: (UIButton *)sender {
    [LBRestFacade asynchStartScorecardOnCourse:[[[LBDataManager sharedInstance] course] idString] withSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"starting scorecard");
         
         // parse scorecard and persist it
        [[LBDataManager sharedInstance] setScorecard:[[LBScorecard alloc] initWithDictionary:(NSDictionary*)responseObject error:nil]];


         [self performSegueWithIdentifier:@"seg_plyrnd" sender:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to start scorecard!");
        
    }];
     }

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    UIViewController *destVc = [segue destinationViewController];
    if([destVc isKindOfClass: [LBGolferSelectVC class]])
    {
        //LBGolferSelectVC *playGolfVC = (LBGolferSelectVC *)destVc;
    }
    // Pass the selected object to the new view controller.
}

#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = self.navigationController.navigationBar.frame;
    CGFloat size = frame.size.height - 21;
    CGFloat framePercentageHidden = ((20 - frame.origin.y) / (frame.size.height - 1));
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGFloat scrollDiff = scrollOffset - self.previousScrollViewYOffset;
    CGFloat scrollHeight = scrollView.frame.size.height;
    CGFloat scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;
    
    if (scrollOffset <= -scrollView.contentInset.top) {
        frame.origin.y = 20;
    } else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
        frame.origin.y = -size;
    } else {
        frame.origin.y = MIN(20, MAX(-size, frame.origin.y - scrollDiff));
    }
    
    [self.navigationController.navigationBar setFrame:frame];
    [self updateBarButtonItems:(1 - framePercentageHidden)];
    self.previousScrollViewYOffset = scrollOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self stoppedScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self stoppedScrolling];
    }
}

- (void)stoppedScrolling
{
    CGRect frame = self.navigationController.navigationBar.frame;
    if (frame.origin.y < 20) {
        [self animateNavBarTo:-(frame.size.height - 21)];
    }
}

- (void)updateBarButtonItems:(CGFloat)alpha
{
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    self.navigationItem.titleView.alpha = alpha;
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
}

- (void)animateNavBarTo:(CGFloat)y
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.navigationController.navigationBar.frame;
        CGFloat alpha = (frame.origin.y >= y ? 0 : 1);
        frame.origin.y = y;
        [self.navigationController.navigationBar setFrame:frame];
        [self updateBarButtonItems:alpha];
    }];
}

@end
