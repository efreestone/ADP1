// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  SettingsViewController.m
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "SettingsViewController.h"
//Import app delegate
#import "AppDelegate.h"
//Import core data subclass
#import "Items.h"
//Import Parse framework
#import <Parse/Parse.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController {
    AppDelegate *appDelegate;
    Items *allItems;
}

//Synthesize for getters/setters
@synthesize syncAllSwitch, syncImageSwitch, allStoredArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Switch Change

//Triggered when sync all switch is changed
-(IBAction)onSyncAll:(id)sender
{
    if (syncAllSwitch.isOn) {
        //Allocate app delegate
        appDelegate = [[AppDelegate alloc] init];
        //Allocate Items object
        allItems = [[Items alloc] init];
        
        // Fetch the items from persistent data store
        NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Items"];
        allStoredArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        //NSLog(@"%@", [allStoredArray description]);
        
        for (Items *item in allStoredArray) {
            NSLog(@"Make: %@ Model: %@", [item valueForKey:@"make"], [item valueForKey:@"model"]);
            PFObject *newItem = [PFObject objectWithClassName:@"NewItem"];
            newItem[@"make"] = [item valueForKey:@"make"];
            newItem[@"model"] = [item valueForKey:@"model"];
            newItem[@"serial"] = [item valueForKey:@"serial"];
            newItem[@"details"] = [item valueForKey:@"details"];
            newItem[@"cost"] = [item valueForKey:@"cost"];
            newItem[@"dateAdded"] = [item valueForKey:@"dateAdded"];
            newItem[@"formattedDate"] = [item valueForKey:@"formattedDate"];
            
            [newItem saveInBackground];
        }
        
        //NSLog(@"All switch is ON");
    } else {
        NSLog(@"All switch is OFF");
    }
}

//Triggered when sync image switch is changed
-(IBAction)onSyncImage:(id)sender
{
    NSLog(@"Image switch changed");
    UIAlertView *syncAlert = [[UIAlertView alloc] initWithTitle: @"Images would have synced" message: @"Your Images would have been synced, but this bit of code hasn't been written yet." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [syncAlert show];
}

@end