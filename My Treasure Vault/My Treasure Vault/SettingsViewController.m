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
    PFObject *newItem;
}

//Synthesize for getters/setters
@synthesize syncAllSwitch, syncImageSwitch, saveButton, allStoredArray;

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackground-568h.png"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackground~iPad.png"]]];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Manually override cell background color. Seeting cell BG to clear in storyboard worked fine in iPhone sim but iPad and iPad sim both still had a white background.
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //UIImage *pattern = [UIImage imageNamed:@"image.png"];
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Switch Change and Save

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
        
        //Loop through core data and create new PFObject to send to Parse
        /*for (Items *item in allStoredArray) {
            NSLog(@"Make: %@ Model: %@", [item valueForKey:@"make"], [item valueForKey:@"model"]);
            newItem = [PFObject objectWithClassName:@"NewItem"];
            newItem[@"make"] = [item valueForKey:@"make"];
            newItem[@"model"] = [item valueForKey:@"model"];
            newItem[@"serial"] = [item valueForKey:@"serial"];
            newItem[@"details"] = [item valueForKey:@"details"];
            newItem[@"cost"] = [item valueForKey:@"cost"];
            newItem[@"dateAdded"] = [item valueForKey:@"dateAdded"];
            newItem[@"formattedDate"] = [item valueForKey:@"formattedDate"];
            if (syncImageSwitch.isOn) {
                //Check if imageData is set to NSNull object. This is to always skip syncing default item image.
                if ([item valueForKey:@"imageData"] != NULL) {
                    NSLog(@"NULL didn't work");
                    NSString *imageName = [NSString stringWithFormat:@"%@.png", [item valueForKey:@"make"]];
                    //UIImage *uploadImage = [UIImage imageWithData:[item valueForKey:@"imageData"]];
                    PFFile *imageFile = [PFFile fileWithName: imageName data:[item valueForKey:@"imageData"]];
                    newItem[@"imageFile"] = imageFile;
                } else {
                    NSLog(@"Image Data set to NULL so no image was synced");
                }
            }
            //newItem[@"imageData"] = [item valueForKey:@"imageData"];
            //Start save
            [newItem saveInBackground];
        }*/
        //NSLog(@"All switch is ON");
    } else {
        NSLog(@"All switch is OFF");
    }
}

//Triggered when sync image switch is changed
-(IBAction)onSyncImage:(id)sender
{
    NSLog(@"Image switch changed");
    [self noImageSyncAlertView];
}

//Triggered on Save click if sync all if on
-(IBAction)onSave:(id)sender
{
    if (syncAllSwitch.isOn) {
        //Loop through core data and create new PFObject to send to Parse
        for (Items *item in allStoredArray) {
            NSLog(@"Make: %@ Model: %@", [item valueForKey:@"make"], [item valueForKey:@"model"]);
            newItem = [PFObject objectWithClassName:@"NewItem"];
            newItem[@"make"] = [item valueForKey:@"make"];
            newItem[@"model"] = [item valueForKey:@"model"];
            newItem[@"serial"] = [item valueForKey:@"serial"];
            newItem[@"details"] = [item valueForKey:@"details"];
            newItem[@"cost"] = [item valueForKey:@"cost"];
            newItem[@"dateAdded"] = [item valueForKey:@"dateAdded"];
            newItem[@"formattedDate"] = [item valueForKey:@"formattedDate"];
            if (syncImageSwitch.isOn) {
                //Check if imageData is set to NSNull object. This is to always skip syncing default item image.
                if ([item valueForKey:@"imageData"] != NULL) {
                    NSLog(@"NULL didn't work");
                    NSString *imageName = [NSString stringWithFormat:@"%@.png", [item valueForKey:@"make"]];
                    //UIImage *uploadImage = [UIImage imageWithData:[item valueForKey:@"imageData"]];
                    PFFile *imageFile = [PFFile fileWithName: imageName data:[item valueForKey:@"imageData"]];
                    newItem[@"imageFile"] = imageFile;
                } else {
                    NSLog(@"Image Data set to NULL so no image was synced");
                }
            }
            //newItem[@"imageData"] = [item valueForKey:@"imageData"];
            //Start save
            [newItem saveInBackground];
        }
        [self syncAlertView];
    }
}

#pragma mark - Alerts

//Create and show sync alert
-(void)syncAlertView
{
    NSString *syncText;
    if (syncImageSwitch.isOn) {
        syncText = @"Your Items and Images are syncing to the Cloud Server.";
    } else {
        syncText = @"Your Items are syncing to the Cloud Server. Images are not included";
    }
    //Create alert
    UIAlertView *syncAlert = [[UIAlertView alloc] initWithTitle:@"Items Synced" message:syncText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show alert
    [syncAlert show];
}

//Create and show no image alert
-(void)noImageSyncAlertView
{
    if (syncImageSwitch.isOn) {
        UIAlertView *yesImageSyncAlert = [[UIAlertView alloc] initWithTitle: @"Images will sync" message: @"Your Images will be included in the sync to the Cloud Server." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [yesImageSyncAlert show];
    } else {
        UIAlertView *noImageSyncAlert = [[UIAlertView alloc] initWithTitle: @"Images won't sync" message: @"Your Images will be not included in the sync to the Cloud Server." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noImageSyncAlert show];
    }
}

@end