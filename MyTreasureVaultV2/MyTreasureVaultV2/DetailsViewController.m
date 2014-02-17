// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  DetailsViewController.m
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

//Synthesize for getters/setters
@synthesize itemImageView, makeLabel, modelLabel, serialLabel, detailsLabel, costLabel, dateAddedLabel;
@synthesize passedItemImage, passedItemMake, passedItemModel, passedItemSerial, passedItemDetails, passedItemCost, passedItemDateAdded;

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
    //Set labels and image to passed item info
    itemImageView.image = passedItemImage;
    makeLabel.text = passedItemMake;
    modelLabel.text = passedItemModel;
    serialLabel.text = passedItemSerial;
    detailsLabel.text = passedItemDetails;
    costLabel.text = passedItemCost;
    dateAddedLabel.text = passedItemDateAdded;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

