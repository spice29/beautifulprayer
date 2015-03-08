//
//  PrayerCell.h
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-09.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! PrayerCell
 
    Main tableview cell for displaying a given prayer and time
 
 */

@interface PrayerCell : UITableViewCell

/*! Label displaying prayer name */
@property (nonatomic,strong) IBOutlet UILabel *prayerNameLabel;
/*! Label displaying prayer time */
@property (nonatomic,strong) IBOutlet UILabel *prayerTimeLabel;
/*! Prayer imageview */
@property (nonatomic,strong) IBOutlet UIImageView *prayerImageView;

@end
