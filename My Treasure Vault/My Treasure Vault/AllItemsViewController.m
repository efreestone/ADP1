// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  AllItemsViewController.m
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "AllItemsViewController.h"
//Import custom cell
#import "CustomCell.h"
//Import details view controller
#import "DetailsViewController.h"
//Import core data subclass Items
#import "Items.h"
//Import app delegate
#import "AppDelegate.h"

@interface AllItemsViewController ()

@end

@implementation AllItemsViewController {
    NSManagedObjectContext *context;
    AppDelegate *appDelegate;
}

//Synthesize recent items array for getter/setter
@synthesize allItemsArray, myTableView;

- (void)viewDidLoad
{
    //Create instance of AppDelegate and set as delegate for access to core data
    appDelegate = [[UIApplication sharedApplication] delegate];
    //Grab managed object context on app delegate. This is used to check if an sqlite file already exists for the app
    context = [appDelegate managedObjectContext];
    
    /*NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    allItemsArray = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];*/
    
    //NSLog(@"All items: %@", [allItemsArray description]);
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the items from persistent data store
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Items"];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateAdded" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    allItemsArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [myTableView reloadData];
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

//Built in method to allocate and reuse table view cells and apply item info
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Allocate custom cell
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:@"AllItemCell"];
    Items *allItem = [self.allItemsArray objectAtIndex:indexPath.row];
    //Cast image string into UIImage
    UIImage *itemImage = [UIImage imageNamed:allItem.image];
    //Apply image
    cell.cellImage.image = itemImage;
    //Apply make and model
    cell.makeModelLabel.text = [NSString stringWithFormat:@"%@ %@", allItem.make, allItem.model];
    cell.detailsLabel.text = allItem.details;
    cell.dateAddedLabel.text = allItem.formattedDate;
    
    //Override to remove extra seperator lines after the last cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)]];
    
    return cell;
}

//Built in function to check editing style (-=delete, +=add)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Check if in delete mode
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [context deleteObject:[allItemsArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        //Remove the deleted object from recentItemsArray
        [allItemsArray removeObjectAtIndex:indexPath.row];
        
        //Remove object from table view with animation. Receiving warning "local declaration of "tableView" hides instance variable". I may be missing something here but isn't this an Accessor method?
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
    }
}

#pragma mark - Segue

//Built in method to pass data during segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Verify identifier of push segue to Details view
    if ([segue.identifier isEqualToString:@"DetailView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //Grab destination view controller
        DetailsViewController *detailsViewController = segue.destinationViewController;
        //Grab instance of recentItem object
        Items *allItem = [allItemsArray objectAtIndex:indexPath.row];
        //Cast image string into UIImage
        UIImage *itemImage = [UIImage imageNamed:allItem.image];
        
        NSManagedObject *selectedObject = [allItemsArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        if (detailsViewController != nil) {
            //Pass title string and NSStrings/image to detail view
            detailsViewController.title = allItem.model;
            detailsViewController.passedItemImage = itemImage;
            detailsViewController.passedItemMake = allItem.make;
            detailsViewController.passedItemModel = allItem.model;
            detailsViewController.passedItemSerial = allItem.serial;
            detailsViewController.passedItemDetails = allItem.details;
            detailsViewController.passedItemCost = allItem.cost;
            detailsViewController.passedItemDateAdded = allItem.formattedDate;
            detailsViewController.passedManagedObject = selectedObject;
        }
    }
}

@end