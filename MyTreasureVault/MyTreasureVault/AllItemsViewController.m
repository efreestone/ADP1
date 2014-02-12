// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  AllItemsViewController.m
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/11/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "AllItemsViewController.h"
//Import all item
#import "AllItems.h"
//Import custom cell
#import "CustomCell.h"

@interface AllItemsViewController ()

@end

@implementation AllItemsViewController

//Synthesize recent items array for getter/setter
@synthesize allItemsArray;

- (void)viewDidLoad
{
    //Create recent items array and fill. Each new item entry is a new instance of RecentItems container class
    allItemsArray = [NSMutableArray arrayWithCapacity:20];
    //Item 1 with cast/alloc of all items object
    AllItems *allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Google (LG)";
    allItem.itemModel = @"Nexus 5";
    allItem.itemSerial = @"123ABCD456789";
    allItem.itemDetails = @"Black 16GB smartphone";
    allItem.itemCost = @"$350";
    allItem.dateAdded = @"2-11-2014";
    [allItemsArray addObject:allItem];
    //Item 2
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Apple";
    allItem.itemModel = @"MacBook Pro";
    allItem.itemSerial = @"A12BCD34EF567";
    allItem.itemDetails = @"Silver 15inch laptop, late 2011 model";
    allItem.itemCost = @"$1500";
    allItem.dateAdded = @"2-1-2014";
    [allItemsArray addObject:allItem];
    //Item 3
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"ESP LTD";
    allItem.itemModel = @"H-401FM";
    allItem.itemSerial = @"ISO123456ABCD";
    allItem.itemDetails = @"Cherryburst electric guitar with case, Seymour Duncan pickups";
    allItem.itemCost = @"$750";
    allItem.dateAdded = @"1-10-2014";
    [allItemsArray addObject:allItem];
    //Item 4
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Apple";
    allItem.itemModel = @"iPod Classic";
    allItem.itemSerial = @"A12BCD34EF567";
    allItem.itemDetails = @"Black 160GB MP3 player";
    allItem.itemCost = @"$200";
    allItem.dateAdded = @"12-25-2013";
    [allItemsArray addObject:allItem];
    //Item 5
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Amazon";
    allItem.itemModel = @"Kindle Fire HD";
    allItem.itemSerial = @"9876ABCD54321";
    allItem.itemDetails = @"Black 7inch";
    allItem.itemCost = @"$140";
    allItem.dateAdded = @"12-25-2013";
    [allItemsArray addObject:allItem];
    //Item 6
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Samsung";
    allItem.itemModel = @"UN40F5500";
    allItem.itemSerial = @"1234567890";
    allItem.itemDetails = @"40inch slim LED HDTV";
    allItem.itemCost = @"$600";
    allItem.dateAdded = @"12-25-2013";
    [allItemsArray addObject:allItem];
    //Item 7
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Apple";
    allItem.itemModel = @"iPad Retina";
    allItem.itemSerial = @"ABCDEFG0987";
    allItem.itemDetails = @"Black and silver tablet";
    allItem.itemCost = @"$500";
    allItem.dateAdded = @"11-21-2013";
    [allItemsArray addObject:allItem];
    //Item 8
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Gateway";
    allItem.itemModel = @"HFX2303L";
    allItem.itemSerial = @"1029384756BLAH";
    allItem.itemDetails = @"Black 23inch LED Monitor";
    allItem.itemCost = @"$180";
    allItem.dateAdded = @"10-13-2013";
    [allItemsArray addObject:allItem];
    //Item 9
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Sony";
    allItem.itemModel = @"VAIO Tap 21";
    allItem.itemSerial = @"BIGTABLET1234";
    allItem.itemDetails = @"21inch All-in-one PC/ really big tablet";
    allItem.itemCost = @"$1200";
    allItem.dateAdded = @"10-10-2013";
    [allItemsArray addObject:allItem];
    //Item 10
    allItem = [[AllItems alloc] init];
    allItem.imageOne = [UIImage imageNamed:@"defaultImage.png"];
    allItem.itemMake = @"Subaru";
    allItem.itemModel = @"Legacy AWD Wagon";
    allItem.itemSerial = @"SNOWBEAST09876";
    allItem.itemDetails = @"Silver 1993 all wheel drive wagon";
    allItem.itemCost = @"$2000";
    allItem.dateAdded = @"8-22-2013";
    [allItemsArray addObject:allItem];
    
    //Move edit button to left side of nav bar (right is + sign for add item)
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

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
    return [self.allItemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:@"AllItemCell"];
	AllItems *allItem = [self.allItemsArray objectAtIndex:indexPath.row];
    cell.cellImage.image = allItem.imageOne;
	cell.makeModelLabel.text = [NSString stringWithFormat:@"%@ %@", allItem.itemMake, allItem.itemModel];
	cell.detailsLabel.text = allItem.itemDetails;
    cell.dateAddedLabel.text = allItem.dateAdded;
    
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
        [allItemsArray removeObjectAtIndex:indexPath.row];
        
        //Remove object from table view with animation. Receiving warning "local declaration of "tableView" hides instance variable". I may be missing something here but isn't this an Accessor method?
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
    }
}


@end
