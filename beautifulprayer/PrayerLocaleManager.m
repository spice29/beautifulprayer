//
//  LocaleManager.m
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-08.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "PrayerLocaleManager.h"

#import <UIKit/UIKit.h>

#import "BAPrayerTimes.h"

#import "LocalStore.h"

@interface PrayerLocaleManager ()

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (strong) CLLocation *currentLocation;

@property (nonatomic,strong) BAPrayerTimes *currentPrayerTimes;
@property (nonatomic,strong) BAPrayerTimes *tomorrowPrayerTimes;

@property (nonatomic,strong) NSArray *prayerNamesArray;
@property (nonatomic,strong) NSArray *prayerTimesArray;

@property (nonatomic,assign) BAPrayerMadhab madhabSetting;
@property (nonatomic,assign) BAPrayerMethod methodSetting;

@end

@implementation PrayerLocaleManager

+ (PrayerLocaleManager*) sharedInstance {
    
    static PrayerLocaleManager *sharedInstance = nil;
    static dispatch_once_t onlyOnce;
    dispatch_once(&onlyOnce, ^{
        sharedInstance = [[self alloc] init];
        
        sharedInstance.prayerNamesArray = @[@"Fajr",@"Sunrise",@"Dhuhr",@"Asr",@"Maghrib",@"Isha",@"Fajr ",@"Sunrise ",@"Dhuhr ",@"Asr ",@"Maghrib ",@"Isha "];
        
        sharedInstance.locationManager = [[CLLocationManager alloc] init];;
        sharedInstance.locationManager.delegate = sharedInstance;
        sharedInstance.locationManager.distanceFilter = kCLDistanceFilterNone;
        sharedInstance.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        
        
        sharedInstance.madhabSetting = [[LocalStore sharedInstance] madhabPreference];
        sharedInstance.methodSetting = [[LocalStore sharedInstance] methodPreference];
        
        [sharedInstance.locationManager requestWhenInUseAuthorization];
        [sharedInstance.locationManager startUpdatingLocation];

    });
    
    return sharedInstance;
}

- (NSString*) localDate {
    NSDate *currentDateTime = [NSDate date];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    return [dateFormatter stringFromDate:currentDateTime];
}

- (NSString*) localTime {
    NSDate *currentDateTime = [NSDate date];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    return [dateFormatter stringFromDate:currentDateTime];
}

- (NSString*) nextPrayerName {
    
    if(!self.currentPrayerTimes || !self.tomorrowPrayerTimes){
        return nil;
    }
    
    if([self isNextPrayerTime:self.currentPrayerTimes.fajrTime]){
        return self.prayerNamesArray[0];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.sunriseTime]){
        return self.prayerNamesArray[1];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.dhuhrTime]){
        return self.prayerNamesArray[2];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.asrTime]){
        return self.prayerNamesArray[3];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.maghribTime]){
        return self.prayerNamesArray[4];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.ishaTime]){
        return self.prayerNamesArray[5];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.fajrTime]){
        return self.prayerNamesArray[6];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.sunriseTime]){
        return self.prayerNamesArray[7];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.dhuhrTime]){
        return self.prayerNamesArray[8];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.asrTime]){
        return self.prayerNamesArray[9];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.maghribTime]){
        return self.prayerNamesArray[10];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.ishaTime]){
        return self.prayerNamesArray[11];
    }
    return nil;
}

- (NSString*) nextPrayerTime {
 
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    if([self isNextPrayerTime:self.currentPrayerTimes.fajrTime]){
        return [dateFormatter stringFromDate:self.currentPrayerTimes.fajrTime];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.sunriseTime]){
        return [dateFormatter stringFromDate:self.currentPrayerTimes.sunriseTime];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.dhuhrTime]){
        return [dateFormatter stringFromDate:self.currentPrayerTimes.dhuhrTime];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.asrTime]){
        return [dateFormatter stringFromDate:self.currentPrayerTimes.asrTime];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.maghribTime]){
        return [dateFormatter stringFromDate:self.currentPrayerTimes.maghribTime];
    }
    else if([self isNextPrayerTime:self.currentPrayerTimes.ishaTime]){
        return [dateFormatter stringFromDate:self.currentPrayerTimes.ishaTime];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.fajrTime]){
        return [dateFormatter stringFromDate:self.tomorrowPrayerTimes.fajrTime];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.sunriseTime]){
        return [dateFormatter stringFromDate:self.tomorrowPrayerTimes.sunriseTime];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.dhuhrTime]){
        return [dateFormatter stringFromDate:self.tomorrowPrayerTimes.dhuhrTime];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.asrTime]){
        return [dateFormatter stringFromDate:self.tomorrowPrayerTimes.asrTime];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.maghribTime]){
        return [dateFormatter stringFromDate:self.tomorrowPrayerTimes.maghribTime];
    }
    else if([self isNextPrayerTime:self.tomorrowPrayerTimes.ishaTime]){
        return [dateFormatter stringFromDate:self.tomorrowPrayerTimes.ishaTime];
    }
    return nil;
}

