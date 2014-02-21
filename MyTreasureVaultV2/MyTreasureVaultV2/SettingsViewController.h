// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  SettingsViewController.h
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
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
-(IBAction)syncAllSwitch:(id)sender;
-(IBAction)syncImageSwitch:(id)sender;

@end
