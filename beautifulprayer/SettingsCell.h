//
//  SettingsCell.h
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-16.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
    The cell for displaying prayer settings information
 */

@interface SettingsCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *settingLabel;

/*! Sets the madhab label for a given row index*/
- (void) setLabelWithMadhab:(int)madhab;

/*! Sets the method label for a given row index*/
- (void) setLabelWithMethod:(int)method;

@end
