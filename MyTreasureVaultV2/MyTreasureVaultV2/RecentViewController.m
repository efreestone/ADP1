// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  RecentViewController.m
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "RecentViewController.h"
//Import recent item object
#import "RecentItems.h"
//Import custom cell
#import "CustomCell.h"
//Import details view controller
#import "DetailsViewController.h"
//Import app delegat
#import "AppDelegate.h"
//Import core data subclass
#import "Items.h"
//Import all items view controller
#import "AllItemsViewController.h"

@interface RecentViewController ()

@end

@implementation RecentViewController {
    NSManagedObjectContext *context;
    AppDelegate *appDelegate;
}

//Synthesize recent items array for getter/setter
@synthesize recentItemsArray, myTableView;
//@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad
{
    //Testing Parse
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    //[testObject saveInBackground];
    
    //Allocate fetched results controller
    //_fetchedResultsController = [[NSFetchedResultsController alloc] init];
    
    //Alocate all items view controller to pass fetched items array
    AllItemsViewController *allItemsViewController = [[AllItemsViewController alloc] init];
    
    //Create instance of AppDelegate and set as delegate for access to core data
    appDelegate = [[UIApplication sharedApplication] delegate];
    //Grab managed object context on app delegate. This is used to check if an sqlite file already exists for the app
    context = [appDelegate managedObjectContext];
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    recentItemsArray = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    //Check if fetched items array exists
    if (recentItemsArray != nil) {
        //reload table view
        [self.tableView reloadData];
        //Pass array of fetched objects to all items view
        allItemsViewController.allItemsArray = recentItemsArray;
    }
    
    /*for (Items *item in recentItemsArray) {
        //NSLog(@"%@", newItem.description);
        NSLog(@"Make: %@ Model: %@", [item valueForKey:@"make"], [item valueForKey:@"model"]);
        //NSLog(@"Zip: %@", [newItem valueForKey:@"model"]);
    }*/
    
	/*if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}*/
    
    //
    if (appDelegate.noDatabase == YES) {
        [self fillDefaultData];
        NSLog(@"Default Data Added");
        allItemsViewController.allItemsArray = recentItemsArray;
    }
    
    
    //Move edit button to left side of nav bar (right is + sign for add item)
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Present log in screen over home/recent. Not currently active or required. Clicking Sign In dismisses the view while clicking cancel shows an alert view
    //Declare storyboard
    /*UIStoryboard *storyboard;
     //Check device and set storyboard accordingly
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
     storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
     } else {
     storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
     }
     //Allocate sign in view controller
     UIViewController *signInVC = [storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
     //Set transition style to flip
     signInVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
     //Present sign in view
     [self presentViewController:signInVC animated:true completion:nil];*/
    
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
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Items"];
    recentItemsArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [myTableView reloadData];
}

/*- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortedItems = [[NSSortDescriptor alloc] initWithKey:@"recentItems.dateAdded" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortedItems]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    for (Items *item in recentItemsArray) {
        //NSLog(@"%@", newItem.description);
        NSLog(@"Make: %@ Model: %@", [item valueForKey:@"make"], [item valueForKey:@"model"]);
        //NSLog(@"Zip: %@", [newItem valueForKey:@"model"]);
    }
    
    return _fetchedResultsController;
    
}*/

#pragma mark - Default Data add

-(void)saveDefault
{
    //Create error object for save
    NSError *error;
    
    //Save item to device after error check
    if ([context save:&error] == NO) {
        //Log out error
        NSLog(@"Save failed: %@", [error localizedDescription]);
    }
}

