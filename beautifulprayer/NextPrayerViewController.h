//
//  PrayerViewController.h
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-08.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrayerLocaleManager.h"

/*!
    NextPrayerViewController
 
    Main controller of the app. Displays the users location and the next prayer name/time
 */

@interface NextPrayerViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIImageView *prayerImageView;

@property (nonatomic,strong) IBOutlet UILabel *prayerTimeLabel;
@property (nonatomic,strong) IBOutlet UILabel *prayerNameLabel;
@property (nonatomic,strong) IBOutlet UILabel *cityLabel;
@property (nonatomic,strong) IBOutlet UILabel *userTimeLabel;
@property (nonatomic,strong) IBOutlet UILabel *dateLabel;

@end
