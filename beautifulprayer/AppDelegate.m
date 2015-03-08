//
//  AppDelegate.m
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-08.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "AppDelegate.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


#import "NextPrayerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[CrashlyticsKit]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenRect];
    
    NextPrayerViewController *prayerVC = [NextPrayerViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:prayerVC];
    navigationController.navigationBarHidden = YES;
    
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
