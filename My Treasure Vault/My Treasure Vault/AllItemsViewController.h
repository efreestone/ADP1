// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  AllItemsViewController.h
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllItemsViewController : UITableViewController

//Declare array to hold all items
@property (nonatomic, strong) NSMutableArray *allItemsArray;
//Declare table view
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end