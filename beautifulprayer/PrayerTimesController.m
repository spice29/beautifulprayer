//
//  PrayerTimesController.m
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-09.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "PrayerTimesController.h"

#import "PrayerCell.h"

#import "PrayerLocaleManager.h"

#import "BAPrayerTimes.h"

@interface PrayerTimesController ()

@property (nonatomic,strong) BAPrayerTimes *prayerTimes;

@property (nonatomic,strong) UISwipeGestureRecognizer *swipeGesture;

@property (nonatomic,strong) NSArray *prayerNamesArray;
@property (nonatomic,strong) NSArray *prayerTimesArray;

@end

@implementation PrayerTimesController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PrayerCell" bundle:nil] forCellReuseIdentifier:@"PrayerCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPrayerTimeUpdate:) name:kNotificationPrayerTimeUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAppActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAppNotActive) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    self.swipeGesture = [UISwipeGestureRecognizer new];
    self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    self.prayerNamesArray = [[PrayerLocaleManager sharedInstance] upcomingPrayerNames];
    self.prayerTimesArray = [[PrayerLocaleManager sharedInstance] upcomingPrayerTimes];
    
    [self.swipeGesture addTarget:self action:@selector(gestureRightSwipe:)];
    [self.view addGestureRecognizer:self.swipeGesture];
    
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenRect = [UIScreen mainScreen].bounds;
    return screenRect.size.height/5.0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrayerCell *cell = (PrayerCell*)[tableView dequeueReusableCellWithIdentifier:@"PrayerCell"];
    NSString *prayerName = self.prayerNamesArray[indexPath.row];
    NSString *prayerTime = self.prayerTimesArray[indexPath.row];
    cell.prayerNameLabel.text = prayerName;
    cell.prayerTimeLabel.text = prayerTime;
    cell.prayerImageView.image = [UIImage imageNamed:prayerName];
    return cell;
    
}

#pragma mark - Gesture Recognizer

- (void) gestureRightSwipe:(UIGestureRecognizer*)g {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Prayer Times Notification

- (void) notificationPrayerTimeUpdate:(NSNotification*)n {
    self.prayerTimes = n.object;
    self.prayerTimesArray = [[PrayerLocaleManager sharedInstance] upcomingPrayerTimes];
    self.prayerNamesArray = [[PrayerLocaleManager sharedInstance] upcomingPrayerNames];
    [self.tableView reloadData];
    
}

- (void) notificationAppNotActive {
    
}

- (void) notificationAppActive {
    [[PrayerLocaleManager sharedInstance] updateLocationAndPrayerTimes];

}

@end