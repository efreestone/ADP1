// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  ImageViewController.m
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/13/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "ImageViewController.h"

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

@end
