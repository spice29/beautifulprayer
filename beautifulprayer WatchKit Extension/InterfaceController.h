//
//  InterfaceController.h
//  beautifulprayer WatchKit Extension
//
//  Created by Adrian Domanico on 2015-03-10.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (nonatomic,strong) IBOutlet WKInterfaceGroup *backgroundGroup;
@property (nonatomic,strong) IBOutlet WKInterfaceLabel *prayerLabel;

@end
