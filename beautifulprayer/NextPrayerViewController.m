//
//  PrayerViewController.m
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-08.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "NextPrayerViewController.h"
#import "SettingsViewController.h"

#import "StyleManager.h"
#import "PrayerLocaleManager.h"
#import "PrayerTimesController.h"

@interface NextPrayerViewController ()

@property (nonatomic,strong) NSTimer *timeUpdateTimer;

@property (nonatomic,strong) UISwipeGestureRecognizer *swipeGestureUp;

@property (nonatomic,strong) UISwipeGestureRecognizer *swipeGestureLeft;

@property (nonatomic,assign) BOOL isChangingImage;

@property (nonatomic,assign) BOOL isLocationDenied;

@end

@implementation NextPrayerViewController

- (instancetype) init {
    self = [super initWithNibName:@"NextPrayerViewController" bundle:nil];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSystemTimeChanged) name:NSSystemClockDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAppActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAppNotActive) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLocationUpdate:) name:kNotificationLocationUpdate object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLocationDenied:) name:kNotificationLocationDenied object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLocationEnabled:) name:kNotificationLocationEnabled object:nil];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void) viewDidLoad {
    [super viewDidLoad];

    self.cityLabel.font = [StyleManager defaultSubFont:@"Light" WithSize:37.5];
    self.userTimeLabel.font = [StyleManager defaultSubFont:@"Light" WithSize:15.0];
    self.dateLabel.font = [StyleManager defaultSubFont:@"Light" WithSize:15.0];
    
    self.prayerTimeLabel.font = [StyleManager defaultSubFont:@"Hairline" WithSize:100.0];
    self.prayerNameLabel.font = [StyleManager defaultSubFont:@"Black" WithSize:25.0];
    
    self.swipeGestureUp = [UISwipeGestureRecognizer new];
    self.swipeGestureUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.swipeGestureUp addTarget:self action:@selector(gestureUpSwipe:)];
    [self.view addGestureRecognizer:self.swipeGestureUp];
    
    self.swipeGestureLeft = [UISwipeGestureRecognizer new];
    self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.swipeGestureLeft addTarget:self action:@selector(gestureLeftSwipe:)];
    [self.view addGestureRecognizer:self.swipeGestureLeft];
    
    self.prayerImageView.image = [UIImage imageNamed:@"Fajr"];
    
    [self updateUI];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UI Updates

- (void) updateUI {
    
    self.dateLabel.text = [[PrayerLocaleManager sharedInstance] localDate];
    self.userTimeLabel.text = [[PrayerLocaleManager sharedInstance] localTime];
    
    [self updatePrayer];
}

- (void) updatePrayer {
    
    NSString *prayerTimeString = [[[PrayerLocaleManager sharedInstance] nextPrayerTime] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(prayerTimeString){
        NSRange pmRange = [prayerTimeString rangeOfString:@"pm" options:NSCaseInsensitiveSearch];
        NSRange amRange = [prayerTimeString rangeOfString:@"am" options:NSCaseInsensitiveSearch];
        
        if(pmRange.location != NSNotFound){
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:prayerTimeString];
            [attributedString setAttributes:@{NSBaselineOffsetAttributeName : @40,NSFontAttributeName : [StyleManager defaultSubFont:@"Hairline" WithSize:40.0],NSForegroundColorAttributeName:[StyleManager colorScaledWith255Red:255 green:255 blue:255 alpha:1.0]} range:pmRange];
            [self.prayerTimeLabel setAttributedText:attributedString];
        }
        else if (amRange.location != NSNotFound){
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:prayerTimeString];
            [attributedString setAttributes:@{NSBaselineOffsetAttributeName : @40,NSFontAttributeName : [StyleManager defaultSubFont:@"Hairline" WithSize:40.0],NSForegroundColorAttributeName:[StyleManager colorScaledWith255Red:255 green:255 blue:255 alpha:1.0]} range:amRange];
            [self.prayerTimeLabel setAttributedText:attributedString];
        }
        else{
            self.prayerTimeLabel.text = prayerTimeString;
        }
    }
    
    
    NSString *prayerName = [[PrayerLocaleManager sharedInstance] nextPrayerName];
    if(prayerName){
        self.prayerNameLabel.text = prayerName;
            UIImage *image = [UIImage imageNamed:prayerName];
            if(![self.prayerImageView.image isEqual:image] && !self.isChangingImage){
                self.isChangingImage = YES;
                
                [UIView transitionWithView:self.prayerImageView duration:1.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    self.prayerImageView.image = image;
                } completion:^(BOOL finished) {
                    if(finished){
                        self.isChangingImage = NO;
                    }
                }];
                
            }
    }
}

#pragma mark - Gesture Recognizere

- (void) gestureLeftSwipe:(UIGestureRecognizer*)g {
    
    if(self.isLocationDenied){
        return;
    }
    
    PrayerTimesController *prayerTimesVC = [PrayerTimesController new];
    [self.navigationController pushViewController:prayerTimesVC animated:YES];
}

- (void) gestureUpSwipe:(UIGestureRecognizer*)g {
    
    if(self.isLocationDenied){
        return;
    }
    
    SettingsViewController *settingsVC = [SettingsViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    navController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Location Notification

- (void) notificationLocationUpdate:(NSNotification *)n {
    NSString *location = n.object;
    self.cityLabel.text = location;
    
    [self updateUI];
}

#pragma mark - Notifications 

- (void) notificationAppNotActive {
    [self.timeUpdateTimer invalidate];
}

- (void) notificationAppActive {
    [[PrayerLocaleManager sharedInstance] updateLocationAndPrayerTimes];

    self.timeUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
}

- (void) notificationSystemTimeChanged {
    [self updateUI];
}

- (void) notificationLocationDenied:(NSNotification*)n {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"In order for us to calculate your prayer times we need your location! Please enable beautifulprayer to access your location in your privacy settings" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    self.cityLabel.text = @"Location Disabled";
    
    self.isLocationDenied = YES;
}

- (void) notificationLocationEnabled:(NSNotification*)n {
        
    self.isLocationDenied = NO;
}

@end
