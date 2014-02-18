// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  ImageViewController.h
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

//Declare passed image
@property (strong, nonatomic) UIImage *passedNewImage;

//Declare UIImageView
@property (strong, nonatomic) IBOutlet UIImageView *editedImageView;

//Declare IBAction for buttons
-(IBAction)onSave:(id)sender;
-(IBAction)onCancel:(id)sender;

@end
