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

#import "AppDelegate.h"

#import "Items.h"

@interface RecentViewController ()

@end

@implementation RecentViewController {
    NSManagedObjectContext *context;
}

//Synthesize recent items array for getter/setter
@synthesize recentItemsArray, myTableView;

- (void)viewDidLoad
{
    //Create instance of AppDelegate and set as delegate for access to core data
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //Grab managed object context on app delegate. This is used to check if an sqlite file already exists for the app
    context = [appDelegate managedObjectContext];
    //Create new item object
    //Items *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    
    // Custom code here...
    // Save the managed object context
    /*NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while saving %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        exit(1);
    }*/
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    recentItemsArray = [context executeFetchRequest:fetchRequest error:&error];
    for (Items *item in recentItemsArray) {
        //NSLog(@"%@", newItem.description);
        NSLog(@"Make: %@ Model: %@", [item valueForKey:@"make"], [item valueForKey:@"model"]);
        //NSLog(@"Zip: %@", [newItem valueForKey:@"model"]);
    }
    
    if (appDelegate.databaseExists == YES) {
        [self fillDefaultData];
        NSLog(@"Default Data Added");
    }
    
    //NSLog(@"Default Items: %@", defaultItems.description);
    
    /*//Create recent items array and fill. Each new item entry is a new instance of RecentItems container class
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
    [recentItemsArray addObject:recentItem];*/
    
    //NSLog(@"%@", [recentItemsArray description]);
    
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

    
    [myTableView reloadData];
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
    // Return the number of rows in the section.
    return 5;
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

/*-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *managedObject = [context objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:managedObject];
        [self.managedObjectContext save:nil];
    }
}*/

//Built in function to check editing style (-=delete, +=add)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //Check if in delete mode
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"We want to delete row = %d", indexPath.row);
        
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
        }
    }
}

@end