//Custom method to create default items to fill Core Data storage with
-(void)fillDefaultData
{
    NSString *dateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *dateAddedNS;
    dateString = @"";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    
    NSString *defaultImage = @"defaultImage.png";
    
    Items *newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    
    //Set object attributes to text from text fields using setValue Method
    //Item 1
    [newDefaultItem setValue: @"Google (LG)" forKey:@"make"];
    [newDefaultItem setValue: @"Nexus 5" forKey:@"model"];
    [newDefaultItem setValue: @"123ABCD456789" forKey:@"serial"];
    [newDefaultItem setValue: @"Black 16GB smartphone" forKey:@"details"];
    [newDefaultItem setValue: @"$350" forKey:@"cost"];
    dateString = @"2014-02-11 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"02-11-2014" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //NSLog(@"Default: %@", [newDefaultItem description]);
    //Item 2
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Apple" forKey:@"make"];
    [newDefaultItem setValue: @"MacBook Pro" forKey:@"model"];
    [newDefaultItem setValue: @"A12BCD34EF567" forKey:@"serial"];
    [newDefaultItem setValue: @"Silver 15inch laptop, late 2011 model" forKey:@"details"];
    [newDefaultItem setValue: @"$1500" forKey:@"cost"];
    dateString = @"2014-02-01 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"02-01-2014" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //NSLog(@"Default: %@", [newDefaultItem description]);
    //Item 3
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"ESP LTD" forKey:@"make"];
    [newDefaultItem setValue: @"H-401FM" forKey:@"model"];
    [newDefaultItem setValue: @"ISO123456ABCD" forKey:@"serial"];
    [newDefaultItem setValue: @"Cherryburst electric guitar with case, Seymour Duncan pickups" forKey:@"details"];
    [newDefaultItem setValue: @"$750" forKey:@"cost"];
    dateString = @"2014-01-10 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"01-10-2014" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //NSLog(@"Default: %@", [newDefaultItem description]);
    //Item 4
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Apple" forKey:@"make"];
    [newDefaultItem setValue: @"iPod Classic" forKey:@"model"];
    [newDefaultItem setValue: @"A12BCD34EF567" forKey:@"serial"];
    [newDefaultItem setValue: @"Black 160GB MP3 player" forKey:@"details"];
    [newDefaultItem setValue: @"$200" forKey:@"cost"];
    dateString = @"2014-12-25 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"12-25-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //Item 5
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Amazon" forKey:@"make"];
    [newDefaultItem setValue: @"Kindle Fire HD" forKey:@"model"];
    [newDefaultItem setValue: @"9876ABCD54321" forKey:@"serial"];
    [newDefaultItem setValue: @"Black 7inch Android tablet" forKey:@"details"];
    [newDefaultItem setValue: @"$140" forKey:@"cost"];
    dateString = @"2014-12-25 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"12-25-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //Item 6
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Samsung" forKey:@"make"];
    [newDefaultItem setValue: @"UN40F5500" forKey:@"model"];
    [newDefaultItem setValue: @"1234567890" forKey:@"serial"];
    [newDefaultItem setValue: @"40inch slim LED HDTV" forKey:@"details"];
    [newDefaultItem setValue: @"$600" forKey:@"cost"];
    dateString = @"2014-12-25 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"12-25-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //Item 7
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Apple" forKey:@"make"];
    [newDefaultItem setValue: @"iPad Retina" forKey:@"model"];
    [newDefaultItem setValue: @"ABCDEFG0987" forKey:@"serial"];
    [newDefaultItem setValue: @"Black and silver tablet" forKey:@"details"];
    [newDefaultItem setValue: @"$500" forKey:@"cost"];
    dateString = @"2014-11-21 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"11-21-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //Item 8
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Gateway" forKey:@"make"];
    [newDefaultItem setValue: @"HFX2303L" forKey:@"model"];
    [newDefaultItem setValue: @"1029384756BLAH" forKey:@"serial"];
    [newDefaultItem setValue: @"Black 23inch LED Monitor" forKey:@"details"];
    [newDefaultItem setValue: @"$180" forKey:@"cost"];
    dateString = @"2014-10-13 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"10-13-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //Item 9
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Sony" forKey:@"make"];
    [newDefaultItem setValue: @"VAIO Tap 21" forKey:@"model"];
    [newDefaultItem setValue: @"BIGTABLET1234" forKey:@"serial"];
    [newDefaultItem setValue: @"21inch All-in-one PC/ really big tablet" forKey:@"details"];
    [newDefaultItem setValue: @"$1200" forKey:@"cost"];
    dateString = @"2014-10-10 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"10-10-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    //Item 10
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Subaru" forKey:@"make"];
    [newDefaultItem setValue: @"Legacy AWD Wagon" forKey:@"model"];
    [newDefaultItem setValue: @"SNOWBEAST09876" forKey:@"serial"];
    [newDefaultItem setValue: @"Silver 1993 all wheel drive wagon" forKey:@"details"];
    [newDefaultItem setValue: @"$2000" forKey:@"cost"];
    dateString = @"2014-08-22 12:00:00 +0000";
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"08-22-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [self saveDefault];
    
    
    //[myTableView reloadData];
}

#pragma mark - Table view data source

//Built in method to set number of sections in table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Built in method to set number of rows in section in table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Check length of array. This is to stop a crash because of array length when there is no items in storage. I think the crash is because the view is already loaded before the array is filled but I haven't been able to dig into the issue yet. I feel this is a hacky fix but it works for now.
    /*if ([recentItemsArray count] <= 5) {
        return [recentItemsArray count];
    } else {
        return 5;
    }*/
    // Return the number of rows in the section.
    return [recentItemsArray count];
}

//Built in method to allocate and reuse table view cells and apply item info
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Allocate custom cell
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:@"RecentCell"];
    Items *recentItem = [self.recentItemsArray objectAtIndex:indexPath.row];
    //Cast image string into UIImage
    UIImage *itemImage = [UIImage imageNamed:recentItem.image];
    //Apply image
    cell.cellImage.image = itemImage;
    //Apply make and model
    cell.makeModelLabel.text = [NSString stringWithFormat:@"%@ %@", recentItem.make, recentItem.model];
    cell.detailsLabel.text = recentItem.details;
    cell.dateAddedLabel.text = recentItem.formattedDate;
    
    //Override to remove extra seperator lines after the last cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)]];
    
    return cell;
}

//Built in function to check editing style (-=delete, +=add)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //Check if in delete mode
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"We want to delete row = %d", indexPath.row);
        
        [context deleteObject:[recentItemsArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        //Remove the deleted object from recentItemsArray
        [recentItemsArray removeObjectAtIndex:indexPath.row];
        
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
        Items *recentItem = [recentItemsArray objectAtIndex:indexPath.row];
        //Cast image string into UIImage
        UIImage *itemImage = [UIImage imageNamed:recentItem.image];
        
        NSManagedObject *selectedObject = [recentItemsArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        if (detailsViewController != nil) {
            //Pass title string and NSStrings/image to detail view
            detailsViewController.title = recentItem.model;
            detailsViewController.passedItemImage = itemImage;
            detailsViewController.passedItemMake = recentItem.make;
            detailsViewController.passedItemModel = recentItem.model;
            detailsViewController.passedItemSerial = recentItem.serial;
            detailsViewController.passedItemDetails = recentItem.details;
            detailsViewController.passedItemCost = recentItem.cost;
            detailsViewController.passedItemDateAdded = recentItem.formattedDate;
            detailsViewController.passedManagedObject = selectedObject;
        }
    }
}

@end
