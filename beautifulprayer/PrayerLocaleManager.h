//
//  LocaleManager.h
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-08.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

#define kNotificationLocationUpdate @"LocationUpdate"
#define kNotificationPrayerTimeUpdate @"PrayerTimeUpdate"
#define kNotificationLocationDenied @"LocationDenied"
#define kNotificationLocationEnabled @"LocationEnabled"

/*!
    PrayerLocaleManager
 
    Our main class for fetching prayer times according to user location
 
 */

@interface PrayerLocaleManager : NSObject <CLLocationManagerDelegate>

+ (instancetype) sharedInstance;

/*! Returns the local date for the user */
- (NSString*) localDate;

/*! Returns the local time for the user */
- (NSString*) localTime;

/*! Returns the next prayer time given the user locaiton */
- (NSString*) nextPrayerTime;

/*! Returns the name of the next prayer given the user locaiton */
- (NSString*) nextPrayerName;

/*! Returns an array of the upcoming prayer names in order */
- (NSArray*) upcomingPrayerNames;

/*! Returns an array of the upcoming prayer times in order */
- (NSArray*) upcomingPrayerTimes;

/*! Dispatches a location update and also updates the user prayer times
 
    Sends out notifications of this update
 */
- (void) updateLocationAndPrayerTimes;

@end
