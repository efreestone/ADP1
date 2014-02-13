// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  DetailsViewController.m
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/13/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

//Synthesize for getters/setters
@synthesize itemImageView, makeLabel, modelLabel, serialLabel, detailsLabel, costLabel, dateAddedLabel;
@synthesize passedItemImage, passedItemMake, passedItemModel, passedItemSerial, passedItemDetails, passedItemCost, passedItemDateAdded;

/*@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *makeLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelLabel;
@property (strong, nonatomic) IBOutlet UILabel *serialLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;
@property (strong, nonatomic) IBOutlet UILabel *costLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateAddedLabel;

//Declare strings and image set from view controller
@property (strong, nonatomic) UIImage *passedItemImage;
@property (strong, nonatomic) NSString *passedItemMake;
@property (strong, nonatomic) NSString *passedItemModel;
@property (strong, nonatomic) NSString *passedItemSerial;
@property (strong, nonatomic) NSString *passedItemDetails;
@property (strong, nonatomic) NSString *passedItemCost;
@property (strong, nonatomic) NSString *passedItemDateAdded;*/

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
