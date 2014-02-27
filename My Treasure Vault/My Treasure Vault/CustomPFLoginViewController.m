//
//  CustomPFLoginViewController.m
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/26/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "CustomPFLoginViewController.h"
//Import Quartz framework
#import <QuartzCore/QuartzCore.h>

@interface CustomPFLoginViewController ()

@end

@implementation CustomPFLoginViewController

@synthesize fieldsBackground;

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
        [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackground-568h.png"]]];
        //[self.logInView setBackgroundColor:[UIColor blueColor]];
        NSLog(@"is iPhone");
        [self.logInView setLogo:nil];
        //[self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]]];
    
        // Set buttons appearance
        /*[self.logInView.logInButton setImage:nil forState:UIControlStateNormal];
         [self.logInView.logInButton setImage:nil forState:UIControlStateHighlighted];
         [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"signin-button.png"] forState:UIControlStateNormal];
         [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"signin-button-highlighted.png"] forState:UIControlStateHighlighted];
         [self.logInView.logInButton setTitle:@"" forState:UIControlStateNormal];
         [self.logInView.logInButton setTitle:@"" forState:UIControlStateHighlighted];*/
    } else {
        //[self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackground~iPad.png"]]];
        [self.logInView setLogo:nil];
        //[self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]]];
        
        // Set buttons appearance
        /*[self.logInView.logInButton setImage:nil forState:UIControlStateNormal];
         [self.logInView.logInButton setImage:nil forState:UIControlStateHighlighted];
         [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"signin-button.png"] forState:UIControlStateNormal];
         [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"signin-button-highlighted.png"] forState:UIControlStateHighlighted];
         [self.logInView.logInButton setTitle:@"" forState:UIControlStateNormal];
         [self.logInView.logInButton setTitle:@"" forState:UIControlStateHighlighted];*/
    }
    
    // Add login field background
    fieldsBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginFieldBG.png"]];
    [self.logInView insertSubview:fieldsBackground atIndex:1];
    
    // Remove text shadow
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0f;
    CALayer *labelLayer = self.logInView.signUpLabel.layer;
    labelLayer.shadowOpacity = 0.0f;
    
    // Set field text color
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:0.361 green:0.29 blue:0.337 alpha:1]]; /*#5c4a56*/
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:0.361 green:0.29 blue:0.337 alpha:1]]; /*#5c4a56*/
    [self.logInView.signUpLabel setTextColor:[UIColor colorWithRed:0.361 green:0.29 blue:0.337 alpha:1]]; /*#5c4a56*/
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//Set frames for overide items (login field, etc)
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //Check device type
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // Set frame for elements in iPhone
        //[self.logInView.dismissButton setFrame:CGRectMake(10.0f, 10.0f, 87.5f, 45.5f)];
        //[self.logInView.logo setFrame:CGRectMake(66.5f, 70.0f, 187.0f, 58.5f)];
        //[self.logInView.facebookButton setFrame:CGRectMake(35.0f, 287.0f, 120.0f, 40.0f)];
        //[self.logInView.twitterButton setFrame:CGRectMake(35.0f+130.0f, 287.0f, 120.0f, 40.0f)];
        //[self.logInView.signUpButton setFrame:CGRectMake(35.0f, 385.0f, 250.0f, 40.0f)];
        [self.logInView.usernameField setFrame:CGRectMake(35.0f, 100.0f, 250.0f, 50.0f)];
        [self.logInView.passwordField setFrame:CGRectMake(35.0f, 150.0f, 250.0f, 50.0f)];
        [self.fieldsBackground setFrame:CGRectMake(35.0f, 100.0f, 250.0f, 100.0f)];
        [self.logInView.logInButton setFrame:CGRectMake(35.0f, 210.0f, 250.0f, 40.0f)];
        [self.logInView.passwordForgottenButton setFrame:CGRectMake(19.0f, 125.0f, 18.0f, 47.0f)];
        [self.logInView.signUpLabel setFrame:CGRectMake(35.0f, 265.0f, 250.0f, 40.0f)];
        [self.logInView.signUpButton setFrame:CGRectMake(35.0f, 300.0f, 250.0f, 40.0f)];
    } else {
        //[self.logInView.dismissButton setFrame:CGRectMake(10.0f, 10.0f, 87.5f, 45.5f)];
        //[self.logInView.logo setFrame:CGRectMake(66.5f, 70.0f, 187.0f, 58.5f)];
        //[self.logInView.facebookButton setFrame:CGRectMake(35.0f, 287.0f, 120.0f, 40.0f)];
        //[self.logInView.twitterButton setFrame:CGRectMake(35.0f+130.0f, 287.0f, 120.0f, 40.0f)];
        //[self.logInView.signUpButton setFrame:CGRectMake(35.0f, 385.0f, 250.0f, 40.0f)];
        [self.logInView.usernameField setFrame:CGRectMake(260.0f, 412.0f, 250.0f, 50.0f)];
        [self.logInView.passwordField setFrame:CGRectMake(260.0f, 460.0f, 250.0f, 50.0f)];
        [self.fieldsBackground setFrame:CGRectMake(258.0f, 410.0f, 250.0f, 100.0f)];
        //[self.logInView.logInButton setFrame:CGRectMake(258.0f, 515.0f, 250.0f, 45.0f)];
        [self.logInView.passwordForgottenButton setFrame:CGRectMake(240.0f, 435.0f, 20.0f, 50.0f)];
        //[self.logInView.signUpLabel setFrame:CGRectMake(258.0f, 450.0f, 250.0f, 45.0f)];
        //[self.logInView.signUpButton setFrame:CGRectMake(35.0f, 300.0f, 250.0f, 40.0f)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
