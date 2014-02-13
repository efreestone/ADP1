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
-(IBAction)onCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
	//[self.delegate addBooksViewControllerDidCancel:self];
}

//Triggered when save button is hit
-(IBAction)onSave:(id)sender{
    //Create and display alert when save button is hit
    UIAlertView *savedAlert = [[UIAlertView alloc] initWithTitle: @"Item Would Have Saved!!" message: @"Your item would have been saved, but this bit of code hasn't been written yet." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [savedAlert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
	//[self.delegate addBooksViewControllerDidSave:self];
}

@end
