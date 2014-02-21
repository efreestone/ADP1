// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  SettingsViewController.m
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "SettingsViewController.h"
//Import app delegate
#import "AppDelegate.h"
//Import core data subclass
#import "Items.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

//Synthesize for getters/setters
@synthesize syncAllSwitch, syncImageSwitch;

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
-(IBAction)syncAllSwitch:(id)sender
{
    if (syncAllSwitch.isOn) {
        NSLog(@"All switch is ON");
    } else {
        NSLog(@"All switch is OFF");
    }
}

//Triggered when sync image switch is changed
-(IBAction)syncImageSwitch:(id)sender
{
    NSLog(@"Image switch changed");
}

@end
