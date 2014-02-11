// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  RecentViewController.h
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/11/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentViewController : UITableViewController

//Declare array to hold recent items
@property (nonatomic, strong) NSMutableArray *recentItemsArray;

@end
