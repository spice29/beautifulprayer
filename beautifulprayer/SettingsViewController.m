//
//  SettingsViewController.m
//  beautifulprayer
//
//  Created by Adrian Domanico on 2015-03-16.
//  Copyright (c) 2015 adrian. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsCell.h"

#import "StyleManager.h"
#import "LocalStore.h"

#import "PrayerLocaleManager.h"

@interface SettingsViewController ()

@property (nonatomic,strong) NSIndexPath *lastSelectedMadhab;
@property (nonatomic,strong) NSIndexPath *lastSelectedMethod;

@end

@implementation SettingsViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingsCell" bundle:nil] forCellReuseIdentifier:@"SettingsCell"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [StyleManager defaultSubFont:@"Black" WithSize:17.0], NSForegroundColorAttributeName : [StyleManager defaultDarkGrayColor:0.9]}];
    
    self.title = @"Settings";
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed:)];
    self.navigationItem.rightBarButtonItem = doneBtn;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BAPrayerMadhab madhabSetting = [[LocalStore sharedInstance] madhabPreference];
    BAPrayerMethod methodSetting = [[LocalStore sharedInstance] methodPreference];
    
    self.lastSelectedMadhab = [NSIndexPath indexPathForRow:madhabSetting-1 inSection:0];
    self.lastSelectedMethod = [NSIndexPath indexPathForRow:methodSetting-1 inSection:1];
    
    [self.tableView selectRowAtIndexPath:self.lastSelectedMadhab animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    [self.tableView selectRowAtIndexPath:self.lastSelectedMethod animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI Events

- (IBAction) donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView Datasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return 2;
    }
    return 10;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section==0){
        return @"Madhab";
    }
    return @"Method";
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    
    if(indexPath.section == 0){
        [cell setLabelWithMadhab:(int)indexPath.row];
    }
    else{
        [cell setLabelWithMethod:(int)indexPath.row];
    }
    
    return cell;
}

#pragma marl - TableView Delegate

- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        if([self.lastSelectedMadhab isEqual:indexPath]){
            return NO;
        }
    }
    else{
        if([self.lastSelectedMethod isEqual:indexPath]){
            return NO;
        }
    }
    return YES;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        for (int i = 0; i < [tableView numberOfRowsInSection:0] ;i++) {
            if(indexPath.row != i)
                [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO];
        }
        
        [[LocalStore sharedInstance] setMadhabSetting:(BAPrayerMadhab)indexPath.row+1];
        
        self.lastSelectedMadhab = indexPath;
    }
    else if (indexPath.section == 1){
        for (int i = 0; i < [tableView numberOfRowsInSection:1] ;i++) {
            if(indexPath.row != i)
                [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1] animated:NO];
        }
        
        [[LocalStore sharedInstance] setMethodSetting:(BAPrayerMethod)indexPath.row+1];
        
        self.lastSelectedMethod = indexPath;
    }
    
    [[PrayerLocaleManager sharedInstance] updateLocationAndPrayerTimes];
}

@end
