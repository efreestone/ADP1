// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  AddItemViewController.m
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
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
    NSData *imageData;
    UIImage *scaledImage;
    Items *newItem;
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackground-568h.png"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackground~iPad.png"]]];
    }
    
    //Allocate image view controller
    imageViewController = [[ImageViewController alloc] init];
    
    //If coming from detail view edit button, set text fields to passed values
    if (passedManagedObject != nil) {
        makeTextField.text = [passedManagedObject valueForKey:@"make"];
        modelTextField.text = [passedManagedObject valueForKey:@"model"];
        serialTextField.text = [passedManagedObject valueForKey:@"serial"];
        detailsTextField.text = [passedManagedObject valueForKey:@"details"];
        costTextField.text = [passedManagedObject valueForKey:@"cost"];
    }
    
    //Set make text field to be first responder
    [makeTextField becomeFirstResponder];
    
    //NSLog(@"Make: %@", makeTextField.text);
    
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
    NSString *defaultImageString = @"defaultImage.png";
    
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
    
    if (![makeTextField.text  isEqual: @""] && ![modelTextField.text isEqual: @""]) {
        //Check if item was passed. This pass happens from the edit button on detail view
        if (self.passedManagedObject) {
            NSLog(@"PMO 1: %@", [passedManagedObject description]);
            //Edit mode.  Fill text fields with passed object values
            [passedManagedObject setValue: makeTextField.text forKey:@"make"];
            [passedManagedObject setValue: modelTextField.text forKey:@"model"];
            [passedManagedObject setValue: serialTextField.text forKey:@"serial"];
            [passedManagedObject setValue: detailsTextField.text forKey:@"details"];
            [passedManagedObject setValue: costTextField.text forKey:@"cost"];
            [passedManagedObject setValue: currentDate forKey:@"dateAdded"];
            [passedManagedObject setValue: formattedDate forKey:@"formattedDate"];
            //[passedManagedObject setValue: imageData forKey:@"imageData"];
            if (scaledImage != nil) { //[[passedManagedObject valueForKey:@"image"] isEqualToString:@"defaultImage.png"] &&
                imageData = UIImageJPEGRepresentation(scaledImage, 0.5);
                [passedManagedObject setValue: imageData forKey:@"imageData"];
                [passedManagedObject setValue: @"" forKey:@"image"];
            }
            
        } else {
            //Create new item
            newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:objectContext];
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
                [newItem setValue: defaultImageString forKey:@"image"];
                //Create default UIImage
                UIImage *defaultImage = [UIImage imageNamed:defaultImageString];
                //Compress default image into NSData with highest comp rate
                imageData = UIImageJPEGRepresentation(defaultImage, 0.0);
                NSLog(@"default image data = %lu", (unsigned long)[imageData length]);
            } else {
                NSString *imageURLString = [passedImageURL absoluteString];
                //Package and compress image into NSData
                imageData = UIImageJPEGRepresentation(scaledImage, 0.5);
                NSLog(@"imageData: %lu", (unsigned long)[imageData length]);
                [newItem setValue: imageURLString forKey:@"image"];
                [newItem setValue: imageData forKey:@"imageData"];
            }
            
        }
        
    
        //If sync item is switched to yes, sync single item to server
        if (syncSwitch.isOn) {
            //Create new object to upload to Parse
            PFObject *newPFObject = [PFObject objectWithClassName:@"NewItem"];
            //Set values for new object
            newPFObject[@"make"] = makeTextField.text;
            newPFObject[@"model"] = modelTextField.text;
            newPFObject[@"serial"] = serialTextField.text;
            newPFObject[@"details"] = detailsTextField.text;
            newPFObject[@"cost"] = costTextField.text;
            newPFObject[@"dateAdded"] = currentDate;
            newPFObject[@"formattedDate"] = formattedDate;
            //newPFObject[@"imageData"] = imageData;
        
            //Create string for use in naming images
            NSString *imageName;// = [NSString stringWithFormat:@"%@.png", makeTextField.text];
            //Check if scaled image exists. If yes, image from camera was added
            if (scaledImage != nil) {
                NSLog(@"scaled image exists");
                //Set image name to "make" of item
                imageName = [NSString stringWithFormat:@"%@.png", makeTextField.text];
                //Create PFFile of image data to upload
                PFFile *imageFile = [PFFile fileWithName: imageName data:imageData];
                newPFObject[@"imageFile"] = imageFile;
            } else {
                //Set image name to default
                imageName = @"default.png";
                //Create PFFile with default image data. I didn't want to ever upload the defualt image, nut for some reason setting the "imageFile" to NSNull object did not work here.
                PFFile *imageFile = [PFFile fileWithName: imageName data:imageData];
                newPFObject[@"imageFile"] = imageFile;
            }
            //Save item to Parse
            [newPFObject saveInBackground];
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
        //Dismiss view controller
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        //Show required alert
        [self requiredFieldAlertView];
    }
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
        //Create aspect ratio float based on height and width of image
        CGFloat aspectRatio = selectedImage.size.width / selectedImage.size.height;
        //Set max dimensions. This is height for protrait, width for landscape
        CGFloat maxDimension = 750.0f;
        CGSize newSize;
        if (selectedImage.size.width > selectedImage.size.height) {
            newSize = CGSizeMake(maxDimension, maxDimension / aspectRatio);
        } else {
            newSize = CGSizeMake(maxDimension * aspectRatio, maxDimension);
        }
        //Start graphics context
        UIGraphicsBeginImageContext(newSize);
        //ZResize image based on ratio math above
        [selectedImage drawInRect: CGRectMake(0, 0, newSize.width, newSize.height)];
        scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //NSLog(@"%@", [selectedImage description]);
        
        //Allocate asset library
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        //Save the image using asset library with block to grab URL
        [library writeImageToSavedPhotosAlbum:[selectedImage CGImage] orientation:(ALAssetOrientation)[selectedImage imageOrientation] completionBlock:^(NSURL *imageURL, NSError *error){
            if (error) {
                [self errorAlertView];
            } else {
                NSLog(@"url %@", imageURL);
                //Pass image URL
                passedImageURL = imageURL;
                [self imageSavedAlertView];
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
        [self imageSavedAlertView];
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

//Create and show required field alert
-(void)requiredFieldAlertView
{
    //Create alert
    UIAlertView *requiredFieldAlert = [[UIAlertView alloc] initWithTitle:@"Required fields missing" message:@"Make and Model fields ar required. Please fill these out before saving." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show alert
    [requiredFieldAlert show];
}

//Create and show save successful alert for image
-(void)imageSavedAlertView {
    //Create saved alert
    UIAlertView *imageSavedAlert = [[UIAlertView alloc] initWithTitle:@"Saved!" message:@"Your image was successfully saved to your album" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show saved alert
    [imageSavedAlert show];
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
