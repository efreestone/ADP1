// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  AddItemViewController.m
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "AddItemViewController.h"
//Import image view controller
#import "ImageViewController.h"
//Import app delegate
#import "AppDelegate.h"
//Import Items Core Data subclass
#import "Items.h"
//Import recent view controller
#import "RecentViewController.h"
//Import Asset Library
#import <AssetsLibrary/AssetsLibrary.h>

@interface AddItemViewController ()

@end

@implementation AddItemViewController {
    //Declare image view
    ImageViewController *imageViewController;
    //Declare images
    UIImage *selectedImage;
    UIImage *editedImage;
}

@synthesize makeTextField, modelTextField, serialTextField, detailsTextField, costTextField, syncSwitch, passedManagedObject, passedImageURL;

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
    imageViewController = [[ImageViewController alloc] init];
    
    if (passedManagedObject != nil) {
        makeTextField.text = [passedManagedObject valueForKey:@"make"];
        modelTextField.text = [passedManagedObject valueForKey:@"model"];
        serialTextField.text = [passedManagedObject valueForKey:@"serial"];
        detailsTextField.text = [passedManagedObject valueForKey:@"details"];
        costTextField.text = [passedManagedObject valueForKey:@"cost"];
    }
    
    NSLog(@"Make: %@", makeTextField.text);
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

//Triggered when cancel button is hit
-(IBAction)onCancel:(id)sender
{
    //Dismiss view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Triggered when save button is hit
-(IBAction)onSave:(id)sender
{
    //Create instance of AppDelegate and set as delegate for access to core data
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //Grab managed object context on app delegate
    NSManagedObjectContext *objectContext = [appDelegate managedObjectContext];
    //Create new item object
    //Items *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:objectContext];
    //Set default image string
    NSString *defaultImage = @"defaultImage.png";
    
    //Grab current date to set NSDate object on Core Data. Also formatting date as string for display
    NSDate *currentDate = [NSDate date];
    if (currentDate != nil) {
        //Format date for display and cast into formattedDate
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if (dateFormatter != nil) {
            //Set formatted date to month-day-year (02-17-2014)
            [dateFormatter setDateFormat:@"MM-dd-yyyy"];
            //[dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
            formattedDate = [dateFormatter stringFromDate:currentDate];
        }
        //NSLog(@"date = %@", formattedDate);
    }
    
    //Check if item was passed. This pass happens from the edit button on detail view
    if (self.passedManagedObject) {
        [passedManagedObject setValue: makeTextField.text forKey:@"make"];
        [passedManagedObject setValue: modelTextField.text forKey:@"model"];
        [passedManagedObject setValue: serialTextField.text forKey:@"serial"];
        [passedManagedObject setValue: detailsTextField.text forKey:@"details"];
        [passedManagedObject setValue: costTextField.text forKey:@"cost"];
        [passedManagedObject setValue: currentDate forKey:@"dateAdded"];
        [passedManagedObject setValue: formattedDate forKey:@"formattedDate"];
    } else {
        //Create new item
        Items *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:objectContext];
        [newItem setValue: makeTextField.text forKey:@"make"];
        [newItem setValue: modelTextField.text forKey:@"model"];
        [newItem setValue: serialTextField.text forKey:@"serial"];
        [newItem setValue: detailsTextField.text forKey:@"details"];
        [newItem setValue: costTextField.text forKey:@"cost"];
        [newItem setValue: currentDate forKey:@"dateAdded"];
        [newItem setValue: formattedDate forKey:@"formattedDate"];
        //Check if passedImageURL is nil
        if (passedImageURL == nil) {
            //set image to default image
            [newItem setValue: defaultImage forKey:@"image"];
        } else {
            NSString *imageURLString = [passedImageURL absoluteString];
            [newItem setValue: imageURLString forKey:@"image"];
        }
    }
    
    //If sync item is switched to yes, sync single item to server
    if (syncSwitch.isOn) {
        PFObject *newItem = [PFObject objectWithClassName:@"NewItem"];
        newItem[@"make"] = makeTextField.text;
        newItem[@"model"] = modelTextField.text;
        newItem[@"serial"] = serialTextField.text;
        newItem[@"details"] = detailsTextField.text;
        newItem[@"cost"] = costTextField.text;
        
        [newItem saveInBackground];
    }
    
    //Clear out text fields
    makeTextField.text = @"";
    modelTextField.text = @"";
    serialTextField.text = @"";
    detailsTextField.text = @"";
    costTextField.text = @"";
    //Create error object for save
    NSError *error;
    //Save item to device after error check
    if ([objectContext save:&error] == NO) {
        //Log out error
        NSLog(@"Save failed: %@", [error localizedDescription]);
    } else {
        //Create and show save success alert
        UIAlertView *savedAlert = [[UIAlertView alloc] initWithTitle: @"Item Saved" message: @"Your item was saved successfully!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [savedAlert show];
        //[objectContext save:&error];
        //NSLog(@"%@", newItem.description);
    }
    
    //Test for stored item
    /*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:objectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [objectContext executeFetchRequest:fetchRequest error:&error];
    for (Items *item in fetchedObjects) {
        //NSLog(@"%@", newItem.description);
        NSLog(@"Make: %@ Model: %@", [item valueForKey:@"make"], [item valueForKey:@"model"]);
        //NSLog(@"Zip: %@", [newItem valueForKey:@"model"]);
    }*/
    
    RecentViewController *recentViewController = [[RecentViewController alloc] init];
    
    [recentViewController.myTableView reloadData];
    
    //Dismiss view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Camera

//onClick triggered by camera button click
-(IBAction)onClick:(id)sender
{
    //Create instance of picker controller
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    if (pickerController != nil) {
        //Make sure camera is available
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //Set image picker delegate
            pickerController.delegate = self;
            //Set editing
            pickerController.allowsEditing = false;
            //Present picker controller in camera mode
            [self presentViewController:pickerController animated:true completion:nil];
            //NSLog(@"Camera button clicked");
        } else {
            //Trigger no camera alert
            [self noCameraAlertView];
            //NSLog(@"Camera not available");
        }
        //[self.navigationController pushViewController:imageViewController animated:true];
        //[self presentViewController:imageViewController animated:true completion:nil];
    }
}

//Built in method to capture media selection
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Initialize/allocate image view controller
    //ImageViewController *imageViewController = [[ImageViewController alloc] init];
    
    NSLog(@"%@", [info description]);
    
    selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (selectedImage != nil) {
        imageViewController.passedNewImage = selectedImage;
        
        NSLog(@"%@", [selectedImage description]);
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        //Save the image using asset library to grab URL
        [library writeImageToSavedPhotosAlbum:[selectedImage CGImage] orientation:(ALAssetOrientation)[selectedImage imageOrientation] completionBlock:^(NSURL *imageURL, NSError *error){
            if (error) {
                [self errorAlertView];
            } else {
                NSLog(@"url %@", imageURL);
                //
                passedImageURL = imageURL;
                [self saveSuccessfulAlertView];
                //[self dismissViewControllerAnimated:true completion:nil];
            }
        }];
    }
    
    //Cast edited image into a UIImage
    editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (editedImage != nil) {
        //Pass image to UIImage in image view
        imageViewController.passedNewImage = editedImage;
    }
    //Dismiss picker view
    [picker dismissViewControllerAnimated:true completion:nil];
}

