// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  ImageViewController.m
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "ImageViewController.h"
//Import add item
#import "AddItemViewController.h"
//Import asset library
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImageViewController ()

@end

@implementation ImageViewController

@synthesize passedNewImage, editedImageView;

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
    editedImageView.image = passedNewImage;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

//Triggered with save button
-(IBAction)onSave:(id)sender
{
    //UIImageWriteToSavedPhotosAlbum(passedNewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //[self dismissViewControllerAnimated:true completion:nil];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    // Request to save the image to camera roll
    [library writeImageToSavedPhotosAlbum:[passedNewImage CGImage] orientation:(ALAssetOrientation)[passedNewImage imageOrientation] completionBlock:^(NSURL *imageURL, NSError *error){
        if (error) {
            [self errorAlertView];
        } else {
            NSLog(@"url %@", imageURL);
            AddItemViewController *addItemViewController = [[AddItemViewController alloc] init];
            addItemViewController.passedImageURL = imageURL;
            [self saveSuccessfulAlertView];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

//Triggered with cancel button
-(IBAction)onCancel:(id)sender
{
    [self cancelAlertView];
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Image

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
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

#pragma mark - Alerts

//Create and show save successful alert
-(void)saveSuccessfulAlertView {
    //Create saved alert
    UIAlertView *saveSuccessfulAlert = [[UIAlertView alloc] initWithTitle:@"Saved!" message:@"Your image was successfully saved to your album" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show saved alert
    [saveSuccessfulAlert show];
}

//Create and show cancel alert
-(void)cancelAlertView {
    //Create saved alert
    UIAlertView *cancelAlert = [[UIAlertView alloc] initWithTitle:@"Cancelled" message:@"Your image was not saved to your album" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show saved alert
    [cancelAlert show];
}

//Create and show error alert view
-(void)errorAlertView {
    //Create error alert
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"An error occurred while attempting to save the image. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show error alert
    [errorAlert show];
}

@end
