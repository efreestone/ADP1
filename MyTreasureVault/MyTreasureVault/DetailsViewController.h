// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  DetailsViewController.h
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/13/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

//Declare image view
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
//Declare labels
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
@property (strong, nonatomic) NSString *passedItemDateAdded;

@end
