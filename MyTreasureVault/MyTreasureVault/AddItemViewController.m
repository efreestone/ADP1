// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  AddItemViewController.m
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/12/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "AddItemViewController.h"
//Import image view controller
#import "ImageViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController {
    ImageViewController *imageViewController;
    UIImage *selectedImage;
    UIImage *editedImage;
}

@synthesize editedImageView;

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
    [self dismissViewControllerAnimated:YES completion:nil];
	//[self.delegate addBooksViewControllerDidCancel:self];
}

//Triggered when save button is hit
-(IBAction)onSave:(id)sender
{
    //Create and display alert when save button is hit
    UIAlertView *savedAlert = [[UIAlertView alloc] initWithTitle: @"Item Would Have Saved!!" message: @"Your item would have been saved, but this bit of code hasn't been written yet." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [savedAlert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
	//[self.delegate addBooksViewControllerDidSave:self];
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
    
    selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (selectedImage != nil) {
        imageViewController.passedNewImage = selectedImage;
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