//Built in method to capture cancel button selection in picker
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //Dismiss picker view
    [picker dismissViewControllerAnimated:true completion:nil];
    //Dismiss image view. This segue happens when the camera button is hit
    [self.navigationController popViewControllerAnimated:true];
}

//Save selector method
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error != nil) {
        //Show error alert
        [self errorAlertView];
        //NSLog(@"Error saving file");
    } else {
        //Show saved alert
        [self saveSuccessfulAlertView];
        //NSLog(@"Save was completed");
    }
}

#pragma mark - Alerts

//Create and show no camera alert
-(void)noCameraAlertView
{
    //Create alert
    UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"No Camera!" message:@"We're sorry, but your device does not have a camera available to take pictures." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show alert
    [noCameraAlert show];
}

//Create and show save successful alert
-(void)saveSuccessfulAlertView {
    //Create saved alert
    UIAlertView *saveSuccessfulAlert = [[UIAlertView alloc] initWithTitle:@"Saved!" message:@"Your image was successfully saved to your album" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show saved alert
    [saveSuccessfulAlert show];
}

//Create and show error alert view
-(void)errorAlertView {
    //Create error alert
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"An error occurred while attempting to save the image. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show error alert
    [errorAlert show];
}

#pragma mark - Segue

//Built in method to pass data with segue to another view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Verify identifier of push segue to photos view from camera
    if ([segue.identifier isEqualToString:@"CameraView"]) {
        //Grab destination view controller
        imageViewController = segue.destinationViewController;
        
        if (imageViewController != nil) {
            //These are set in didFinishPickingMediaWithInfo
            //imageViewController.passedNewImage = selectedImage;
            //imageViewController.passedNewImage = editedImage;
        }
    }
}


@end
