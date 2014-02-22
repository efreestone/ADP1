// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  RecentViewController.h
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>
//Import Parse Framework
#import <Parse/Parse.h>

@interface RecentViewController : UITableViewController

//Declare table view
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

//Declare array to hold recent items
@property (nonatomic, strong) NSMutableArray *recentItemsArray;

//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

//Declare default data fill methods
-(void)fillDefaultData;
-(void)saveDefault;

@end
