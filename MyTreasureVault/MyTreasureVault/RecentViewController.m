// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  RecentViewController.m
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/11/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "RecentViewController.h"

@interface RecentViewController ()

@end

@implementation RecentViewController

//Synthesize recent items array for getter/setter
@synthesize recentItemsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.recentItemsArray count];
}


@end
