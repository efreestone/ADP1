// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  LoginViewController.m
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/13/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

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

-(IBAction)onSignIn:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(IBAction)onCancel:(id)sender
{
    //Create and show error alert
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please Sign In or Register to use this application" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show alert
    [errorAlert show];
}

-(IBAction)onRegister:(id)sender
{
    //Create and show alert
    UIAlertView *registerAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"This would open a web view with a signup sheet, however no web interface is built yet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Show alert
    [registerAlert show];
}

@end
