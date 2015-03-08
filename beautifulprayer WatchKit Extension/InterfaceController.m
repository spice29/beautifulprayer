//
//  InterfaceController.m
//  beautifulprayer WatchKit Extension
//
//  Created by Adrian Domanico on 2015-03-10.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "InterfaceController.h"

#import "PrayerLocaleManager.h"

#import "StyleManager.h"

@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    
    [self.backgroundGroup setWidth:self.contentFrame.size.width];
    [self.backgroundGroup setHeight:self.contentFrame.size.height];
    
    // Configure interface objects here.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationUpdatePrayerTime:) name:kNotificationPrayerTimeUpdate object:nil];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    
    [self.prayerLabel setText:@"Detecting Location..."];
    
    [[PrayerLocaleManager sharedInstance] updateLocationAndPrayerTimes];
    
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void) notificationUpdatePrayerTime:(NSNotification*)n {
    
    NSDictionary *fontAttName = @{NSFontAttributeName : [StyleManager defaultSubFont:@"Hairline" WithSize:32.0]};
    
    NSString *prayerName = [[PrayerLocaleManager sharedInstance] nextPrayerName];
    NSString *prayerTime = [[PrayerLocaleManager sharedInstance] nextPrayerTime];
    
    if(prayerName && prayerTime){
        NSString *prayerString = [NSString stringWithFormat:@"%@ \n %@",prayerName,prayerTime];
        
        NSAttributedString *nameAttrString = [[NSAttributedString alloc] initWithString:prayerString attributes:fontAttName];
        
        [self.prayerLabel setAttributedText:nameAttrString];
        
        UIImage *image = [UIImage imageNamed:prayerName];
        [self.backgroundGroup setBackgroundImage:image];
    }
    
}

@end



