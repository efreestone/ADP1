// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  SettingsViewController.h
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController

//Declare switch IBOutlets
@property (strong, nonatomic) IBOutlet UISwitch *syncAllSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *syncImageSwitch;

//Declare array to hold items from storage for sync
@property (strong, nonatomic) NSMutableArray *allStoredArray;

//Declare IBActions for switch changes
-(IBAction)onSyncAll:(id)sender;
-(IBAction)onSyncImage:(id)sender;

@end
