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

@interface AddItemViewController ()

@end

@implementation AddItemViewController

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
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //Set image picker delegate
        pickerController.delegate = self;
        //Set editing
        pickerController.allowsEditing = true;
        //Present picker controller in camera mode
        [self presentViewController:pickerController animated:true completion:nil];
        //NSLog(@"Camera button clicked");
    }
}

//Built in method to capture media selection
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

}

//Built in method to capture cancel button selection in picker
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //Dismiss picker view
    [picker dismissViewControllerAnimated:true completion:nil];
    //Override push to photos view. Because I am using storyboards, data pass to photos view doesn't work without prepareForSegue and the push is initiated with the album and camera buttons. Segue already occured so shouldPerformSegue won't work here.
    [self.navigationController popViewControllerAnimated:true];
}

//Make sure camera is available
/*if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    //Set source type to camera
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //Set delegate
    pickerController.delegate = self;
    //Set editing
    pickerController.allowsEditing = true;
    //Present picker controller in camera mode
    [self presentViewController:pickerController animated:true completion:nil];
    //NSLog(@"Camera button clicked");
} else {
    //Set BOOL to NO to stop segue to photos view
    shouldPushSegueOccur = NO;
    //NSLog(@"Camera not available");
}*/

@end
