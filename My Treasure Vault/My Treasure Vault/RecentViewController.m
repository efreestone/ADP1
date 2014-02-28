// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  RecentViewController.m
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "RecentViewController.h"
//Import custom cell
#import "CustomCell.h"
//Import details view controller
#import "DetailsViewController.h"
//Import app delegate
#import "AppDelegate.h"
//Import core data subclass
#import "Items.h"
//Import all items view controller
#import "AllItemsViewController.h"
//Import log in subclass
#import "CustomPFLoginViewController.h"
//Import sign in subclass
#import "CustomPFSignUpViewController.h"

@interface RecentViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation RecentViewController {
    NSManagedObjectContext *context;
    AppDelegate *appDelegate;
}

//Synthesize recent items array for getter/setter
@synthesize recentItemsArray, myTableView;

- (void)viewDidLoad
{
    //Check device type and apply background accordingly
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackground-568h.png"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackground~iPad.png"]]];
    }
    
    //Create instance of AppDelegate and set as delegate for access to core data
    appDelegate = [[UIApplication sharedApplication] delegate];
    //Grab managed object context on app delegate. This is used to check if an sqlite file already exists for the app
    context = [appDelegate managedObjectContext];
    
    //Check if fetched items array exists
    if (recentItemsArray != nil) {
        //reload table view
        [self.tableView reloadData];
    }
    
    //Check if a database exists and create defualt items if it doesn't
    if (appDelegate.noDatabase == YES) {
        //Call method to create default data
        [self fillDefaultData];
        NSLog(@"Default Data Added");
    }
    
    //Move edit button to left side of nav bar (right is + sign for add item)
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //This code should be in viewDidAppear but was moved to viewDidLoad to stop the login screen from reappearing when dismissed with the X in top left. Log in isnt required but this has casued Parse to output error messages in the console. Everything does function as it is supposed to though.
    //Boilerplate login code from Parse tutorial "Login and Signup Views" to allocate/present login screen
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller with custom subclass
        CustomPFLoginViewController *logInViewController = [[CustomPFLoginViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        CustomPFSignUpViewController *signUpViewController = [[CustomPFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
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
    NSFetchRequest *recentFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Items"];
    //Set sort descriptor to use dateAdded (NSDate) to sort newest first
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateAdded" ascending:NO];
    [recentFetchRequest setSortDescriptors:@[sortDescriptor]];
    //Set limit of fetch to 5
    [recentFetchRequest setFetchLimit:5];
    //Cast fetched items into mutable array to display
    recentItemsArray = [[managedObjectContext executeFetchRequest:recentFetchRequest error:nil] mutableCopy];
    
    [myTableView reloadData];
    
    //Moved this to viewDidLoad so login screen doesn't reappear if dismissed without loggin in.
    //Boilerplate login code from Parse tutorial "Login and Signup Views" to allocate/present login screen
    /*if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller with custom subclass
        CustomPFLoginViewController *logInViewController = [[CustomPFLoginViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
     
        // Create the sign up view controller
        CustomPFSignUpViewController *signUpViewController = [[CustomPFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
     
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
     
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
     }*/
}

#pragma mark - Default Data add

//custom method to save default item to core data storage
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *dateAddedNS;
    
    NSString *defaultImage = @"defaultImage.png";
    
    //NSData *defaultImageData = UIImagePNGRepresentation(selectedImage);
    
    NSNull *nullData;
    
    Items *newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    
    //Set object attributes to text from text fields using setValue Method
    //Item 1
    [newDefaultItem setValue: @"Google (LG)" forKey:@"make"];
    [newDefaultItem setValue: @"Nexus 5" forKey:@"model"];
    [newDefaultItem setValue: @"123ABCD456789" forKey:@"serial"];
    [newDefaultItem setValue: @"Black 16GB smartphone" forKey:@"details"];
    [newDefaultItem setValue: @"$350" forKey:@"cost"];
    dateString = @"2014-02-11 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"02-11-2014" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //NSLog(@"Default: %@", [newDefaultItem description]);
    //Item 2
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Apple" forKey:@"make"];
    [newDefaultItem setValue: @"MacBook Pro" forKey:@"model"];
    [newDefaultItem setValue: @"A12BCD34EF567" forKey:@"serial"];
    [newDefaultItem setValue: @"Silver 15inch laptop, late 2011 model" forKey:@"details"];
    [newDefaultItem setValue: @"$1500" forKey:@"cost"];
    dateString = @"2014-02-01 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"02-01-2014" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //NSLog(@"Default: %@", [newDefaultItem description]);
    //Item 3
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"ESP LTD" forKey:@"make"];
    [newDefaultItem setValue: @"H-401FM" forKey:@"model"];
    [newDefaultItem setValue: @"ISO123456ABCD" forKey:@"serial"];
    [newDefaultItem setValue: @"Cherryburst electric guitar with case, Seymour Duncan pickups" forKey:@"details"];
    [newDefaultItem setValue: @"$750" forKey:@"cost"];
    dateString = @"2014-01-10 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"01-10-2014" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //NSLog(@"Default: %@", [newDefaultItem description]);
    //Item 4
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Apple" forKey:@"make"];
    [newDefaultItem setValue: @"iPod Classic" forKey:@"model"];
    [newDefaultItem setValue: @"A12BCD34EF567" forKey:@"serial"];
    [newDefaultItem setValue: @"Black 160GB MP3 player" forKey:@"details"];
    [newDefaultItem setValue: @"$200" forKey:@"cost"];
    dateString = @"2013-12-25 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"12-25-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //Item 5
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Amazon" forKey:@"make"];
    [newDefaultItem setValue: @"Kindle Fire HD" forKey:@"model"];
    [newDefaultItem setValue: @"9876ABCD54321" forKey:@"serial"];
    [newDefaultItem setValue: @"Black 7inch Android tablet" forKey:@"details"];
    [newDefaultItem setValue: @"$140" forKey:@"cost"];
    dateString = @"2013-12-25 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"12-25-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //Item 6
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Samsung" forKey:@"make"];
    [newDefaultItem setValue: @"UN40F5500" forKey:@"model"];
    [newDefaultItem setValue: @"1234567890" forKey:@"serial"];
    [newDefaultItem setValue: @"40inch slim LED HDTV" forKey:@"details"];
    [newDefaultItem setValue: @"$600" forKey:@"cost"];
    dateString = @"2013-12-25 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"12-25-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //NSLog(@"Default Samsung: %@", [newDefaultItem description]);
    //Item 7
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Apple" forKey:@"make"];
    [newDefaultItem setValue: @"iPad Retina" forKey:@"model"];
    [newDefaultItem setValue: @"ABCDEFG0987" forKey:@"serial"];
    [newDefaultItem setValue: @"Black and silver tablet" forKey:@"details"];
    [newDefaultItem setValue: @"$500" forKey:@"cost"];
    dateString = @"2013-11-21 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"11-21-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //Item 8
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Gateway" forKey:@"make"];
    [newDefaultItem setValue: @"HFX2303L" forKey:@"model"];
    [newDefaultItem setValue: @"1029384756BLAH" forKey:@"serial"];
    [newDefaultItem setValue: @"Black 23inch LED Monitor" forKey:@"details"];
    [newDefaultItem setValue: @"$180" forKey:@"cost"];
    dateString = @"2013-10-13 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"10-13-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //Item 9
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Sony" forKey:@"make"];
    [newDefaultItem setValue: @"VAIO Tap 21" forKey:@"model"];
    [newDefaultItem setValue: @"BIGTABLET1234" forKey:@"serial"];
    [newDefaultItem setValue: @"21inch All-in-one PC/ really big tablet" forKey:@"details"];
    [newDefaultItem setValue: @"$1200" forKey:@"cost"];
    dateString = @"2013-10-10 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"10-10-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
    [self saveDefault];
    //Item 10
    newDefaultItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [newDefaultItem setValue: @"Subaru" forKey:@"make"];
    [newDefaultItem setValue: @"Legacy AWD Wagon" forKey:@"model"];
    [newDefaultItem setValue: @"SNOWBEAST09876" forKey:@"serial"];
    [newDefaultItem setValue: @"Silver 1993 all wheel drive wagon" forKey:@"details"];
    [newDefaultItem setValue: @"$2000" forKey:@"cost"];
    dateString = @"2013-08-22 12:00:00";
    dateAddedNS = [dateFormatter dateFromString:dateString];
    [newDefaultItem setValue: dateAddedNS forKey:@"dateAdded"];
    [newDefaultItem setValue: @"08-22-2013" forKey:@"formattedDate"];
    [newDefaultItem setValue: defaultImage forKey:@"image"];
    [newDefaultItem setValue: nullData forKey:@"imageData"];
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
    // Return the number of rows in the section.
    return [recentItemsArray count];
}

//Built in method to allocate and reuse table view cells and apply item info
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Allocate custom cell
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:@"RecentCell"];
    Items *recentItem = [self.recentItemsArray objectAtIndex:indexPath.row];
    UIImage *itemImage;
    //Check if imageData exists
    if (recentItem.imageData != nil) {
        //Set image from imageData
        itemImage = [UIImage imageWithData:recentItem.imageData];
    } else {
        //Apply default image not stored locally. Not stored in core data or synced to Parse
        itemImage = [UIImage imageNamed:recentItem.image];
    }
    
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
    
    int rowSelected = indexPath.row;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"We want to delete row = %d", indexPath.row);
        
        //Remove the object from storage
        [context deleteObject:[recentItemsArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        NSMutableDictionary *newInsert = [recentItemsArray objectAtIndex:rowSelected];
        NSLog(@"new insert: %@", [newInsert description]);
        
        //Remove the deleted object from recentItemsArray
        [recentItemsArray removeObjectAtIndex:indexPath.row];
        
        //Remove object from table view with animation. Receiving warning "local declaration of "tableView" hides instance variable". I may be missing something here but isn't this an Accessor method?
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
        //[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
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
        UIImage *itemImage;
        //Check if imageData exists
        if (recentItem.imageData != nil) {
            //Cast image from data. Not sure why but this sets it in landscape mode
            itemImage = [UIImage imageWithData:recentItem.imageData];
        } else {
            //Set image to default image
            itemImage = [UIImage imageNamed:recentItem.image];
        }
        
        //Grab selected managed object
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

#pragma mark - PFLogInViewControllerDelegate

//These are defualt delegate methods for the Parse Login and are essentially unmodified. Added to get basic use of the login/signup framework Parse provides
// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}

#pragma mark - PFSignUpViewControllerDelegate

//These are defualt delegate methods for the Parse Signup and are essentially unmodified. Added to get basic use of the login/signup framework Parse provides
// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

@end