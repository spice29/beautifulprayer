//
//  SettingsCell.m
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-16.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "SettingsCell.h"

#import "BAPrayerTimes.h"

#import "StyleManager.h"

@implementation SettingsCell

- (void) awakeFromNib {
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.settingLabel.font = [StyleManager defaultSubFont:@"Bold" WithSize:15.0];
    self.settingLabel.textColor = [StyleManager defaultDarkGrayColor:0.9];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if(selected){
        self.settingLabel.textColor = [StyleManager altColor];
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        self.settingLabel.textColor = [StyleManager defaultDarkGrayColor:0.9];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    // Configure the view for the selected state
}

- (void) setLabelWithMadhab:(int)madhabIndex {
    if(madhabIndex == 0){
       self.settingLabel.text = @"Shafi";
    }
    else{
       self.settingLabel.text = @"Hanafi";
    }
}

- (void) setLabelWithMethod:(int)methodIndex {
    if(methodIndex == 0){
        self.settingLabel.text = @"Egyptian General Authority";
    }
    else if(methodIndex == 1){
        self.settingLabel.text = @"Karachi Shafi";
    }
    else if(methodIndex == 2){
        self.settingLabel.text = @"Karachi Hanafi";
    }
    else if(methodIndex == 3){
        self.settingLabel.text = @"North America";
    }
    else if(methodIndex == 4){
        self.settingLabel.text = @"MWL";
    }
    else if(methodIndex == 5){
        self.settingLabel.text = @"UMM Qurra";
    }
    else if(methodIndex == 6){
        self.settingLabel.text = @"Fixed Isha";
    }
    else if(methodIndex == 7){
        self.settingLabel.text = @"New Egyptian Authority";
    }
    else if(methodIndex == 8){
        self.settingLabel.text = @"Umm Qurra Ramadan";
    }
    else if(methodIndex == 9){
        self.settingLabel.text = @"MCW";
    }
}

@end
