//
//  LocalStore.h
//  
//
//  Created by Adrian Domanico on 2015-03-07.
//
//

#import <Foundation/Foundation.h>

#import "BAPrayerTimes.h"

@interface LocalStore : NSObject

+ (instancetype) sharedInstance;

- (void) setMadhabSetting:(BAPrayerMadhab)madhab;

- (void) setMethodSetting:(BAPrayerMethod)method;

- (BAPrayerMadhab) madhabPreference;

- (BAPrayerMethod) methodPreference;

@end
