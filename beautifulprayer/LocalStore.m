//
//  LocalStore.m
//  
//
//  Created by Adrian Domanico on 2015-03-07.
//
//

#import "LocalStore.h"

#define kMadhabSetting @"MadhadSetting"
#define kMethodSetting @"MethodSetting"

@implementation LocalStore

+ (instancetype) sharedInstance {
    
    static LocalStore *sharedInstance = nil;
    static dispatch_once_t onlyOnce;
    dispatch_once(&onlyOnce, ^{
         sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void) setMadhabSetting:(BAPrayerMadhab)madhab {
    NSNumber *madhabNumber = @(madhab);
    [[NSUserDefaults standardUserDefaults] setObject:madhabNumber forKey:kMadhabSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) setMethodSetting:(BAPrayerMethod)method {
    NSNumber *methodNumber = @(method);
    [[NSUserDefaults standardUserDefaults] setObject:methodNumber forKey:kMethodSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BAPrayerMadhab) madhabPreference {
    NSNumber *madhabNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kMadhabSetting];
    if(madhabNumber){
        return (BAPrayerMadhab)madhabNumber.intValue;
    }
    else{
        return BAPrayerMadhabShafi;
    }
}

- (BAPrayerMethod) methodPreference {
    NSNumber *methodNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kMethodSetting];
    if(methodNumber){
        return (BAPrayerMethod)methodNumber.intValue;
    }
    else{
        return BAPrayerMethodNorthAmerica;
    }
}


@end
