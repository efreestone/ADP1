// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  DetailsViewController.h
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>
//
#import "AddItemViewController.h"

@interface DetailsViewController : UIViewController //<AddItemViewControllerDelegate>

//Declare image view
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
//Declare labels
@property (strong, nonatomic) IBOutlet UILabel *makeLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelLabel;
@property (strong, nonatomic) IBOutlet UILabel *serialLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;
@property (strong, nonatomic) IBOutlet UILabel *costLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateAddedLabel;
//Declare edit button
@property (strong, nonatomic) IBOutlet UIButton *editButton;

//Declare strings and image set from view controller
@property (strong, nonatomic) UIImage *passedItemImage;
@property (strong, nonatomic) NSString *passedItemMake;
@property (strong, nonatomic) NSString *passedItemModel;
@property (strong, nonatomic) NSString *passedItemSerial;
@property (strong, nonatomic) NSString *passedItemDetails;
@property (strong, nonatomic) NSString *passedItemCost;
@property (strong, nonatomic) NSString *passedItemDateAdded;
//Declare passed managed object
@property (strong, nonatomic) NSManagedObject *passedManagedObject;

//Declare onClick method for edit
-(IBAction)onEdit:(id)sender;

@end
