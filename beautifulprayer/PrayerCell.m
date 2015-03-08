//
//  PrayerCell.m
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-09.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "PrayerCell.h"

#import "StyleManager.h"

@implementation PrayerCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.prayerTimeLabel.font = [StyleManager defaultSubFont:@"Hairline" WithSize:60.0];
    self.prayerNameLabel.font = [StyleManager defaultSubFont:@"Black" WithSize:25.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
