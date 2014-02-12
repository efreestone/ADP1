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
//Import recent item
#import "RecentItems.h"
//Import custom cell
#import "CustomCell.h"

@interface RecentViewController ()

@end

@implementation RecentViewController

//Synthesize recent items array for getter/setter
@synthesize recentItemsArray;

- (void)viewDidLoad
{
    //Create recent items array and fill. Each new item entry is a new instance of RecentItems container class
    recentItemsArray = [NSMutableArray arrayWithCapacity:20];
    //Item 1 with cast/alloc of recent items object
    RecentItems *recentItem = [[RecentItems alloc] init];
    recentItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    recentItem.itemMake = @"Google (LG)";
    recentItem.itemModel = @"Nexus 5";
    recentItem.itemSerial = @"123ABCD456789";
    recentItem.itemDetails = @"Black 16GB smartphone";
    recentItem.itemCost = @"$350";
    recentItem.dateAdded = @"2-11-2014";
    [recentItemsArray addObject:recentItem];
    //Item 2
    recentItem = [[RecentItems alloc] init];
    recentItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    recentItem.itemMake = @"Apple";
    recentItem.itemModel = @"MacBook Pro";
    recentItem.itemSerial = @"A12BCD34EF567";
    recentItem.itemDetails = @"Silver 15inch laptop, late 2011 model";
    recentItem.itemCost = @"$1500";
    recentItem.dateAdded = @"2-1-2014";
    [recentItemsArray addObject:recentItem];
    //Item 3
    recentItem = [[RecentItems alloc] init];
    recentItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    recentItem.itemMake = @"ESP LTD";
    recentItem.itemModel = @"H-401FM";
    recentItem.itemSerial = @"ISO123456ABCD";
    recentItem.itemDetails = @"Cherryburst electric guitar with case, Seymour Duncan pickups";
    recentItem.itemCost = @"$750";
    recentItem.dateAdded = @"1-10-2014";
    [recentItemsArray addObject:recentItem];
    //Item 4
    recentItem = [[RecentItems alloc] init];
    recentItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    recentItem.itemMake = @"Apple";
    recentItem.itemModel = @"iPod Classic";
    recentItem.itemSerial = @"A12BCD34EF567";
    recentItem.itemDetails = @"Black 160GB MP3 player";
    recentItem.itemCost = @"$200";
    recentItem.dateAdded = @"12-25-2013";
    [recentItemsArray addObject:recentItem];
    //Item 5
    recentItem = [[RecentItems alloc] init];
    recentItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    recentItem.itemMake = @"Amazon";
    recentItem.itemModel = @"Kindle Fire HD";
    recentItem.itemSerial = @"9876ABCD54321";
    recentItem.itemDetails = @"Black 7inch";
    recentItem.itemCost = @"$140";
    recentItem.dateAdded = @"12-25-2013";
    [recentItemsArray addObject:recentItem];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:@"RecentCell"];
	RecentItems *recentItem = [self.recentItemsArray objectAtIndex:indexPath.row];
    cell.cellImage.image = recentItem.imageOne;
	cell.makeModelLabel.text = recentItem.itemMake;
	cell.detailsLabel.text = recentItem.itemDetails;
    cell.dateAddedLabel.text = recentItem.dateAdded;
    
    //Override to remove extra seperator lines after the last cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)]];
    
    return cell;
}

//Built in function to check editing style (-=delete, +=add)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //Check if in delete mode
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"We want to delete row = %d", indexPath.row);
        
        //Remove the deleted object from locationsArray
        [recentItemsArray removeObjectAtIndex:indexPath.row];
        
        //Remove object from table view with animation. Receiving warning "local declaration of "tableView" hides instance variable". I may be missing something here but isn't this an Accessor method?
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
    }
}

@end