- (NSArray*) upcomingPrayerNames {
    
    long indexOfNextPrayer = -1;
    
    indexOfNextPrayer = [self.prayerNamesArray indexOfObject:[self nextPrayerName]];
    
    if(indexOfNextPrayer == -1){
        return nil;
    }
    
    NSMutableArray *prayerNamesArray = [NSMutableArray new];
    while (prayerNamesArray.count < self.prayerNamesArray.count/2) {
        
        if(indexOfNextPrayer < self.prayerNamesArray.count){
            
            [prayerNamesArray addObject:self.prayerNamesArray[indexOfNextPrayer]];
            indexOfNextPrayer++;
            
            if(indexOfNextPrayer > self.prayerNamesArray.count){
                indexOfNextPrayer = 0;
            }
        }
        
        
    }
    return [NSArray arrayWithArray:prayerNamesArray];
}

- (NSArray*) upcomingPrayerTimes {
    
    long indexOfNextPrayer = -1;
    
    indexOfNextPrayer = [self.prayerNamesArray indexOfObject:[self nextPrayerName]];
    
    if(indexOfNextPrayer == -1){
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    NSMutableArray *prayerTimesArray = [NSMutableArray new];
    while (prayerTimesArray.count < self.prayerNamesArray.count/2) {
        
        if(indexOfNextPrayer < self.prayerTimesArray.count){
            
            [prayerTimesArray addObject:[dateFormatter stringFromDate:self.prayerTimesArray[indexOfNextPrayer]]];
            indexOfNextPrayer++;
            
            if(indexOfNextPrayer > self.prayerNamesArray.count){
                indexOfNextPrayer = 0;
            }
        }
        
        
    }
    return [NSArray arrayWithArray:prayerTimesArray];
}

- (void) updateLocationAndPrayerTimes {
    self.madhabSetting = [[LocalStore sharedInstance] madhabPreference];
    self.methodSetting = [[LocalStore sharedInstance] methodPreference];
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Location Delegate

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = [locations objectAtIndex:0];
    [self.locationManager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!error)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *userArea;
             if(placemark.locality){
                 userArea = [[NSString alloc]initWithString:placemark.locality];
             }
             else {
                userArea = @"Location Error";
             }
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLocationUpdate object:userArea];
         }
         
     }];
    
    self.currentPrayerTimes = [[BAPrayerTimes alloc] initWithDate:[NSDate date] latitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude timeZone:[NSTimeZone localTimeZone] method:self.methodSetting madhab:self.madhabSetting];

    NSDate *tomorrow = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]];
    self.tomorrowPrayerTimes = [[BAPrayerTimes alloc] initWithDate:tomorrow latitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude timeZone:[NSTimeZone localTimeZone] method:self.methodSetting madhab:self.madhabSetting];
    
    self.prayerTimesArray = @[self.currentPrayerTimes.fajrTime,self.currentPrayerTimes.sunriseTime,self.currentPrayerTimes.dhuhrTime,self.currentPrayerTimes.asrTime,self.currentPrayerTimes.maghribTime,self.currentPrayerTimes.ishaTime,self.tomorrowPrayerTimes.fajrTime,self.tomorrowPrayerTimes.sunriseTime,self.tomorrowPrayerTimes.dhuhrTime,self.tomorrowPrayerTimes.asrTime,self.tomorrowPrayerTimes.maghribTime,self.tomorrowPrayerTimes.ishaTime];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPrayerTimeUpdate object:self.currentPrayerTimes];
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if(status == kCLAuthorizationStatusDenied || status ==kCLAuthorizationStatusRestricted){
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLocationDenied object:nil];
    }
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLocationEnabled object:nil];
}

#pragma mark - Helpers

- (BOOL) isNextPrayerTime:(NSDate*)prayerDate {
    NSDate *date = [NSDate date];
    if(date && ([date compare:prayerDate] == NSOrderedAscending || [date compare:prayerDate] == NSOrderedSame)){
        return YES;
    }
    return NO;
}

@end
