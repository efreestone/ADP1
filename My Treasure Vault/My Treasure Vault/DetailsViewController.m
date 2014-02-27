// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  DetailsViewController.m
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "DetailsViewController.h"
//Import add item view controller
#import "AddItemViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

//Synthesize for getters/setters
@synthesize itemImageView, makeLabel, modelLabel, serialLabel, detailsLabel, costLabel, dateAddedLabel, editButton;
@synthesize passedItemImage, passedItemMake, passedItemModel, passedItemSerial, passedItemDetails, passedItemCost, passedItemDateAdded, passedManagedObject;

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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackground-568h.png"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackground~iPad.png"]]];
    }
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //NSLog(@"it works");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onEdit:(id)sender
{
    NSLog(@"Edit button clicked");
}

#pragma mark - Segue

//Built in method to pass data during segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Verify identifier of push segue to Details view
    if ([segue.identifier isEqualToString:@"ItemEdit"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //Grab destination view controllers nav
        UINavigationController *navController = segue.destinationViewController;
        AddItemViewController *addItemViewController = [[navController viewControllers] objectAtIndex:0];
        //addItemViewController.delegate = self;
        //Grab instance of recentItem object
        //Items *recentItem = [recentItemsArray objectAtIndex:indexPath.row];
        //Cast image string into UIImage
        //UIImage *itemImage = [UIImage imageNamed:recentItem.image];
        
        //Pass managed object to Add Items to be parsed and displayed in text fields
        if (addItemViewController != nil) {
            //Pass title string and NSStrings/image to detail view
            //addItemViewController.title = recentItem.model;
            //[addItemViewController.makeTextField setText: passedItemMake];
            //addItemViewController.makeTextField.text = passedItemMake;
            //addItemViewController.modelTextField.text = passedItemModel;
            //addItemViewController.serialTextField.text = passedItemSerial;
            //addItemViewController.detailsTextField.text = passedItemDetails;
            //addItemViewController.costTextField.text = passedItemCost;
            //addItemViewController.passedItemDateAdded = recentItem.formattedDate;
            addItemViewController.passedManagedObject = passedManagedObject;
        }
    }
}

@end
